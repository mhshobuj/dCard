import 'package:dma_card/res/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class ForgotPasswordDialog extends StatefulWidget {
  @override
  _ForgotPasswordDialogState createState() => _ForgotPasswordDialogState();
}

class _ForgotPasswordDialogState extends State<ForgotPasswordDialog> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier(true);
  bool _isLoading = false;
  bool _showResetForm = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Forgot Password'),
      content: SingleChildScrollView(
        // Wrap content in SingleChildScrollView
        child: SizedBox(
          // Use SizedBox to set a fixed height
          height: _showResetForm ? 250.0 : null,
          // Set a fixed height only when showing the reset form
          child: _showResetForm
              ? Column(
                  children: [
                    TextFormField(
                      controller: _otpController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Enter OTP',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _newPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obsecurePassword.value,
                      obscuringCharacter: '*',
                      decoration: const InputDecoration(
                        labelText: 'Enter New Password',
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmPasswordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _obsecurePassword.value,
                      obscuringCharacter: '*',
                      decoration: const InputDecoration(
                        labelText: 'Confirm New Password',
                      ),
                    ),
                  ],
                )
              : TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Enter your email/phone to verify',
                  ),
                ),
        ),
      ),
      actions: [
        _showResetForm
            ? ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        // Add your logic to handle password reset here
                        setState(() {
                          _isLoading = true;
                        });
                        // Dismiss the keyboard
                        FocusScope.of(context).unfocus();
                        await resetPassword(context);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Reset Password',
                        style: TextStyle(color: Colors.white),
                      ),
              )
            : ElevatedButton(
                onPressed: _isLoading
                    ? null
                    : () async {
                        // Add your logic to handle verifying the email here
                        setState(() {
                          _isLoading = true;
                        });
                        userVerify(context);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : const Text(
                        'Verify',
                        style: TextStyle(color: Colors.white),
                      ),
              ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _otpController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    _obsecurePassword.dispose();
    super.dispose();
  }

  void userVerify(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    if (_emailController.text.isEmpty) {
      Utils.flushBarErrorMessage("The email/phone is required!", context);
      setState(() {
        _isLoading = false;
      });
    } else {
      final Map<String, String> data = {
        'email_or_phone': _emailController.text.toString(),
      };
      final forgetPass = await authViewModel.forgetPassVerify(data, context);
      if (forgetPass.statusCode == 200) {
        setState(() {
          _showResetForm = true;
          _isLoading = false;
        });
      }
    }
  }

  Future<void> resetPassword(BuildContext context) async {
    // Add your logic to handle password reset
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    if (_otpController.text.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      Utils.flushBarErrorMessage("The OTP is required!", context);
    } else if (_newPasswordController.text.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      Utils.flushBarErrorMessage(
          "The new password is required!", context);
    } else if (_newPasswordController.text.length < 8) {
      setState(() {
        _isLoading = false;
      });
      Utils.flushBarErrorMessage(
          "The new password must have 8 digit!", context);
    } else if (_confirmPasswordController.text.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      Utils.flushBarErrorMessage(
          "The confirm password is required!", context);
    } else if (_confirmPasswordController.text.length < 8) {
      setState(() {
        _isLoading = false;
      });
      Utils.flushBarErrorMessage(
          "The confirm password must have 8 digit!", context);
    } else{
      final Map<String, String> data = {
        'email_or_phone': _emailController.text.toString(),
        'otp': _otpController.text.toString(),
        'password': _confirmPasswordController.text.toString(),
      };
      if(_newPasswordController.text.toString() == _confirmPasswordController.text.toString()){
        final resetPass = await authViewModel.resetPass(data, context);
        if (resetPass.statusCode == 200) {
          setState(() {
            _isLoading = false;
          });
          Navigator.pop(context);
          Utils.flushBarErrorMessage(resetPass.message.toString(), context);
        }
      }else{
        setState(() {
          _isLoading = false;
        });
        Utils.flushBarErrorMessage("Please enter the same password", context);
      }
    }
  }
}


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/color.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';
import '../../view_model/login_view_model.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({Key? key}) : super(key: key);

  @override
  _ChangePasswordDialogState createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Change Password'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _oldPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Old Password',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _newPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'New Password',
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _confirmPasswordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Confirm New Password',
              ),
            ),
          ],
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: _isLoading ? null : _submit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.buttonColor, // Use your desired button color
          ),
          child: _isLoading
              ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
              : const Text('Submit'),
        ),
      ],
    );
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });
    setChangePassword(context);
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> setChangePassword(BuildContext context) async {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);
    if (_oldPasswordController.text.isEmpty) {
      setState(() {
        _isLoading = false;
      });
      Utils.flushBarErrorMessage("The Old Password is required!", context);
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
        'old_password': _oldPasswordController.text.toString(),
        'new_password': _newPasswordController.text.toString(),
      };
      if(_newPasswordController.text.toString() == _confirmPasswordController.text.toString()){
        tokenViewModel.getToken().then((loginModel) async {
          final token = loginModel.token;
          final changePass = await authViewModel.changePass(token!, data, context);
          if (changePass.statusCode == 200) {
            setState(() {
              _isLoading = false;
            });
            //_logout(context, tokenViewModel);
            Navigator.pop(context);
            Utils.flushBarErrorMessage(changePass.message.toString(), context);
          }
        }).catchError((error) {
          if (kDebugMode) {
            print(error);
          }
          // Handle error here
        });
      }else{
        setState(() {
          _isLoading = false;
        });
        Utils.flushBarErrorMessage("Please enter the same password", context);
      }
    }
  }

  void _logout(BuildContext context, TokenViewModel tokenViewModel) {
    // Implement your logout logic here
    // For example, you can clear user authentication token, navigate to login screen, etc.
    // Once logged out, navigate to the login screen
    tokenViewModel.remove();
    Navigator.pushNamedAndRemoveUntil(
        context, RoutesName.login, (route) => false);
  }
}

import 'package:flutter/material.dart';

import '../color.dart';

class OtpPopup extends StatefulWidget {
  final ValueNotifier<bool>
      isVerified; // Pass isVerifiedNotifier for verification feedback
  final Function(String) onSubmit; // Callback function for OTP submission

  const OtpPopup({Key? key, required this.isVerified, required this.onSubmit})
      : super(key: key);

  @override
  State<OtpPopup> createState() => _OtpPopupState();
}

class _OtpPopupState extends State<OtpPopup> {
  final List<TextEditingController> _otpControllers =
      List.generate(6, (index) => TextEditingController());
  bool _isSubmitting = false; // Track submission state for button disabling

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 8.0,
      title: const Text('Enter OTP'),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
      content: SizedBox(
        width: MediaQuery.of(context).size.width *
            0.8, // Adjust the width as needed
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < 6; i++)
                  SizedBox(
                    width: MediaQuery.of(context).size.width *
                        0.1, // Adjust the width as needed
                    height: 60.0,
                    child: _OtpBox(
                      index: i,
                      controller: _otpControllers[i],
                      focusNode: i == 0
                          ? FocusNode()
                          : null, // Set focus only for the first box
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 40.0),
            _isSubmitting
                ? const CircularProgressIndicator(
                    color: AppColors.buttonColor,
                    strokeWidth: 3,
                  )
                : ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        _isSubmitting = true;
                      });
                      // Simulate verification process
                      await Future.delayed(const Duration(seconds: 2));
                      widget.onSubmit(_otpControllers
                          .map((controller) => controller.text)
                          .join());
                      setState(() {
                        _isSubmitting = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.buttonColor,
                      // Set the background color
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      minimumSize: const Size(120.0, 48.0),
                    ),
                    child: const Text(
                      'Verify',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class _OtpBox extends StatefulWidget {
  final int index;
  final TextEditingController controller;
  final FocusNode? focusNode;

  const _OtpBox(
      {Key? key, required this.index, required this.controller, this.focusNode})
      : super(key: key);

  @override
  _OtpBoxState createState() => _OtpBoxState();
}

class _OtpBoxState extends State<_OtpBox> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && widget.controller.text.isEmpty) {
      // Automatically select all text when the box gains focus if it's empty
      widget.controller.selection = TextSelection(
          baseOffset: 0, extentOffset: widget.controller.text.length);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 45.0,
      height: 60.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: TextFormField(
        controller: widget.controller,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 24),
        maxLength: 1,
        cursorColor: AppColors.buttonColor,
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          hintText: '0',
          hintStyle:
              TextStyle(color: Colors.grey), // Set the hint text color to gray
        ),
        focusNode: _focusNode,
        onChanged: (value) {
          if (value.isNotEmpty && widget.index < 5) {
            // Move focus to the next box
            FocusScope.of(context).nextFocus();
          }
          if (value.isNotEmpty && widget.index == 5) {
            // Hide the keyboard after all boxes are filled
            FocusScope.of(context).unfocus();
          }
        },
      ),
    );
  }
}

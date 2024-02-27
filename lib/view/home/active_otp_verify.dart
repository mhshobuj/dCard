import 'package:flutter/material.dart';

class OTPDialog extends StatelessWidget {

  const OTPDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Enter OTP'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          TextField(
            maxLength: 6,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter OTP',
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            // Add your verify logic here
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Verify'),
        ),
      ],
    );
  }
}
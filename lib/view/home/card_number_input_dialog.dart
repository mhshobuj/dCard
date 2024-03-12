import 'package:flutter/material.dart';

import '../../res/color.dart';

class CreditCardNumberDialog extends StatefulWidget {
  @override
  _CreditCardNumberDialogState createState() => _CreditCardNumberDialogState();
}

class _CreditCardNumberDialogState extends State<CreditCardNumberDialog> {
  final _formKey = GlobalKey<FormState>();
  String _cardNumber = ''; // No pre-filled value

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Enter Your 16-digit Card Number',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold), // Adjust as needed
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              maxLength: 16, // Adjusted to account for spaces
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'XXXX XXXX XXXX XXXX', // Pre-formatted hint with spaces
                counterText: '', // Hide character counter
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor!),
                ), // Set border color on focus
              ),
              validator: (value) {
                // Remove spaces before validation
                final noSpaces = value!.replaceAll(' ', '');
                if (noSpaces.length != 16) {
                  return 'Please enter a valid 16-digit card number.';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  // Remove spaces before formatting to avoid extra spaces
                  _cardNumber = value.replaceAll('','');

                  // Format with spaces using a regular expression
                  final formatted = _cardNumber.replaceAllMapped(
                    RegExp(r'.{4}'),
                        (match) => '${match.group(0)} ',
                  );

                  // Remove any trailing space to ensure correct length
                  _cardNumber = formatted.trim();
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(fontSize: 16), // Adjust as needed
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pop(_cardNumber);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Adjust as needed
                    ),
                  ),
                  child: const Text(
                    'Activate',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Adjust as needed
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}








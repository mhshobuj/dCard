import 'package:flutter/material.dart';

import '../../res/color.dart';

class CreditCardNumberDialog extends StatefulWidget {
  final Function onPressed;

  CreditCardNumberDialog({required this.onPressed});

  @override
  _CreditCardNumberDialogState createState() => _CreditCardNumberDialogState();
}

class _CreditCardNumberDialogState extends State<CreditCardNumberDialog> {
  final _formKey = GlobalKey<FormState>();
  String _cardNumber = ''; // No pre-filled value
  bool _isLoading = false; // Loading indicator flag

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Enter Your 16-digit Card Number',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              maxLength: 16,
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 16),
              decoration: InputDecoration(
                hintText: 'XXXX XXXX XXXX XXXX',
                counterText: '', // Hide character counter
                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Theme.of(context).primaryColor!),
                ),
              ),
              validator: (value) {
                final noSpaces = value!.replaceAll(' ', '');
                if (noSpaces.length != 16) {
                  return 'Please enter a valid 16-digit card number.';
                }
                return null;
              },
              onChanged: (value) {
                setState(() {
                  _cardNumber = value.replaceAll(' ', '');
                  final formatted = _cardNumber.replaceAllMapped(
                    RegExp(r'.{4}'),
                        (match) => '${match.group(0)} ',
                  );
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
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                    // Dismiss the keyboard
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _isLoading = true; // Start loading indicator
                      });
                      // Call the onPressed callback passed from the parent widget
                      await widget.onPressed(_cardNumber);
                      // No need to setState here, as we want the loading indicator to persist until the callback is completed
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _isLoading ? Colors.transparent : AppColors.buttonColor, // Change button color to transparent when isLoading is true
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Loading indicator (conditionally shown)
                      if (_isLoading)
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent, // Set background color to transparent when isLoading is true
                            borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
                          ),
                          width: 40,
                          height: 40,
                          child: const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(AppColors.buttonColor),
                              ),
                            ),
                          ),
                        ),
                      // Text (conditionally hidden)
                      Opacity(
                        opacity: _isLoading ? 0.0 : 1.0, // Hide text when isLoading is true
                        child: const Text(
                          'Activate',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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








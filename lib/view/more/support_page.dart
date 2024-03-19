import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/color.dart';

class SupportPage extends StatelessWidget {
  final String phoneNumber = '01981811552';
  final String emailAddress = 'info@dma-bd.com';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Support',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/images/customer_service.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 50),
              Text(
                phoneNumber,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              buildContactButton(
                text: 'Call Support',
                icon: Icons.phone,
                onPressed: () => _callPhoneNumber(phoneNumber),
              ),
              const SizedBox(height: 50),
              Text(
                emailAddress,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              buildContactButton(
                text: 'Send Email',
                icon: Icons.email,
                onPressed: () => _sendEmail(emailAddress),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContactButton({
    required String text,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  Future<void> _callPhoneNumber(String phoneNumber) async {
     // Create a tel URL with the phone number
    final url = Uri(scheme: 'tel',path: phoneNumber);
    launchUrl(url);

    //for direct call
    /*String number = phoneNumber;
    await FlutterPhoneDirectCaller.callNumber(number);*/
  }

  Future<void> _sendEmail(String emailAddress) async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
      '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: emailAddress,
      query: encodeQueryParameters(<String, String>{
        'subject': 'Massage for dCard Flutter app',
      }),
    );
    launchUrl(emailLaunchUri);
  }
}
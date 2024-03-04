import 'package:flutter/material.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final int currentYear = DateTime.now().year;
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          // Profile card
          const SizedBox(height: 20),
          Center(
            child: Card(
              elevation: 3,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        SizedBox(
                          height: 100, // Adjust height as needed
                          width: 100, // Adjust width as needed
                          child: CircleAvatar(
                            // Replace 'profileImageUrl' with the actual URL of the profile picture
                            backgroundImage: NetworkImage('profileImageUrl'),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    // Username TextFormField
                    const Text(
                      'John Doe',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    // Email TextFormField
                    const Text(
                      'johndoe@example.com',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Other list items
          _buildListItem(context, 'FAQ', Icons.help_outline, () {
            Utils.flushBarErrorMessage("Under Development", context);
          }),
          _buildListItem(context, 'Support', Icons.support, () {
            Utils.flushBarErrorMessage("Under Development", context);
          }),
          _buildListItem(context, 'About', Icons.info_outline, () {
            Utils.flushBarErrorMessage("Under Development", context);
          }),
          _buildListItem(context, 'Change Password', Icons.security_outlined, () {
            Utils.flushBarErrorMessage("Under Development", context);
          }),
          _buildListItem(context, 'Logout', Icons.logout, () {
            _logout(context);
          }),
          const SizedBox(height: 20),
          // Copyright notice
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Copyright © $currentYear Datasoft Manufacturing & Assembly Inc. Limited. All Rights Reserved.',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildListItem(BuildContext context, String title, IconData icon, Function onTap) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
        ),
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          trailing: const Icon(Icons.arrow_forward_ios), // Add arrow icon
        ),
      ),
    );
  }

  void _logout(BuildContext context) {
    // Implement your logout logic here
    // For example, you can clear user authentication token, navigate to login screen, etc.
    // Once logged out, navigate to the login screen
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);
  }
}
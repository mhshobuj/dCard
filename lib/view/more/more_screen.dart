import 'package:flutter/material.dart';

import '../../res/color.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/login_view_model.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {

  final TokenViewModel _loginViewModel = TokenViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: const Text('More'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              // Call the logout method here
              logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  void logout() {
    // Implement your logout logic here
    // For example, you can clear user authentication token, navigate to login screen, etc.
    _loginViewModel.remove();
    Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false);
  }
}


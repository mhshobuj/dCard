import 'package:dma_card/utils/utils.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: (){
            Utils.flushBarErrorMessage("not internet", context);
            //Utils.snackBar("not internet", context);
            Utils.toastMessage('Login_page');
            //Navigator.pushNamed(context, RoutesName.home);
            //Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
          },
          child: const Text("Click to redirect home"),
        ),
      ),
    );
  }
}


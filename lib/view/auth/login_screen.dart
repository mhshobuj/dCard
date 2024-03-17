import 'package:dma_card/res/components/round_button.dart';
import 'package:dma_card/utils/routes/routes_name.dart';
import 'package:dma_card/utils/utils.dart';
import 'package:dma_card/view_model/auth_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'forgot_password_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier(true);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _obsecurePassword.dispose();

    _emailController.dispose();
    _passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final authViewMode = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height * 1;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                focusNode: emailFocusNode,
                decoration: InputDecoration(
                  labelText: 'Email/Phone',
                  hintText: 'Enter email or phone',
                  prefixIcon: const Icon(Icons.supervised_user_circle_outlined),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, emailFocusNode, passwordFocusNode);
                },
              ),
            ),
            const SizedBox(height: 15.0), // Add space between fields
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
                focusNode: passwordFocusNode,
                obscureText: _obsecurePassword.value,
                obscuringCharacter: '*',
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password',
                  prefixIcon: const Icon(Icons.lock_clock_outlined),
                  suffixIcon: InkWell(
                    onTap: () {
                      setState(() {
                        _obsecurePassword.value = !_obsecurePassword.value;
                      });
                    },
                    child: Icon(
                      _obsecurePassword.value
                          ? Icons.visibility_off_outlined
                          : Icons.visibility,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black, width: 2.0),
                  ),
                ),
              ),
            ),
            // Forgot Password button
            Align(
              alignment: Alignment.centerRight,
              child: InkWell(
                onTap: () {
                  // Add your logic for forgot password here
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return ForgotPasswordDialog();
                    },
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.075),
            RoundButton(
              title: "Login",
              loading: authViewMode.loginLoading,
              onPress: () async {
                if (_emailController.text.isEmpty) {
                  Utils.flushBarErrorMessage("The email/phone is required!", context);
                } else if (_passwordController.text.isEmpty) {
                  Utils.flushBarErrorMessage(
                      "The password is required!", context);
                } else if (_passwordController.text.length < 8) {
                  Utils.flushBarErrorMessage(
                      "The password must have 8 digit!", context);
                } else {
                  final Map<String, String> data = {
                    'usr_email': _emailController.text.toString(),
                    'password': _passwordController.text.toString(),
                  };
                  authViewMode.loginApi(data, context).then((loginResponse) async {
                    if(loginResponse.statusCode == 200){
                      Navigator.pushNamedAndRemoveUntil(context, RoutesName.landing, (route) => false);
                    }
                  }).catchError((error) {
                    if (kDebugMode) {
                      print(error);
                    }
                  });
                }
              },
            ),
            SizedBox(height: height * 0.02),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, RoutesName.signUp);
              },
                child: const Text("Don't have a card? Apply Card")),
          ],
        ),
      ),
    );
  }
}

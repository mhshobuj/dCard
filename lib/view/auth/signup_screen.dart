import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../res/color.dart';
import '../../res/components/otp_popup.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/auth_view_model.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final ValueNotifier<bool> _obsecurePassword = ValueNotifier(true);

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  FocusNode firstNameFocusNode = FocusNode();
  FocusNode lastNameFocusNode = FocusNode();
  FocusNode emailFocusNode = FocusNode();
  FocusNode phoneFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  String _selectedGender = 'male';
  DateTime? _selectedDate;
  bool isTermsAccepted = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    _obsecurePassword.dispose();

    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();

    firstNameFocusNode.dispose();
    lastNameFocusNode.dispose();
    emailFocusNode.dispose();
    phoneFocusNode.dispose();
    passwordFocusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authViewMode = Provider.of<AuthViewModel>(context);
    ValueNotifier<bool> isVerifiedNotifier = ValueNotifier(false);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _firstNameController,
                  keyboardType: TextInputType.name,
                  focusNode: firstNameFocusNode,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelText: 'First Name',
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintText: 'Enter first name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColors.buttonColor, width: 2.0), // Set border color when focused
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, firstNameFocusNode, lastNameFocusNode);
                  },
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _lastNameController,
                  keyboardType: TextInputType.name,
                  focusNode: lastNameFocusNode,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintText: 'Enter Last name',
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColors.buttonColor, width: 2.0), // Set border color when focused
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, lastNameFocusNode, emailFocusNode);
                  },
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  focusNode: emailFocusNode,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintText: 'Enter email',
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColors.buttonColor, width: 2.0), // Set border color when focused
                    ),
                  ),
                  onFieldSubmitted: (value) {
                    Utils.fieldFocusChange(
                        context, emailFocusNode, phoneFocusNode);
                  },
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  focusNode: phoneFocusNode,
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    labelStyle: const TextStyle(color: Colors.grey),
                    hintText: 'Enter phone number',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColors.buttonColor, width: 2.0), // Set border color when focused
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5.0),
              // Gender selection
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Text("Gender:"),
                    const SizedBox(width: 10),
                    Radio(
                      value: 'male',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                      activeColor: AppColors.buttonColor,
                    ),
                    const Text("Male"),
                    const SizedBox(width: 10),
                    Radio(
                      value: 'female',
                      groupValue: _selectedGender,
                      onChanged: (value) {
                        setState(() {
                          _selectedGender = value!;
                        });
                      },
                      activeColor: AppColors.buttonColor,
                    ),
                    const Text("Female"),
                  ],
                ),
              ),
              const SizedBox(height: 15.0), // Adjust spacing as needed
              // Birthday selection
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Text("Birthday:"),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          final selectedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(1900),
                            lastDate: DateTime.now(),
                            builder: (BuildContext context, Widget? child) {
                              return Theme(
                                data: ThemeData.light().copyWith(
                                  primaryColor: AppColors.buttonColor,
                                  buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary), colorScheme: const ColorScheme.light(primary: AppColors.buttonColor).copyWith(secondary: AppColors.buttonColor),
                                ),
                                child: child!,
                              );
                            },
                          );
                          if (selectedDate != null) {
                            setState(() {
                              _selectedDate = selectedDate;
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.buttonColor, // Set your desired button color
                        ),
                        child: Text(
                          style: const TextStyle(color: Colors.white),
                          _selectedDate != null
                              ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
                              : 'Choose Birthday',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0), // Add space between fields
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  focusNode: passwordFocusNode,
                  obscureText: _obsecurePassword.value,
                  obscuringCharacter: '*',
                  cursorColor: Colors.grey,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.grey),
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
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: AppColors.buttonColor, width: 2.0), // Set border color when focused
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5.0), // Add space between fields
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Checkbox(
                      value: isTermsAccepted,
                      onChanged: (value) {
                        setState(() {
                          isTermsAccepted = value!;
                        });
                      },
                      activeColor: AppColors.buttonColor,
                    ),
                    const Text(
                        'I agree to the Terms & Conditions and Privacy Policy'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              RoundButton(
                title: "Next",
                loading: authViewMode.otpSendLoading,
                onPress: () async {
                  if (_firstNameController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "The first name is required!", context);
                  } else if (_emailController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "The email is required!", context);
                  } else if (_phoneController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "The phone is required!", context);
                  } else if (_selectedDate == null) {
                    Utils.flushBarErrorMessage(
                        "Please select your birthday.", context);
                  } else if (_passwordController.text.isEmpty) {
                    Utils.flushBarErrorMessage(
                        "The password is required!", context);
                  } else if (_passwordController.text.length < 8) {
                    Utils.flushBarErrorMessage(
                        "The password must have 8 digit!", context);
                  } else if (!isTermsAccepted) {
                    Utils.flushBarErrorMessage(
                        "Please agree with the terms and conditions", context);
                  } else {
                    await sendOtp(context, authViewMode, isVerifiedNotifier);
                  }
                },
              ),
              const SizedBox(height: 20),
              InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.login);
                  },
                  child: const Text("Already have a card? Login")),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  sendOtp(BuildContext context, AuthViewModel authViewMode, ValueNotifier<bool> isVerifiedNotifier) {
    final Map<String, String> data = {
      'phone': _phoneController.text.toString(),
      'email': _emailController.text.toString()
    };
    authViewMode.sendOTPApi(data, context);
    showDialog(
      context: context,
      builder: (context) => OtpPopup(
        isVerified: isVerifiedNotifier,
        // Pass isVerifiedNotifier
        onSubmit: (otp) async {
          // Convert the DateTime object to a string using DateFormat
          final formattedDate =
          DateFormat('yyyy-MM-dd').format(_selectedDate!);
          final Map<String, String> data = {
            'first_name': _firstNameController.text.toString(),
            'last_name': _lastNameController.text.toString(),
            'usr_email': _emailController.text.toString(),
            'phone': _phoneController.text.toString(),
            'gender': _selectedGender,
            'password': _passwordController.text.toString(),
            'otp': otp,
            'birth_date': formattedDate,
          };
          authViewMode.signUpApi(data, context).then((signUpResponse) async {
            if(signUpResponse.statusCode == 200){
              await logIn(context, authViewMode, _phoneController.text.toString(), _passwordController.text.toString()); // Perform sign-up operation
            }
          }).catchError((error) {
            if (kDebugMode) {
              print(error);
            }
          });
        },
      ),
    );
  }

  logIn(BuildContext context, AuthViewModel authViewMode, String phone, String pass) {
    final Map<String, String> data = {
      'usr_email': phone,
      'password': pass,
    };
    authViewMode.loginApi(data, context).then((loginResponse) async {
      if(loginResponse.statusCode == 200){
        Navigator.pushNamedAndRemoveUntil(context, RoutesName.apply, (route) => false);
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
    });
  }
}

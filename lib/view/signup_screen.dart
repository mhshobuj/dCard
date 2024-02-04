import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../res/color.dart';
import '../res/components/round_button.dart';
import '../utils/routes/routes_name.dart';
import '../utils/utils.dart';
import '../view_model/auth_view_model.dart';

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

     return Scaffold(
         appBar: AppBar(
           backgroundColor: AppColors.backgroundColor,
           title: const Text('SignUp'),
           centerTitle: true,
         ),
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
                     decoration: InputDecoration(
                       labelText: 'First Name',
                       hintText: 'Enter first name',
                       prefixIcon: const Icon(Icons.person),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20),
                         borderSide: const BorderSide(color: Colors.black, width: 2.0),
                       ),
                     ),
                     onFieldSubmitted: (value) {
                       Utils.fieldFocusChange(context, firstNameFocusNode, lastNameFocusNode);
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
                     decoration: InputDecoration(
                       labelText: 'Last Name',
                       hintText: 'Enter Last name',
                       prefixIcon: const Icon(Icons.person),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20),
                         borderSide: const BorderSide(color: Colors.black, width: 2.0),
                       ),
                     ),
                     onFieldSubmitted: (value) {
                       Utils.fieldFocusChange(context, lastNameFocusNode, emailFocusNode);
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
                     decoration: InputDecoration(
                       labelText: 'Email',
                       hintText: 'Enter email',
                       prefixIcon: const Icon(Icons.email_outlined),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20),
                         borderSide: const BorderSide(color: Colors.black, width: 2.0),
                       ),
                     ),
                     onFieldSubmitted: (value) {
                       Utils.fieldFocusChange(context, emailFocusNode, phoneFocusNode);
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
                     decoration: InputDecoration(
                       labelText: 'Phone',
                       hintText: 'Enter phone number',
                       prefixIcon: const Icon(Icons.phone),
                       border: OutlineInputBorder(
                         borderRadius: BorderRadius.circular(20),
                         borderSide: const BorderSide(color: Colors.black, width: 2.0),
                       ),
                     ),
                     onFieldSubmitted: (value) {
                       Utils.fieldFocusChange(context, phoneFocusNode, passwordFocusNode);
                     },
                   ),
                 ),
                 const SizedBox(height: 5.0),
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
                       ),
                       const Text("Female"),
                     ],
                   ),
                 ),
                 const SizedBox(height: 15.0), // Adjust spacing as needed
                 Padding(
                   padding: const EdgeInsets.all(10.0),
                   child: Row(
                     children: [
                       const Text("Birthday:"),
                       const SizedBox(width: 10),
                       Expanded( // Allow expansion for date picker
                         child: ElevatedButton(
                           onPressed: () async {
                             final selectedDate = await showDatePicker(
                               context: context,
                               initialDate: DateTime.now(),
                               firstDate: DateTime(1900),
                               lastDate: DateTime.now(),
                             );
                             if (selectedDate != null) {
                               setState(() {
                                 _selectedDate = selectedDate;
                               });
                             }
                           },
                           child: Text(
                             _selectedDate != null
                                 ? DateFormat('dd-MM-yyyy').format(_selectedDate!)
                                 : 'Choose Birthday',
                           ),
                         ),
                       ),
                     ],
                   ),
                 ),
                 const SizedBox(height: 5.0),// Add space between fields
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
                       ),
                       const Text('I agree to the Terms & Conditions and Privacy Policy'),
                     ],
                   ),
                 ),
                 const SizedBox(height: 20),
                 RoundButton(
                   title: "SignUp",
                   loading: authViewMode.signUpLoading,
                   onPress: (){
                       if (_emailController.text.isEmpty) {
                         Utils.flushBarErrorMessage("The email/phone is required!", context);
                       } else if (_passwordController.text.isEmpty) {
                         Utils.flushBarErrorMessage(
                             "The password is required!", context);
                       } else if (_passwordController.text.length < 8) {
                         Utils.flushBarErrorMessage(
                             "The password must have 8 digit!", context);
                       } else if(!isTermsAccepted){
                         Utils.flushBarErrorMessage("Please agree with the terms and conditions", context);
                       }else {
                         final Map<String, String> data = {
                           'usr_email': _emailController.text.toString(),
                           'password': _passwordController.text.toString(),
                         };
                         //authViewMode.loginApi(data, context);
                       }
                   },
                 ),
                 const SizedBox(height: 20),
                 InkWell(
                     onTap: (){
                       Navigator.pushNamed(context, RoutesName.login);
                     },
                     child: const Text("Already have an account? Login")),
                 const SizedBox(height: 20),
               ],
             ),
           ),
         ),
       );
   }
 }
 
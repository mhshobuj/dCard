import 'package:flutter/material.dart';

import '../../res/color.dart';
import '../../res/components/round_button.dart';

class ApplyCardScreen extends StatefulWidget {
  const ApplyCardScreen({Key? key}) : super(key: key);

  @override
  State<ApplyCardScreen> createState() => _ApplyCardScreenState();
}

class _ApplyCardScreenState extends State<ApplyCardScreen> {

  String _selectedPayment = 'Cash';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Apply for Card',
          style: TextStyle(
            color: Colors.white, // Text color
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true, // Center the title
        backgroundColor: AppColors.buttonColor, // Set background color
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Preferred Card Name',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter preferred card name',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Address',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Enter your address',
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Choice your area',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButtonFormField<String>(
                items: ['Dhanmondi', 'Gulshan-2', 'Uttara']
                    .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
                    .toList(),
                onChanged: (String? newValue) {
                  // Handle dropdown value change
                },
              ),
              SizedBox(height: 20),
              Text(
                'Choice card pickup outlet',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButtonFormField<String>(
                items: ['Crimson Cup Banani 11', 'Crimson Cup Bashundhara', 'Crimson Cup Dhanmondi 2', 'Crimson Cup Dhanmondi 27',
                   'Crimson Cup Gulshan 1', 'Crimson Cup Mirpur 1', 'Crimson Cup Mirpur 12', 'Crimson Cup Uttara-13']
                    .map((String value) => DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                ))
                    .toList(),
                onChanged: (String? newValue) {
                  // Handle dropdown value change
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  const Text("Select Payment Method:"),
                  const SizedBox(width: 10),
                  Radio(
                    value: 'cash',
                    groupValue: _selectedPayment,
                    onChanged: (value) {
                      setState(() {
                        _selectedPayment = value!;
                      });
                    },
                  ),
                  const Text("Cash"),
                  const SizedBox(width: 10),
                  Radio(
                    value: 'online',
                    groupValue: _selectedPayment,
                    onChanged: (value) {
                      setState(() {
                        _selectedPayment = value!;
                      });
                    },
                  ),
                  const Text("Online"),
                ],
              ),
              const SizedBox(height: 15.0), // Adjust spacing as needed
              SizedBox(height: 20),
              RoundButton(
                title: "Apply",
                //loading: authViewMode.loginLoading,
                onPress: () async {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

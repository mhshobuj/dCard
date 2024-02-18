import 'package:flutter/material.dart';

import '../../res/color.dart';
import '../../res/components/round_button.dart';
import '../../utils/utils.dart';

class ApplyCardScreen extends StatefulWidget {
  const ApplyCardScreen({Key? key}) : super(key: key);

  @override
  State<ApplyCardScreen> createState() => _ApplyCardScreenState();
}

class _ApplyCardScreenState extends State<ApplyCardScreen> {

  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  FocusNode cardFocusNode = FocusNode();
  FocusNode addressFocusNode = FocusNode();

  String _selectedPayment = '';
  String _pickedLocation = '';
  String _selectedArea = '';

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    cardFocusNode.dispose();
    addressFocusNode.dispose();
  }

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
                controller: _cardNameController,
                keyboardType: TextInputType.name,
                focusNode: cardFocusNode,
                decoration: InputDecoration(
                  hintText: 'Enter preferred card name',
                ),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, cardFocusNode, addressFocusNode);
                },
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
                controller: _addressController,
                keyboardType: TextInputType.streetAddress,
                focusNode: addressFocusNode,
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
                  _selectedArea = newValue!;
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
                  _pickedLocation = newValue!;
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
                  if (_cardNameController.text.isEmpty) {
                    Utils.flushBarErrorMessage("The preferred card name is required!", context);
                  } else if (_addressController.text.isEmpty) {
                    Utils.flushBarErrorMessage("The address is required!", context);
                  } else if (_selectedArea == '') {
                    Utils.flushBarErrorMessage(
                        "Please select your area.", context);
                  } else if (_pickedLocation == '') {
                    Utils.flushBarErrorMessage(
                        "Please select your card pickup location.", context);
                  } else if (_selectedPayment == '') {
                    Utils.flushBarErrorMessage(
                        "Please select your payment method.", context);
                  } else {
                    Utils.flushBarErrorMessage("success", context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

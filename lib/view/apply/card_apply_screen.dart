import 'package:dma_card/model/get_area_list.dart';
import 'package:dma_card/view_model/area_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  List<Data> filteredAreas = [];

  GetAreaList? getAreaResponse;
  Set<String> uniqueAreaNames = Set<String>();

  @override
  void dispose() {
    super.dispose();

    cardFocusNode.dispose();
    addressFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      getAreaList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Apply for Card',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
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
                'Select your area',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              DropdownButtonFormField<String>(
                value: _selectedArea,
                items: uniqueAreaNames.map((name) {
                  return DropdownMenuItem<String>(
                    value: name,
                    child: Text(name),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedArea = newValue!;
                  });
                },
              ),
              SizedBox(height: 20),
              Text(
                'Select card pickup outlet',
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
                  setState(() {
                    _pickedLocation = newValue!;
                  });
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
              const SizedBox(height: 15.0),
              SizedBox(height: 20),
              RoundButton(
                title: "Apply",
                onPress: () async {
                  if (_cardNameController.text.isEmpty) {
                    Utils.flushBarErrorMessage("The preferred card name is required!", context);
                  } else if (_addressController.text.isEmpty) {
                    Utils.flushBarErrorMessage("The address is required!", context);
                  } else if (_selectedArea.isEmpty) {
                    Utils.flushBarErrorMessage("Please select your area.", context);
                  } else if (_pickedLocation.isEmpty) {
                    Utils.flushBarErrorMessage("Please select your card pickup location.", context);
                  } else if (_selectedPayment.isEmpty) {
                    Utils.flushBarErrorMessage("Please select your payment method.", context);
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

  void getAreaList() {
    final areaViewModel = Provider.of<AreaViewModel>(context, listen: false);

    areaViewModel.getAreaList(context).then((response) {
      setState(() {
        getAreaResponse = response;
        uniqueAreaNames = response.data?.map((areaData) => areaData.name!).toSet() ?? {};
        filteredAreas = response.data ?? [];
        _selectedArea = uniqueAreaNames.isNotEmpty ? uniqueAreaNames.first : '';
      });
    }).catchError((error) {
      print(error);
    });
  }

}

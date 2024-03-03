import 'package:dma_card/model/get_area_list.dart';
import 'package:dma_card/view_model/area_list_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../res/color.dart';
import '../../res/components/round_button.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/login_view_model.dart';

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

  String _selectedPayment = 'cash';
  String _pickedLocation = '';
  String _selectedArea = '';
  List<Data> filteredAreas = [];

  GetAreaList? getAreaResponse;
  Set<String> uniqueAreaNames = <String>{};

  @override
  void dispose() {
    super.dispose();

    cardFocusNode.dispose();
    addressFocusNode.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch card info after the widget is built
      getAreaList();
    });
  }



  @override
  Widget build(BuildContext context) {
    final areaViewModel = Provider.of<AreaViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
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
              const Text(
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
                decoration: const InputDecoration(
                  hintText: 'Enter preferred card name',
                ),
                onFieldSubmitted: (value) {
                  Utils.fieldFocusChange(context, cardFocusNode, addressFocusNode);
                },
              ),
              const SizedBox(height: 20),
              const Text(
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
                decoration: const InputDecoration(
                  hintText: 'Enter your address',
                ),
              ),
              const SizedBox(height: 20),
              const Text(
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
              const SizedBox(height: 20),
              const Text(
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
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text("Select Payment Method:"),
                  const SizedBox(width: 10),
                  Radio(
                    value: 'cash',
                    groupValue: _selectedPayment,
                    onChanged: (value) {
                      setState(() {
                        _selectedPayment = value as String;
                      });
                    },
                  ),
                  const Text("Cash"),
                ],
              ),
              const SizedBox(height: 15.0),
              const SizedBox(height: 20),
              RoundButton(
                title: "Apply",
                loading: areaViewModel.getUpdateLoading,
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
                    final Map<String, String> data = {
                      'address_line_1': _addressController.text.toString(),
                      'upazila': _selectedArea,
                      'city': 'Dhaka',
                      'state': 'BD',
                      'post_code': '1205'
                    };
                    tokenViewModel.getToken().then((loginModel) {
                      final token = loginModel.token;
                      areaViewModel.updateAddress(context, token!, data).then((updateAddressResponse) {
                        // Update the state based on the hasCard value
                        if(updateAddressResponse.statusCode == 200){
                          final Map<String, String> data = {
                            'service_id': '1',
                            'service_type': 'RPS',
                            'service_merchant': '1',
                            'platform': 'Android',
                            'delivery_method': 'Home',
                            'card_name': _cardNameController.text.toString(),
                            'card_pickup_point': _pickedLocation,
                          };
                          applyCard(tokenViewModel, areaViewModel, data);
                        }
                      }).catchError((error) {
                        if (kDebugMode) {
                          print(error);
                        }
                        // Handle error here
                      });
                    }).catchError((error) {
                      if (kDebugMode) {
                        print(error);
                      }
                      // Handle error here
                    });
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
      if (kDebugMode) {
        print(error);
      }
    });
  }

  void applyCard(TokenViewModel tokenViewModel, AreaViewModel areaViewModel, Map<String, String> data) {
    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      areaViewModel.applyCard(context, token!, data).then((applyCardResponse){
        if(applyCardResponse.statusCode == 200){
          Utils.flushBarErrorMessage("Apply Successfully", context);
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.landing, (route) => false);
        }
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
        // Handle error here
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      // Handle error here
    });
  }
}


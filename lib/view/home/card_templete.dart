import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/get_card_model.dart';
import '../../res/color.dart';
import '../../res/components/otp_popup.dart';
import '../../utils/routes/routes_name.dart';
import '../../utils/utils.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/login_view_model.dart';

class CardTemplate extends StatelessWidget {
  const CardTemplate({
    Key? key,
    required this.getCardResponse,
  }) : super(key: key);

  final GetCardModel? getCardResponse;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isVerifiedNotifier = ValueNotifier(false);
    return Container(
      margin: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width - 10,
      height: MediaQuery.of(context).size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/images/card_template.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          if (!(getCardResponse?.hasCard ?? false))
            Center(
              child: SizedBox(
                height: 40, // Set your desired margin height
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Apply Card button press
                    Navigator.pushNamed(context, RoutesName.apply);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.buttonColor,
                  ),
                  child: const Text('Apply Card'),
                ),
              ),
            ),
          if (getCardResponse?.hasCard ?? false)
            if(getCardResponse?.data?.request?.status == 'PENDING')
              Container(
                margin: const EdgeInsets.only(top: 100), // Adjust the top margin as needed
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Your request has been submitted, Please wait for approval.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          if(getCardResponse?.data?.request?.status == 'PRINTING')
            Container(
              margin: const EdgeInsets.only(top: 100), // Adjust the top margin as needed
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Your loyalty card is in printing queue.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if(getCardResponse?.data?.request?.status == 'PRINTED')
            Container(
              margin: const EdgeInsets.only(top: 100), // Adjust the top margin as needed
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      'Your loyalty card has been printed! Please wait for ready to delivery message.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if(getCardResponse?.data?.request?.status == 'IN-DELIVERY')
            Center(
              child: SizedBox(
                height: 40, // Set your desired margin height
                child: ElevatedButton(
                  onPressed: () {
                    // Handle Apply Card button press
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        String inputText = ''; // Variable to store entered text

                        return AlertDialog(
                          title: const Text('Enter your card number'),
                          content: TextField(
                            maxLength: 16,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              hintText: '16-digit card number',
                            ),
                            onChanged: (value) {
                              inputText = value; // Update inputText when the text changes
                            },
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                if (inputText.length != 16) {
                                  // Check if input length is not 16
                                  Utils.flushBarErrorMessage('Please enter a 16-digit card number', context);
                                } else {
                                  Navigator.of(context).pop(inputText); // Close the dialog and pass inputText
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppColors.buttonColor, // Set button background color
                              ),
                              child: const Text('Activate'),
                            ),
                          ],
                        );
                      },
                    ).then((value) {
                      // This block executes after the dialog is closed
                      if (value != null && value is String) {
                        //Utils.flushBarErrorMessage(value, context);
                        checkCard(context, value, isVerifiedNotifier);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.buttonColor,
                  ),
                  child: const Text('Press to activate'),
                ),
              ),
            ),
          if(getCardResponse?.data?.request?.status == 'ACTIVE')
          Positioned(
            bottom: 20,
            left: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      colors: [
                        Colors.yellowAccent,
                        Colors.redAccent,
                        Colors.yellow,
                      ],
                    ).createShader(bounds);
                  },
                  child: Text(
                    getCardResponse?.data?.cardNumber?.replaceAllMapped(
                        RegExp(r'.{4}'), (match) => '${match.group(0)} ') ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  getCardResponse?.data?.userName?.toUpperCase() ?? '',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void checkCard(BuildContext context, String value, ValueNotifier<bool> isVerifiedNotifier) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      homeViewModel.checkCard(token!, value, context).then((checkCardResponse) {
        if(checkCardResponse.statusCode == 200){
          sendActiveOtp(context, homeViewModel, tokenViewModel, checkCardResponse.data?.cardSku, isVerifiedNotifier);
          print(checkCardResponse.data?.cardSku);
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

  void sendActiveOtp(BuildContext context, HomeViewModel homeViewModel, TokenViewModel tokenViewModel, String? cardSku, ValueNotifier<bool> isVerifiedNotifier) {
    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      homeViewModel.getActiveOtp(token!, cardSku!, context).then((getActiveOtpResponse) {
        if(getActiveOtpResponse.statusCode == 200){
          showDialog(
            context: context,
            builder: (context) => OtpPopup(
              isVerified: isVerifiedNotifier, // Pass isVerifiedNotifier
              onSubmit: (otp) async {
                //Utils.flushBarErrorMessage("Active $otp", context);
                print('active $otp');
              },
            ),
          );
          print(getActiveOtpResponse.message);

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
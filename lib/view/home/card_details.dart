import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/get_card_model.dart';
import '../../res/color.dart';
import '../../res/components/otp_popup.dart';
import '../../utils/utils.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/login_view_model.dart';

class CardDetailsPage extends StatefulWidget {
  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  GetCardModel? getCardResponse;
  bool isCardActive = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch card info after the widget is built
      getCardInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isVerifiedNotifier = ValueNotifier(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Card Details',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Cardholder Name',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              getCardResponse?.data?.cardName?.toUpperCase() ?? '',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            const Text(
              'Card Number',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              getCardResponse?.data?.cardNumber
                      ?.substring(getCardResponse!.data!.cardNumber!.length - 4)
                      .padLeft(
                          getCardResponse!.data!.cardNumber!.length, '*') ??
                  '',
              style: const TextStyle(fontSize: 14),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Expiry Date',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      getCardResponse?.data?.expiresAt ?? '',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'CVC',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(getCardResponse?.data?.cvc ?? '',
                        style: const TextStyle(fontSize: 14)),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Card Status:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 10),
                Switch(
                  value: isCardActive,
                  // Assign the value of the Switch widget
                  onChanged: (value) {
                    // Show confirmation dialog before changing card status
                    showDialog(
                      context: context,
                      builder: (context) {
                        bool isLoading = false; // Track loading state
                        return StatefulBuilder(
                          builder: (context, setState) {
                            return AlertDialog(
                              title: Text(
                                value
                                    ? 'Your card is deactivate now'
                                    : 'Your card is active now',
                                style: const TextStyle(
                                    color: AppColors.buttonColor),
                              ),
                              content: Text(
                                value
                                    ? 'Do you want to activate the card?'
                                    : 'Do you want to deactivate the card?',
                              ),
                              actions: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  // Add margin between buttons
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(
                                          context); // Close the dialog
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.buttonColor,
                                    ),
                                    child: const Text('NO',
                                        style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5.0),
                                  // Add margin between buttons
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        isLoading = true; // Start loading
                                      });
                                      // Perform card activation/deactivation operation
                                      await cardActiveInactive(
                                          value, isVerifiedNotifier, isLoading);
                                      setState(() {
                                        isCardActive =
                                            value; // Update the state of the Switch
                                      });
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: isLoading
                                          ? Colors.white
                                          : AppColors.buttonColor,
                                    ),
                                    child: isLoading
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: AppColors.buttonColor,
                                              strokeWidth: 3,
                                            ),
                                          )
                                        : const Text(
                                            'YES',
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                  activeTrackColor: Colors.green,
                  // Set the track color when active
                  activeColor: Colors.white, // Set the thumb color when active
                ),
                const SizedBox(width: 10),
                Text(
                  getCardResponse?.data?.status ?? '',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void getCardInfo() {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      homeViewModel.getCardInfo(token!, context).then((getCardResponse) {
        // Update the state based on the hasCard value
        if (getCardResponse.data?.status == 'ACTIVE') {
          isCardActive = true;
        } else {
          isCardActive = false;
        }
        setState(() {
          this.getCardResponse = getCardResponse;
        });
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

  cardActiveInactive(
      bool value, ValueNotifier<bool> isVerifiedNotifier, bool isLoading) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      if (!value) {
        if (kDebugMode) {
          print(value);
        }
        homeViewModel
            .cardInactive(token!, context)
            .then((cardInactiveResponse) {
          if (cardInactiveResponse.statusCode == 200) {
            Utils.flushBarErrorMessage("Your card is inactivated", context);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => CardDetailsPage()),
            );
          }
        }).catchError((error) {
          if (kDebugMode) {
            print(error);
          }
          // Handle error here
        });
      } else {
        sendActiveOtp(
            context, homeViewModel, tokenViewModel, isVerifiedNotifier);
      }
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      // Handle error here
    });
  }

  sendActiveOtp(BuildContext context, HomeViewModel homeViewModel,
      TokenViewModel tokenViewModel, ValueNotifier<bool> isVerifiedNotifier) {
    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      homeViewModel
          .getActiveOtp(
              token!, getCardResponse!.data!.skuNumber.toString(), context)
          .then((getActiveOtpResponse) {
        if (getActiveOtpResponse.statusCode == 200) {
          showDialog(
            context: context,
            builder: (context) => OtpPopup(
              isVerified: isVerifiedNotifier, // Pass isVerifiedNotifier
              onSubmit: (otp) async {
                //Utils.flushBarErrorMessage("Active $otp", context);
                if (kDebugMode) {
                  print('active $otp');
                }
                if (otp.isNotEmpty) {
                  await enableCard(context, tokenViewModel, homeViewModel, otp);
                } else {
                  Utils.flushBarErrorMessage("Please Input the OTP", context);
                }
              },
            ),
          );
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

  enableCard(BuildContext context, TokenViewModel tokenViewModel,
      HomeViewModel homeViewModel, String otp) {
    final Map<String, String> data = {
      'otp': otp,
    };

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      homeViewModel
          .cardEnable(context, token!, data)
          .then((enableCardResponse) {
        if (enableCardResponse.statusCode == 200) {
          Utils.flushBarErrorMessage(
              "Now your card is activated again.", context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => CardDetailsPage()),
          );
          if (kDebugMode) {
            print(enableCardResponse.message);
          }
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

  void closeAllDialogs(BuildContext context) {
    Navigator.of(context).popUntil((route) => route is! PopupRoute);
  }

  @override
  void dispose() {
    // Release any resources here
    super.dispose();
  }
}

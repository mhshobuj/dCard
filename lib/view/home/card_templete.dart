import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/get_card_model.dart';
import '../../res/color.dart';
import '../../res/components/otp_popup.dart';
import '../../utils/routes/routes_name.dart';
import '../../view_model/area_list_view_model.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/login_view_model.dart';
import '../apply/card_fee_payment_screen.dart';
import 'card_number_input_dialog.dart';

class CardTemplate extends StatefulWidget {
  const CardTemplate({
    Key? key,
    required this.getCardResponse,
  }) : super(key: key);

  final GetCardModel? getCardResponse;

  @override
  State<CardTemplate> createState() => _CardTemplateState();
}

class _CardTemplateState extends State<CardTemplate> {

  bool isButtonLoading = false;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isVerifiedNotifier = ValueNotifier(false);
    bool isLoading = false; // Track loading state
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
          if (!(widget.getCardResponse?.hasCard ?? false))
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
          if (widget.getCardResponse?.hasCard ?? false)
            if(widget.getCardResponse?.data?.request?.status == 'PENDING')
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
          if(widget.getCardResponse?.data?.request?.status == 'PRINTING')
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
          if(widget.getCardResponse?.data?.request?.status == 'PRINTED')
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
          if(widget.getCardResponse?.data?.request?.status == 'IN-DELIVERY')
            Center(
              child: SizedBox(
                height: 40, // Set your desired margin height
                child: ElevatedButton(
                  onPressed: isLoading ? null : () async {
                    final cardNumber = await showCreditCardDialog(context);
                    if (cardNumber != null) {
                      setState(() {
                        isLoading = true; // Start loading
                      });
                      await checkCard(context, cardNumber, isVerifiedNotifier);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: AppColors.buttonColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0), // Adjust as needed
                    ),
                  ),
                  child: const Text(
                    'Press to Activate',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Adjust as needed
                  ),
                ),
              ),
            ),
          if(widget.getCardResponse?.data?.request?.status == 'FEE_UNPAID')
            Center(
              child: SizedBox(
                height: 40, // Set your desired margin height
                child: ElevatedButton(
                  onPressed: isButtonLoading
                      ? null
                      : () {
                    setState(() {
                      isButtonLoading = true; // Start button loading
                    });
                    againOnlineFee(() {
                      setState(() {
                        isButtonLoading = false; // Stop button loading
                      });
                    }); // Call your API function with a callback
                  },
                  style: ElevatedButton.styleFrom(
                    primary: isButtonLoading ? Colors.grey : AppColors.buttonColor, // Change button color when loading
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0), // Adjust as needed
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Loading indicator (conditionally shown)
                      if (isButtonLoading)
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.buttonColor, // Adjust the background color and opacity as needed
                            borderRadius: BorderRadius.circular(20), // Adjust the border radius as needed
                          ),
                          width: 40,
                          height: 40,
                          child: const Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
                            ),
                          ),
                        ),
                      // Text (conditionally hidden)
                      Text(
                        isButtonLoading ? '' : 'Pay Now',
                        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold), // Adjust as needed
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if(widget.getCardResponse?.data?.request?.status == 'ACTIVE')
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
                    widget.getCardResponse?.data?.cardNumber?.replaceAllMapped(
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
                  widget.getCardResponse?.data?.userName?.toUpperCase() ?? '',
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

  Future<String?> showCreditCardDialog(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (context) => CreditCardNumberDialog(),
    );
  }

  checkCard(BuildContext context, String value, ValueNotifier<bool> isVerifiedNotifier) {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);

    // Show loading indicator
    isVerifiedNotifier.value = true;

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      homeViewModel.checkCard(token!, value, context).then((checkCardResponse) async {
        if (checkCardResponse.statusCode == 200) {
          await sendActiveOtp(context, homeViewModel, tokenViewModel, checkCardResponse.data?.cardSku, isVerifiedNotifier);
          if (kDebugMode) {
            print(checkCardResponse.data?.cardSku);
          }
        }
        // Hide loading indicator
        isVerifiedNotifier.value = false;
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
        // Hide loading indicator
        isVerifiedNotifier.value = false;
        // Handle error here
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      // Hide loading indicator
      isVerifiedNotifier.value = false;
      // Handle error here
    });
  }

  sendActiveOtp(BuildContext context, HomeViewModel homeViewModel, TokenViewModel tokenViewModel, String? cardSku, ValueNotifier<bool> isVerifiedNotifier) {
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
                if (kDebugMode) {
                  print('active $otp');
                }
                await activeCard(context, tokenViewModel, homeViewModel, cardSku, otp);
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

  activeCard(BuildContext context,TokenViewModel tokenViewModel, HomeViewModel homeViewModel, String cardSku, String otp) {

    final Map<String, String> data = {
      'otp': otp,
      'sku_number': cardSku.toString(),
    };

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      homeViewModel.activeCard(context, token!,data ).then((activeCardResponse) {
        if(activeCardResponse.statusCode == 200){
          Navigator.of(context);
          Navigator.pushNamedAndRemoveUntil(context, RoutesName.landing, (route) => false);
          if (kDebugMode) {
            print(activeCardResponse.message);
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

  void againOnlineFee(Function callback) {
    final areaViewModel = Provider.of<AreaViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);

    setState(() {
      isButtonLoading = true; // Start button loading
    });

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      areaViewModel.againOnlineFee(context, token!).then((againFeePaymentResponse) {
        if (againFeePaymentResponse.statusCode == 200) {
          if (kDebugMode) {
            print(againFeePaymentResponse.data.sslresponse.data.redirectGatewayURL);
          }
          String url = againFeePaymentResponse.data.sslresponse.data.redirectGatewayURL;
          Navigator.push(context, MaterialPageRoute(builder: (context) => CardFeePayment(url: url),),);
        }
        // Move the callback inside the then block
        callback(); // Invoke the callback to signal the completion
      }).catchError((error) {
        if (kDebugMode) {
          print(error);
        }
        // Handle error here
        callback(); // Invoke the callback to signal the completion
      });
    }).catchError((error) {
      if (kDebugMode) {
        print(error);
      }
      // Handle error here
      callback(); // Invoke the callback to signal the completion
    });
  }

}
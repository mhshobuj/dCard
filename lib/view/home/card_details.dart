import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../model/get_card_model.dart';
import '../../res/color.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/login_view_model.dart';

class CardDetailsPage extends StatefulWidget {
  @override
  State<CardDetailsPage> createState() => _CardDetailsPageState();
}

class _CardDetailsPageState extends State<CardDetailsPage> {
  GetCardModel? getCardResponse;

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
              getCardResponse?.data?.cardName?.toUpperCase() ?? '',// Replace with actual cardholder name
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
              getCardResponse?.data?.cardNumber?.substring(getCardResponse!.data!.cardNumber!.length - 4).padLeft(getCardResponse!.data!.cardNumber!.length, '*') ?? '', // Replace with actual card number
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
                      getCardResponse?.data?.expiresAt ?? '', // Replace with actual expiry date
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
                    Text(
                      getCardResponse?.data?.cvc ?? '', // Replace with actual CVC number
                      style: const TextStyle(fontSize: 14)
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Card Status',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              getCardResponse?.data?.status ?? '', // Replace with actual card status
              style: const TextStyle(fontSize: 14),
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
}
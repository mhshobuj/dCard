import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/get_card_model.dart';
import '../../view_model/home_view_model.dart';
import '../../view_model/login_view_model.dart';
import 'card_templete.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String cardHolderName = "md mehedi hasan";
  String cardNumber = "1234567890123456";

  GetCardModel? getCardResponse; // Store the card response here

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          // Display the card template
          CardTemplate(
            getCardResponse: getCardResponse, // Pass the response here
          ),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2.0,
                ),
              ),
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Transactions list (last 7 days)',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Transaction $index'),
                  subtitle: const Text('Transaction details'),
                  trailing: const Text('\$10.00'),
                );
              },
            ),
          ),
        ],
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
        print(error);
        // Handle error here
      });
    }).catchError((error) {
      print(error);
      // Handle error here
    });
  }
}





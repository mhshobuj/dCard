import 'package:dma_card/model/collection_history_response.dart';
import 'package:dma_card/res/color.dart';
import 'package:dma_card/view/home/transaction_list.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
  GetCardModel? getCardResponse; // Store the card response here
  CollectionHistoryResponse? collectionResponse;
  bool isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch card info after the widget is built
      getCardInfo();
      getCollectionHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading // Show loading indicator if data is being fetched
          ? Center(
              child: Theme(
                data: ThemeData(
                  colorScheme: const ColorScheme(
                  primary: AppColors.buttonColor,
                  primaryVariant: AppColors.buttonColor,
                  secondary: AppColors.buttonColor,
                  secondaryVariant: AppColors.buttonColor,
                  surface: AppColors.buttonColor,
                  background: AppColors.buttonColor,
                  error: AppColors.buttonColor,
                  onPrimary: AppColors.buttonColor,
                  onSecondary: AppColors.buttonColor,
                  onSurface: AppColors.buttonColor,
                  onBackground: AppColors.buttonColor,
                  onError: AppColors.buttonColor,
                  brightness: Brightness.light,
                ),
                ),
                child: const CircularProgressIndicator(),
              ),
            )
          : Column(
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
                TransactionListWidget(collectionResponse: collectionResponse)
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
          isLoading = false; // Update loading state when data is received
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

  void getCollectionHistory() {
    final homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);

    // Get today's date
    DateTime today = DateTime.now();
    // Calculate the date 7 days ago
    DateTime sevenDaysAgo = today.subtract(const Duration(days: 7));

    // Format dates as strings in 'yyyy-MM-dd' format
    String startDate = DateFormat('yyyy-MM-dd').format(sevenDaysAgo);
    String endDate = DateFormat('yyyy-MM-dd').format(today);

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      homeViewModel.collectionHistory(token!,startDate, endDate, context).then((collectionResponse) {
        // Update the state based on the hasCard value
        setState(() {
          this.collectionResponse = collectionResponse;
          isLoading = false; // Update loading state when data is received
        });
        if (kDebugMode) {
          print(collectionResponse.data?.length.toString());
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

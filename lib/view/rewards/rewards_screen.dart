import 'package:dma_card/model/rewards_list_model.dart';
import 'package:dma_card/view_model/rewards_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../res/color.dart';
import '../../view_model/login_view_model.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {

  RewardListResponse? rewardListResponse;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      getRewardsList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: rewardListResponse == null
          ? const Center(
        child: CircularProgressIndicator(), // Display a loading indicator
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Total rewards section
          const SizedBox(height: 10),
          Card(
            elevation: 3,
            margin: const EdgeInsets.all(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Rewards logo
                  Image.asset(
                    'assets/images/reward.png',
                    width: 40,
                    height: 40,
                  ),
                  const SizedBox(height: 20),
                  // Total rewards text
                  const Text(
                    'Total Reward Points',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Total rewards value
                  Text(
                    rewardListResponse!.data!.rewardPoints.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.buttonColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Rewards list
          Expanded(
            child: rewardListResponse!.data!.redeems!.isEmpty
                ? const Center(
              child: Text("No rewards happened yet"),
            )
                : ListView.builder(
              itemCount: rewardListResponse!.data!.redeems!.length,
              itemBuilder: (context, index) {
                Redeems redeem = rewardListResponse!.data!.redeems![index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 2.0), // Add left margin
                      child: SizedBox(
                        height: 60, // Adjust height as needed
                        width: 60, // Adjust width as needed
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                            redeem.merchantLogo ?? '',
                          ),
                        ),
                      ),
                    ),
                    title: Text(redeem.purpose ?? ''),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Paid at: ${redeem.createdAt ?? ''}'),
                        Text(
                          'Amount: ${redeem.amount?.toStringAsFixed(2) ?? ""} TK',
                          style: const TextStyle(fontWeight: FontWeight.bold), // Example styling
                        ),
                        if (redeem.serviceDetail!.earnedPoints! > 0)
                          Row(
                            children: [
                              const Icon(Icons.add, color: Colors.green), // Add icon for earned points
                              Text('Earned points: ${redeem.serviceDetail?.earnedPoints ?? '0'}',
                                style: const TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        if (redeem.serviceDetail!.usedPoint! > 0)
                          Row(
                            children: [
                              const Icon(Icons.remove, color: Colors.red), // Add icon for used points
                              Text('Redeem points: ${redeem.serviceDetail?.usedPoint ?? '0'}',
                                style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }



  void getRewardsList() {
    final rewardsViewModel = Provider.of<RewardsViewModel>(context, listen: false);
    final tokenViewModel = Provider.of<TokenViewModel>(context, listen: false);

    tokenViewModel.getToken().then((loginModel) {
      final token = loginModel.token;
      rewardsViewModel.getRewardsList(token!, context).then((rewardsResponse) {
        // Update the state based on the hasCard value
        setState(() {
          rewardListResponse = rewardsResponse;
        });
        if (kDebugMode) {
          print(rewardsResponse.data?.redeems?.length.toString());
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



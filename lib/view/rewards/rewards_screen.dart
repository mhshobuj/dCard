import 'package:flutter/material.dart';

import '../../res/color.dart';

class RewardsScreen extends StatefulWidget {
  const RewardsScreen({Key? key}) : super(key: key);

  @override
  State<RewardsScreen> createState() => _RewardsScreenState();
}

class _RewardsScreenState extends State<RewardsScreen> {
  // Dummy rewards data for testing
  List<Map<String, dynamic>> rewardsList = [
    {
      'imageLogo': 'assets/images/dcard_logo.png',
      'purpose': 'Purchase at SuperMart',
      'time': '10:30 AM',
      'amount': 200.0,
      'rewardValue': 20.0,
    },
    {
      'imageLogo': 'assets/images/dcard_logo.png',
      'purpose': 'Online Payment',
      'time': '02:45 PM',
      'amount': 150.0,
      'rewardValue': 15.0,
    },
    // Add more dummy data as needed
  ];

  @override
  Widget build(BuildContext context) {
    // Calculate total rewards
    double totalRewards = rewardsList.fold(
        0, (previousValue, element) => previousValue + element['rewardValue']);

    return Scaffold(
      body: Column(
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
                    'Total Rewards',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Total rewards value
                  Text(
                    totalRewards.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                        color: AppColors.buttonColor
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Rewards list
          Expanded(
            child: ListView.builder(
              itemCount: rewardsList.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> rewards = rewardsList[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: Image.asset(
                      rewards['imageLogo'],
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    title: Text(rewards['purpose']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Time: ${rewards['time']}'),
                        Text('Amount: \$${rewards['amount'].toStringAsFixed(2)}'),
                        Text('Reward Value: \$${rewards['rewardValue'].toStringAsFixed(2)}'),
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
}



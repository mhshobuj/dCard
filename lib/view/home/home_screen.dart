import 'package:flutter/material.dart';

import '../../res/color.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String cardHolderName = "md mehedi hasan";
  String cardNumber = "1234567890123456";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        centerTitle: true,
        title: const Text('Home'),
      ),*/
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width - 10, // Adjusted width to account for margins
            height: MediaQuery.of(context).size.width * 0.6, // Adjust card height as needed
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), // Apply border radius
              image: const DecorationImage(
                image: AssetImage('assets/images/card_template.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
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
                          cardNumber.replaceAllMapped(RegExp(r'.{4}'), (match) => '${match.group(0)} '),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        cardHolderName.toUpperCase(),
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
          ),
          const SizedBox(height: 20),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black,
                  width: 2.0, // Adjust the width as needed
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
              itemCount: 10, // Replace with your transaction list length
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Transaction $index'),
                  subtitle: const Text('Transaction details'),
                  trailing: const Text('\$10.00'), // Example transaction amount
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


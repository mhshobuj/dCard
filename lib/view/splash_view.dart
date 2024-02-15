import 'package:dma_card/utils/services/splash_service.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  SplashServices services = SplashServices();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    services.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Use a default background color
      body: Stack(
        children: [
          Center(
            child: SizedBox(
              // Adjust container size and padding as needed
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // App logo or text
                  Hero(
                    tag: 'appLogo',
                    child: Image.asset(
                      'assets/images/dcard_logo.png', // Replace with your actual logo image
                      height: 200, // Adjust logo height
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

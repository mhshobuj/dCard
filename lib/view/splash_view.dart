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
      body: Center(
        child: Text("Splash Screen", style: Theme.of(context).textTheme.headlineSmall,),
      ),
    );
  }
}

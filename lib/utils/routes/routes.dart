import 'package:dma_card/utils/routes/routes_name.dart';
import 'package:dma_card/view/apply/card_apply_screen.dart';
import 'package:dma_card/view/home/card_details.dart';
import 'package:dma_card/view/home/home_screen.dart';
import 'package:dma_card/view/auth/login_screen.dart';
import 'package:dma_card/view/auth/signup_screen.dart';
import 'package:dma_card/view/auth/splash_view.dart';
import 'package:dma_card/view/landing_screen.dart';
import 'package:dma_card/view/more/about_screen.dart';
import 'package:dma_card/view/more/edit_screen.dart';
import 'package:dma_card/view/more/faq_screen.dart';
import 'package:dma_card/view/more/more_screen.dart';
import 'package:dma_card/view/more/support_page.dart';
import 'package:dma_card/view/rewards/rewards_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name){
      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context) => const SplashView());
      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context) => const HomeScreen());
      case RoutesName.rewards:
        return MaterialPageRoute(builder: (BuildContext context) => const RewardsScreen());
      case RoutesName.more:
        return MaterialPageRoute(builder: (BuildContext context) => const MoreScreen());
      case RoutesName.landing:
        return MaterialPageRoute(builder: (BuildContext context) => LandingPage());
      case RoutesName.apply:
        return MaterialPageRoute(builder: (BuildContext context) => const ApplyCardScreen());
      case RoutesName.details:
        return MaterialPageRoute(builder: (BuildContext context) => CardDetailsPage());
      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context) => const LoginScreen());
      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context) => const SignUpScreen());
      case RoutesName.faq:
        return MaterialPageRoute(builder: (BuildContext context) => const FAQPage());
      case RoutesName.support:
        return MaterialPageRoute(builder: (BuildContext context) => SupportPage());
      case RoutesName.about:
        return MaterialPageRoute(builder: (BuildContext context) => AboutPage());
      case RoutesName.edit:
        return MaterialPageRoute(builder: (BuildContext context) => const EditScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text("No route defined"),
            ),
          );
        });
    }
  }
}
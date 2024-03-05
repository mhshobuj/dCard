import 'package:dma_card/res/color.dart';
import 'package:dma_card/utils/routes/routes.dart';
import 'package:dma_card/utils/routes/routes_name.dart';
import 'package:dma_card/view_model/area_list_view_model.dart';
import 'package:dma_card/view_model/auth_view_model.dart';
import 'package:dma_card/view_model/home_view_model.dart';
import 'package:dma_card/view_model/login_view_model.dart';
import 'package:dma_card/view_model/rewards_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Set the status bar color
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.buttonColor, // Set the status bar color here
        statusBarIconBrightness: Brightness.light, // Set the status bar icon color (light or dark)
      ),
    );
    // Create a MaterialColor based on the buttonColor
    MaterialColor primarySwatch = MaterialColor(
      AppColors.buttonColor.value,
      <int, Color>{
        50: AppColors.buttonColor.withOpacity(0.1),
        100: AppColors.buttonColor.withOpacity(0.2),
        200: AppColors.buttonColor.withOpacity(0.3),
        300: AppColors.buttonColor.withOpacity(0.4),
        400: AppColors.buttonColor.withOpacity(0.5),
        500: AppColors.buttonColor.withOpacity(0.6),
        600: AppColors.buttonColor.withOpacity(0.7),
        700: AppColors.buttonColor.withOpacity(0.8),
        800: AppColors.buttonColor.withOpacity(0.9),
        900: AppColors.buttonColor,
      },
    );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => TokenViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => AreaViewModel()),
        ChangeNotifierProvider(create: (_) => RewardsViewModel()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: primarySwatch,
          appBarTheme: const AppBarTheme(
            color: AppColors.buttonColor, // Set the app bar color here
          ),
        ),
        initialRoute: RoutesName.splash,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}

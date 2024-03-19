import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../res/color.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String _appVersion = 'none';

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
      ),
      body: Center( // Center the content vertically and horizontally
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center( // Center the column vertically and horizontally
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/dcard_logo.png',
                  height: 200,
                  width: 200,
                ),
                const Text(
                  'Version Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Center( // Center the ListTile widgets
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'App Version $_appVersion',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Copyright © 2023 Datasoft Manufacturing & Assembly Inc. Limited. All rights reserved.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center, // Align text to center
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


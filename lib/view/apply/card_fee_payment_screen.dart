import 'package:dma_card/res/color.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../utils/routes/routes_name.dart';


class CardFeePayment extends StatefulWidget {
  final String url;

  const CardFeePayment({Key? key, required this.url}) : super(key: key);

  @override
  _CardFeePaymentState createState() => _CardFeePaymentState();
}

class _CardFeePaymentState extends State<CardFeePayment> {
  bool isLoading = true;
  final controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {},
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
      ),
    );

  @override
  void initState() {
    super.initState();
    controller.loadRequest(Uri.parse(widget.url));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Card Fee Payment',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.buttonColor,
        // Handle leading back button press
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Navigate to the landing route and remove all previous routes
            Navigator.pushNamedAndRemoveUntil(context, RoutesName.landing, (route) => false);
          },
        ),
      ),
      body: Stack(
        children: [
          // Conditional visibility for loading indicator
          Visibility(
            visible: isLoading,
            child: const Center(child: CircularProgressIndicator()),
          ),
          WebViewWidget(controller: controller),
        ],
      ),
    );
  }
}



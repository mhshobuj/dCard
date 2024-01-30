import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {

  static toastMessage(String msg){
    Fluttertoast.showToast(msg: msg,
    backgroundColor: Colors.black,
    textColor: Colors.white,
    toastLength: Toast.LENGTH_LONG);
  }

  static void flushBarErrorMessage(String message, BuildContext context){

    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        messageText: Text(
          message,
          style: const TextStyle(fontSize: 16), // Adjust font size
        ),
        backgroundColor: Colors.black26,
        flushbarPosition: FlushbarPosition.BOTTOM,
        borderRadius: BorderRadius.circular(12),
        title: 'test title',
        messageColor: Colors.white,
        duration: const Duration(seconds: 3),
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: const Icon(Icons.error, size: 28, color: Colors.white),
      )..show(context),
    );
  }

  static snackBar(String message, BuildContext context){
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message),
      backgroundColor: Colors.black26,)
    );
  }
}
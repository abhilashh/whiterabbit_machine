import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'constants.dart';

class Helpers {
  static Future<bool> isInternetAvailable() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      } else {
        errorToast(Constants.noInternet);
        return false;
      }
    } on SocketException catch (_) {
      errorToast(Constants.noInternet);
      return false;
    }
  }

  static void errorToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey.shade400,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  static void successToast(msg) {
    if (msg != null && '$msg'.isNotEmpty) {
      Fluttertoast.showToast(
          msg: '$msg',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade400,
          textColor: Colors.black,
          fontSize: 16.0);
    }
  }
}

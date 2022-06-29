import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'app_data.dart';

Future<http.Response> getRequest(String endpoint) async {
  final url = AppData.baseUrl + endpoint;
  log("URL :: $url");
  var client = http.Client();
  dynamic response;
  try {
    response = await client.get(
      Uri.parse(url),
      headers: <String, String>{
        HttpHeaders.contentTypeHeader: "application/json",
      },
    ).timeout(const Duration(seconds: 60));
  } on Exception catch (error) {
    if (error.toString().contains('SocketException')) {
      Fluttertoast.showToast(
          msg: 'Error occurred while communicating with Server!');
    }
  }
  return response;
}

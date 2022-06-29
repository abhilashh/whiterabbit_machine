import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Common/helpers.dart';
import '../model/home_model.dart';
import 'http_requests.dart';

class ServiceConfig {
  Future<dynamic> validateStatusCode(int statusCode, String? body) async {
    dynamic res;
    switch (statusCode) {
      case 200:
        res = await json.decode(body ?? '');
        break;
      case 202:
        res = await json.decode(body ?? '');
        break;
      case 203:
        res = await json.decode(body ?? '');
        break;
      case 500:
        Helpers.successToast('Internal server error, Try again');
        res = {};
        break;
    }
    return res ?? {};
  }

  Future<List<HomeModel?>> getHomeData() async {
    List<HomeModel?> _homeModel = [];
    try {
      http.Response? _resp = await getRequest('v2/5d565297300000680030a986');
      dynamic res = await validateStatusCode(_resp.statusCode, _resp.body);
      if (res != null && res.isNotEmpty) {
        _homeModel = homeModelFromJson(_resp.body);
      }
      log(res.toString(), name: 'Home Data');
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
    return _homeModel;
  }
}

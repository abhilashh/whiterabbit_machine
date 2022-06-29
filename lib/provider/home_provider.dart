import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import '../Common/constants.dart';
import '../Common/helpers.dart';
import '../model/home_model.dart';
import '../services/service_config.dart';

class HomeProvider extends ChangeNotifier {
  ServiceConfig serviceConfig = ServiceConfig();
  List<HomeModel?> homeModel = [];
  List<HomeModel?> initialData = [];
  LoadState pageLoadState = LoadState.loaded;
  late Box box;

  void homeInit() {
    box = Hive.box('localBox');
    pageLoadState = LoadState.loaded;
    homeModel = [];
    notifyListeners();
  }

  Future<void> getHomeData() async {
    updatePageLoadState(LoadState.loading);
    if (box.get('localData') != null) {
      Fluttertoast.showToast(
          msg: 'Its from Local',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade400,
          textColor: Colors.black,
          fontSize: 16.0);
      homeModel = [];
      dynamic _homemodel = box.get('localData');
      _homemodel.forEach((element) {
        initialData.add(element);
      });
      homeModel = initialData;
      updatePageLoadState(LoadState.loaded);
      notifyListeners();
    } else {
      final network = await Helpers.isInternetAvailable();
      if (network) {
        Fluttertoast.showToast(
            msg: 'Its from Server',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade400,
            textColor: Colors.black,
            fontSize: 16.0);
        updatePageLoadState(LoadState.loaded);
        initialData = await serviceConfig.getHomeData();
        homeModel = initialData;
        box.put('localData', homeModel);
        notifyListeners();
      } else {
        updatePageLoadState(LoadState.networkError);
      }
    }
  }

  Future<void> filterData(String query) async {
    if (query.isNotEmpty) {
      homeModel = homeModel
          .where((element) =>
              element!.username!.toLowerCase().contains(query.toLowerCase()))
          .toList();
      notifyListeners();
    } else {
      homeModel = initialData;
      notifyListeners();
    }
  }

  void updatePageLoadState(LoadState val) {
    pageLoadState = val;
    notifyListeners();
  }
}

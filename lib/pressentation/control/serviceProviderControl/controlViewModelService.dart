import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/loginView.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/serviceProvider/onGoingView.dart';
import 'package:yeeo/pressentation/serviceProvider/serviceProviderView.dart';
import 'package:yeeo/pressentation/user/inventoryView.dart';
import 'package:yeeo/pressentation/user/userView.dart';

class ControlViewModelService extends GetxController {
  int _navigatorValue = 0;
  get navigatorValue => _navigatorValue;
  late Widget currentScreen;
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  final LocalStorageData localStorageData = Get.find();

  ServiceProviderModel? get serviceProviderModel => _serviceProviderModel;
  ServiceProviderModel? _serviceProviderModel;
  @override
  void onInit() async {
    super.onInit();
    await getCurrentServiceProvider();
    currentScreen = ServiceProviderView();
  }

  getCurrentServiceProvider() async {
    _loading.value = true;
    await localStorageData.getServiceProvider.then((value) {
      _serviceProviderModel = value!;
    });
    _loading.value = false;
    update();
  }

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          currentScreen = ServiceProviderView();
          break;
        }
      case 1:
        {
          currentScreen = OngoingView();
          break;
        }
    }
    update();
  }
}

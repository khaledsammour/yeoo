import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/loginView.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/serviceProvider/serviceProviderView.dart';
import 'package:yeeo/pressentation/user/inventoryView.dart';
import 'package:yeeo/pressentation/user/userView.dart';

class ControlViewModel extends GetxController {
  int _navigatorValue = 0;
  get navigatorValue => _navigatorValue;
  late Widget currentScreen;
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  final LocalStorageData localStorageData = Get.find();

  UserModel get userModel => _userModel;
  late UserModel _userModel;
  @override
  void onInit() async {
    super.onInit();
    await getCurrentUser();
    currentScreen = UserView();
  }

  getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    _loading.value = false;
    update();
  }

  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        {
          currentScreen = UserView();
          break;
        }
      case 1:
        {
          currentScreen = InventoryView();
          break;
        }
    }
    update();
  }
}

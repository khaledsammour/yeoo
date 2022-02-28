import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';

import '../userModel.dart';

class LocalStorageData extends GetxController {
  Future<UserModel?> get getUser async {
    try {
      UserModel userModel = await _getUserData();
      if (userModel == null) {
        return null;
      }
      return userModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<ServiceProviderModel?> get getServiceProvider async {
    try {
      ServiceProviderModel serviceProviderModel =
          await _getServiceProviderData();
      if (serviceProviderModel == null) {
        return null;
      }
      return serviceProviderModel;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  _getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(CASHED_USER_DATA);
    return UserModel.fromJson(json.decode(value!));
  }

  _getServiceProviderData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var value = prefs.getString(CASHED_ServiceProvider_DATA);
    return ServiceProviderModel.fromJson(json.decode(value!));
  }

  setUser(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        CASHED_USER_DATA, json.encode(userModel.toJson(userModel.userId)));
  }

  setServiceProvider(ServiceProviderModel serviceProviderModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(
        CASHED_ServiceProvider_DATA,
        json.encode(serviceProviderModel
            .toJson(serviceProviderModel.serviceProviderId)));
  }

  void deleteUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}

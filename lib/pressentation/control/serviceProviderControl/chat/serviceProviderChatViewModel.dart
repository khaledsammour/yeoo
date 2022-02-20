import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/control/chat/chatModel.dart';
import 'package:yeeo/pressentation/control/userControl/chat/service/firestoreChat.dart';

class ServiceProviderChatViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  final LocalStorageData localStorageData = Get.find();
  ServiceProviderModel get serviceProviderModel => _serviceProviderModel;
  late ServiceProviderModel _serviceProviderModel;
  List<UserModel> get userModel => _userModel;
  List<UserModel> _userModel = [];

  List<ChatModel> get chatModel => _chatModel;
  List<ChatModel> _chatModel = [];
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void onInit() async {
    super.onInit();
    await getCurrentUser();
    await getChats();
    await getService();
  }

  getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getServiceProvider.then((value) {
      _serviceProviderModel = value!;
    });
    _loading.value = false;
    update();
  }

  getChats() async {
    _loading.value = true;
    await FireStoreChat()
        .getChatServiceProvider(_serviceProviderModel.serviceProviderId)
        .then((value) {
      for (int i = 0; i < value.length; i++) {
        _chatModel.add(ChatModel.fromJson(value[i].data()));

        _loading.value = false;
        update();
      }
    });
  }

  getService() async {
    _loading.value = true;

    for (int i = 0; i < _chatModel.length; i++) {
      await FireStoreChat().getuser(_chatModel[i].userId).then((value) {
        _userModel.add(UserModel.fromJson(value.data()!));
      });
    }
    _loading.value = false;
    update();
  }
}

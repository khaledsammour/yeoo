import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/control/chat/chatModel.dart';
import 'package:yeeo/pressentation/control/userControl/chat/service/firestoreChat.dart';

class ChatViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  final LocalStorageData localStorageData = Get.find();
  UserModel get userModel => _userModel;
  late UserModel _userModel;
  List<ServiceProviderModel> get serviceProviderModel => _serviceProviderModel;
  List<ServiceProviderModel> _serviceProviderModel = [];

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
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    _loading.value = false;
    update();
  }

  getChats() async {
    _loading.value = true;
    await FireStoreChat().getChat(_userModel.userId).then((value) {
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
      await FireStoreChat()
          .getserviceProvider(_chatModel[i].serviceProviderId)
          .then((value) {
        _serviceProviderModel.add(ServiceProviderModel.fromJson(value.data()!));
      });
    }
    _loading.value = false;
    update();
  }
}

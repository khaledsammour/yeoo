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

  RxList<ChatModel> chatModel = RxList([]);

  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void onReady() async {
    super.onReady();
    await getCurrentUser();
    chatModel.bindStream(FireStoreChat()
        .getChatforServiceProvider(_serviceProviderModel.serviceProviderId));
  }

  getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getServiceProvider.then((value) {
      _serviceProviderModel = value!;
    });
    _loading.value = false;
    update();
  }
}

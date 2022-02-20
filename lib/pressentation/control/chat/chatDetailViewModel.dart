import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/control/chat/chatModel.dart';
import 'package:yeeo/pressentation/control/chat/messageModel.dart';
import 'package:yeeo/pressentation/control/userControl/chat/service/firestoreChat.dart';

class ChatDetailViewModel extends GetxController {
  ChatDetailViewModel({
    Key? key,
    required this.chatModel,
  });
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  List<MessageModel> get messageModel => _messageModel;
  List<MessageModel> _messageModel = [];
  String? message;
  ChatModel? chatModel;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void onInit() async {
    super.onInit();
    await getMessage(chatModel!.chatId);
  }

  getMessage(chatId) async {
    _loading.value = true;
    await FireStoreChat().getMessages(chatId).then((value) {
      for (int i = 0; i < value.length; i++) {
        _messageModel.add(MessageModel.fromJson(value[i].data()));

        _loading.value = false;
        update();
      }
    });
  }

  void sendMessage(chatId, uid) async {
    textEditingController.clear();
    update();
    MessageModel messageModel = MessageModel(
      sender: uid,
      message: message!,
      timeStamp: DateTime.now().toString(),
    );
    await FireStoreChat().addMessage(chatId, messageModel.toJson());
    await FireStoreChat().editChat(chatId, messageModel.timeStamp,
        messageModel.message, messageModel.sender);
    _messageModel.clear();
    getMessage(chatId);
    message = null;
    update();
  }
}

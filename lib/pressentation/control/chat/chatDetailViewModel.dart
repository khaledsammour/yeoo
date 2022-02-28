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
  RxList<MessageModel> messageModel = RxList([]);

  String? message;
  ChatModel? chatModel;
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void onReady() async {
    super.onReady();
    messageModel.bindStream(FireStoreChat().getMessages(chatModel!.chatId));
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
    
    message = null;
    update();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';

class ChatModel {
  late String chatId,
      userId,
      serviceProviderId,
      lastTimeStamp,
      lastmessage,
      userName,
      serviceProviderName,
      serviceProviderImg,
      lastMessageRead,
      lastSender;
  ChatModel({
    required this.userId,
    required this.serviceProviderId,
    required this.userName,
    required this.serviceProviderName,
    required this.serviceProviderImg,
  });

  ChatModel.fromJson(DocumentSnapshot documentSnapshot) {
    chatId = documentSnapshot['chatId'];
    userId = documentSnapshot['userId'];
    serviceProviderId = documentSnapshot['serviceProviderId'];
    lastTimeStamp = documentSnapshot['lastTimeStamp'];
    lastmessage = documentSnapshot['lastmessage'];
    lastSender = documentSnapshot['lastSender'];
    userName = documentSnapshot['userName'];
    serviceProviderName = documentSnapshot['serviceProviderName'];
    serviceProviderImg = documentSnapshot['serviceProviderImg'];
    lastMessageRead = documentSnapshot['lastMessageRead'];
  }
  toJson(
    chatId,
  ) {
    return {
      'chatId': chatId,
      'userId': userId,
      'serviceProviderId': serviceProviderId,
      'userName': userName,
      'serviceProviderImg': serviceProviderImg,
      'serviceProviderName': serviceProviderName,
      'lastTimeStamp': DateTime.now().toString(),
      'lastmessage': "",
      'lastSender': "",
      'lastMessageRead': false.toString(),
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  late String sender, message, timeStamp, read;
  MessageModel({
    required this.sender,
    required this.message,
    required this.timeStamp,
  });

  MessageModel.fromJson(DocumentSnapshot documentSnapshot) {
    sender = documentSnapshot['sender'];

    message = documentSnapshot['message'];
    timeStamp = documentSnapshot['timeStamp'];
    read = documentSnapshot['read'];
  }
  toJson() {
    return {
      'sender': sender,
      'message': message,
      'timeStamp': timeStamp,
      'read': "false",
    };
  }
}

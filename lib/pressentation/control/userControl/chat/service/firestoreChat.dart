import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yeeo/pressentation/control/chat/chatModel.dart';
import 'package:yeeo/pressentation/control/chat/messageModel.dart';

import '../../../../auth/serviceProviderModel.dart';

class FireStoreChat {
  final CollectionReference _serviceProviderCollectionRef =
      FirebaseFirestore.instance.collection('serviceProvider');
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference _chatCollectionRef =
      FirebaseFirestore.instance.collection('chat');

  Future<DocumentSnapshot> getserviceProvider(String uid) async {
    return await _serviceProviderCollectionRef.doc(uid).get();
  }

  Future<DocumentSnapshot> getuser(String uid) async {
    return await _userCollectionRef.doc(uid).get();
  }

  Stream<List<ChatModel>> getChat(userId) {
    return _chatCollectionRef
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ChatModel> chatModel = [];
      for (var chatModelq in query.docs) {
        final chatModels = ChatModel.fromJson(chatModelq);
        chatModel.add(chatModels);
      }

      return chatModel;
    });
  }

  Stream<List<ChatModel>> getChatforServiceProvider(serviceProviderId) {
    return _chatCollectionRef
        .where("serviceProviderId", isEqualTo: serviceProviderId)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ChatModel> chatModel = [];
      for (var chatModelq in query.docs) {
        final chatModels = ChatModel.fromJson(chatModelq);
        chatModel.add(chatModels);
      }

      return chatModel;
    });
  }

  Future<List<QueryDocumentSnapshot>> getChatServiceProvider(userId) async {
    var value = await _chatCollectionRef
        .where("serviceProviderId", isEqualTo: userId)
        .get();
    return value.docs;
  }

  Future<void> addChatToFirestore(ChatModel chatModel) async {
    var v = _chatCollectionRef.doc();
    await v.set(chatModel.toJson(v.id));
  }

  Stream<List<MessageModel>> getMessages(id) {
    return _chatCollectionRef
        .doc(id)
        .collection("message")
        .orderBy("timeStamp", descending: false)
        .snapshots()
        .map((QuerySnapshot query) {
      List<MessageModel> messageModel = [];
      for (var messageModelq in query.docs) {
        final messageModels = MessageModel.fromJson(messageModelq);
        messageModel.add(messageModels);
      }
      return messageModel;
    });
  }

  addMessage(chatId, messageModel) async {
    return await _chatCollectionRef
        .doc(chatId)
        .collection("message")
        .doc()
        .set(messageModel);
  }

  editChat(chatId, lastTimeStamp, lastmessage, lastSender) async {
    return await _chatCollectionRef.doc(chatId).update({
      "lastTimeStamp": lastTimeStamp,
      "lastmessage": lastmessage,
      "lastSender": lastSender
    });
  }
}

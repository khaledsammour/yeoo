import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yeeo/pressentation/control/chat/chatModel.dart';

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

  Future<List<QueryDocumentSnapshot>> getChat(userId) async {
    var value =
        await _chatCollectionRef.where("userId", isEqualTo: userId).get();
    return value.docs;
  }

  Future<List<QueryDocumentSnapshot>> getChatServiceProvider(userId) async {
    var value = await _chatCollectionRef
        .where("serviceProviderId", isEqualTo: userId)
        .get();
    return value.docs;
  }

  Future<void> addChatToFirestore(ChatModel chatModel) async {
    var v = _chatCollectionRef.doc();
    v.set(chatModel.toJson(v.id));
  }

  Future<List<QueryDocumentSnapshot>> getMessages(id) async {
    var value = await _chatCollectionRef
        .doc(id)
        .collection("message")
        .orderBy("timeStamp", descending: false)
        .get();
    return value.docs;
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

class ChatModel {
  late String chatId,
      userId,
      serviceProviderId,
      lastTimeStamp,
      lastmessage,
      lastSender;
  ChatModel({
    required this.userId,
    required this.serviceProviderId,
  });

  ChatModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    chatId = map['chatId'];
    userId = map['userId'];
    serviceProviderId = map['serviceProviderId'];
    lastTimeStamp = map['lastTimeStamp'];
    lastmessage = map['lastmessage'];
    lastSender = map['lastSender'];
  }
  toJson(
    chatId,
  ) {
    return {
      'chatId': chatId,
      'userId': userId,
      'serviceProviderId': serviceProviderId,
      'lastTimeStamp': DateTime.now().toString(),
      'lastmessage': "",
      'lastSender': "",
    };
  }
}

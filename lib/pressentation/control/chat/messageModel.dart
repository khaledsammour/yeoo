class MessageModel {
  late String sender, message, timeStamp, read;
  MessageModel({
    required this.sender,
    required this.message,
    required this.timeStamp,
  });

  MessageModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }

    sender = map['sender'];

    message = map['message'];
    timeStamp = map['timeStamp'];
    read = map['read'];
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

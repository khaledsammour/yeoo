class UserModel {
  late String userId, email, userName, password;
  UserModel({
    required this.userId,
    required this.email,
    required this.userName,
    required this.password,
  });

  UserModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    email = map['email'];
    userName = map['userName'];
    password = map['password'];
  }
  toJson(v) {
    return {
      'userId': v,
      'email': email,
      'userName': userName,
      'password': password,
    };
  }
}

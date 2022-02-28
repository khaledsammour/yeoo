import 'package:cloud_firestore/cloud_firestore.dart';

class JobModel {
  late String userId,
      jobDetail,
      availabilityFrom,
      availabilityTo,
      budgetFrom,
      budgetTo,
      location,
      service,
      accepted,
      opened,
      reported,
      timeStamp,
      jobId,
      userName;
  late List images;
  late List like;
  late List repledIds;
  JobModel({
    required this.userId,
    required this.userName,
    required this.jobDetail,
    required this.images,
    required this.availabilityFrom,
    required this.availabilityTo,
    required this.budgetFrom,
    required this.budgetTo,
    required this.location,
    required this.service,
  });

  JobModel.fromJson(DocumentSnapshot documentSnapshot) {
    userId = documentSnapshot["userId"];
    userName = documentSnapshot["userName"];
    jobDetail = documentSnapshot["jobDetail"];
    availabilityFrom = documentSnapshot["availabilityFrom"];
    availabilityTo = documentSnapshot["availabilityTo"];
    budgetFrom = documentSnapshot["budgetFrom"];
    budgetTo = documentSnapshot["budgetTo"];
    location = documentSnapshot["location"];
    service = documentSnapshot["service"];
    images = documentSnapshot["images"];
    accepted = documentSnapshot["accepted"];
    opened = documentSnapshot["opened"];
    reported = documentSnapshot["reported"];
    like = documentSnapshot["like"];
    timeStamp = documentSnapshot["timeStamp"];
    jobId = documentSnapshot["jobId"];
    repledIds = documentSnapshot["repledIds"];
  }
  JobModel.fromJsonNoUpdate(Map<dynamic, dynamic> map) {
    if (map == null) {}
    {
      userId = map["userId"];
      userName = map["userName"];
      jobDetail = map["jobDetail"];
      availabilityFrom = map["availabilityFrom"];
      availabilityTo = map["availabilityTo"];
      budgetFrom = map["budgetFrom"];
      budgetTo = map["budgetTo"];
      location = map["location"];
      service = map["service"];
      images = map["images"];
      accepted = map["accepted"];
      opened = map["opened"];
      reported = map["reported"];
      like = map["like"];
      timeStamp = map["timeStamp"];
      jobId = map["jobId"];
      repledIds = map["repledIds"];
    }
  }
  toJson(v) {
    return {
      'userId': userId,
      'userName': userName,
      'jobDetail': jobDetail,
      'availabilityFrom': availabilityFrom,
      'availabilityTo': availabilityTo,
      'budgetFrom': budgetFrom,
      'budgetTo': budgetTo,
      'location': location,
      'service': service,
      'images': images,
      'timeStamp': DateTime.now().toString(),
      'like': [],
      'repledIds': [],
      'accepted': "false",
      'reported': "false",
      'opened': "false",
      'jobId': v,
    };
  }
}

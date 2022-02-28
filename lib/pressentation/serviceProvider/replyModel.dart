import 'package:cloud_firestore/cloud_firestore.dart';

class ReplyModel {
  late String jobDetail,
      availabilityFrom,
      availabilityTo,
      duration,
      budgetFrom,
      budgetTo,
      location,
      accepted,
      userId,
      userName,
      jobId,
      serviceProviderId,
      service,
      reported,
      timeStamp,
      rejected;
  String? replyId;
  late List images;
  late List like;

  ReplyModel({
    required this.jobDetail,
    required this.images,
    required this.availabilityFrom,
    required this.availabilityTo,
    required this.budgetFrom,
    required this.budgetTo,
    required this.location,
    required this.duration,
    required this.userId,
    required this.userName,
    required this.serviceProviderId,
    required this.jobId,
    required this.service,
  });

  ReplyModel.fromJson(DocumentSnapshot documentSnapshot) {
    replyId = documentSnapshot.id;
    jobDetail = documentSnapshot['jobDetail'];
    availabilityFrom = documentSnapshot['availabilityFrom'];
    availabilityTo = documentSnapshot['availabilityTo'];
    budgetFrom = documentSnapshot['budgetFrom'];
    budgetTo = documentSnapshot['budgetTo'];
    location = documentSnapshot['location'];
    images = documentSnapshot['images'];
    accepted = documentSnapshot['accepted'];
    rejected = documentSnapshot['rejected'];
    duration = documentSnapshot['duration'];
    like = documentSnapshot['like'];
    userId = documentSnapshot['userId'];
    userName = documentSnapshot['userName'];
    jobId = documentSnapshot['jobId'];
    serviceProviderId = documentSnapshot['serviceProviderId'];
    service = documentSnapshot['service'];
    timeStamp = documentSnapshot['timeStamp'];
    reported = documentSnapshot['reported'];
  }
  toJson() {
    return {
      'jobDetail': jobDetail,
      'availabilityFrom': availabilityFrom,
      'availabilityTo': availabilityTo,
      'budgetFrom': budgetFrom,
      'budgetTo': budgetTo,
      'location': location,
      'images': images,
      'duration': duration,
      'userId': userId,
      'userName': userName,
      'jobId': jobId,
      'serviceProviderId': serviceProviderId,
      'service': service,
      'timeStamp': DateTime.now().toString(),
      'reported': "false",
      'like': [],
      'accepted': "false",
      'rejected': "false",
    };
  }
}

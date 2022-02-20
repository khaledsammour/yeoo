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
      jobId,
      serviceProviderId,
      service,
      like,
      rejected;
  late List images;
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
    required this.serviceProviderId,
    required this.jobId,
    required this.service,
  });

  ReplyModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    jobDetail = map['jobDetail'];
    availabilityFrom = map['availabilityFrom'];
    availabilityTo = map['availabilityTo'];
    budgetFrom = map['budgetFrom'];
    budgetTo = map['budgetTo'];
    location = map['location'];
    images = map['images'];
    accepted = map['accepted'];
    rejected = map['rejected'];
    duration = map['duration'];
    like = map['like'];
    userId = map['userId'];
    jobId = map['jobId'];
    serviceProviderId = map['serviceProviderId'];
    service = map['service'];
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
      'jobId': jobId,
      'serviceProviderId': serviceProviderId,
      'service': service,
      'like': "false",
      'accepted': "false",
      'rejected': "false",
    };
  }
}

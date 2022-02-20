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
      jobId;
  late List images;
  late List like;
  JobModel({
    required this.userId,
    required this.jobDetail,
    required this.images,
    required this.availabilityFrom,
    required this.availabilityTo,
    required this.budgetFrom,
    required this.budgetTo,
    required this.location,
    required this.service,
  });

  JobModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    userId = map['userId'];
    jobDetail = map['jobDetail'];
    availabilityFrom = map['availabilityFrom'];
    availabilityTo = map['availabilityTo'];
    budgetFrom = map['budgetFrom'];
    budgetTo = map['budgetTo'];
    location = map['location'];
    service = map['service'];
    images = map['images'];
    accepted = map['accepted'];
    opened = map['opened'];
    reported = map['reported'];
    like = map['like'];
    jobId = map['jobId'];
  }
  toJson(v) {
    return {
      'userId': userId,
      'jobDetail': jobDetail,
      'availabilityFrom': availabilityFrom,
      'availabilityTo': availabilityTo,
      'budgetFrom': budgetFrom,
      'budgetTo': budgetTo,
      'location': location,
      'service': service,
      'images': images,
      'like': [],
      'accepted': "false",
      'reported': "false",
      'opened': "false",
      'jobId': v,
    };
  }
}

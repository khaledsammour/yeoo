class ServiceProviderModel {
  late String serviceProviderId,
      userName,
      password,
      phoneNumber,
      jobTitle,
      companyLogo,
      location;
  late List tradeLicense;
  ServiceProviderModel({
    required this.serviceProviderId,
    required this.userName,
    required this.phoneNumber,
    required this.jobTitle,
    required this.companyLogo,
    required this.location,
    required this.tradeLicense,
    required this.password,
  });

  ServiceProviderModel.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) {
      return;
    }
    serviceProviderId = map['serviceProviderId'];
    userName = map['userName'];
    jobTitle = map['jobTitle'];
    phoneNumber = map['phoneNumber'];
    companyLogo = map['companyLogo'];
    location = map['location'];
    tradeLicense = map['tradeLicense'];
    password = map['password'];
  }
  toJson() {
    return {
      'serviceProviderId': serviceProviderId,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'jobTitle': jobTitle,
      'companyLogo': companyLogo,
      'location': location,
      'tradeLicense': tradeLicense,
      'password': password,
    };
  }
}

class ServiceProviderModel {
  late String serviceProviderId,
      userName,
      password,
      phoneNumber,
      jobTitle,
      companyLogo,
      latitude,
      longitude,
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
    required this.latitude,
    required this.longitude,
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
    latitude = map['latitude'];
    longitude = map['longitude'];
  }
  toJson(v) {
    return {
      'serviceProviderId': v,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'jobTitle': jobTitle,
      'companyLogo': companyLogo,
      'location': location,
      'tradeLicense': tradeLicense,
      'password': password,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

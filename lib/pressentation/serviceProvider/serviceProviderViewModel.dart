import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/serviceProvider/replyModel.dart';
import 'package:yeeo/pressentation/serviceProvider/service/fireStoreServiceProvider.dart';
import 'package:yeeo/pressentation/serviceProvider/serviceModel.dart';
import 'package:yeeo/pressentation/user/jobModel.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class ServiceProviderViewModel extends GetxController {
  var opened = false;
  var filter = false;
  var sending = false;
  var likeSelected = false;
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  late FocusNode focusNode;
  final LocalStorageData localStorageData = Get.find();
  ServiceProviderModel get serviceProviderModel => _serviceProviderModel;
  late ServiceProviderModel _serviceProviderModel;
  RxList<JobModel> swimming = RxList([]);
  RxList<JobModel> insect = RxList([]);
  RxList<JobModel> constr = RxList([]);
  RxList<JobModel> tech = RxList([]);
  RxList<JobModel> lands = RxList([]);
  RxList<JobModel> carp = RxList([]);

  String duration = "0";
  String? jobDetail, budgetFrom = "0", budgetTo = "0";
  DateTime? availabilityFrom = DateTime.now(), availabilityTo = DateTime.now();

  getCurrentServiceProvider() async {
    _loading.value = true;
    await localStorageData.getServiceProvider.then((value) {
      _serviceProviderModel = value!;
    });
    _loading.value = false;
    update();
  }

  var filterIndex = 0;
  var filterType = ['old', 'new'];

  @override
  void onReady() async {
    // TODO: implement dispose
    await getCurrentServiceProvider();
    focusNode = FocusNode();
    swimming.bindStream(FireStoreServiceProvider().getService(
        HomeStrings.swimmingPool, _serviceProviderModel.serviceProviderId));
    tech.bindStream(FireStoreServiceProvider()
        .getService(HomeStrings.tech, _serviceProviderModel.serviceProviderId));
    insect.bindStream(FireStoreServiceProvider().getService(
        HomeStrings.insect, _serviceProviderModel.serviceProviderId));
    carp.bindStream(FireStoreServiceProvider()
        .getService(HomeStrings.carp, _serviceProviderModel.serviceProviderId));
    constr.bindStream(FireStoreServiceProvider()
        .getService(HomeStrings.cons, _serviceProviderModel.serviceProviderId));
    lands.bindStream(FireStoreServiceProvider().getService(
        HomeStrings.lands, _serviceProviderModel.serviceProviderId));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();

    super.dispose();
  }

  var filterTypeIndex = 0;

  like(JobModel jobModel) async {
    await FireStoreServiceProvider().addLike(jobModel);

    update();
  }

  getBudget(from, to) {
    return (int.parse(from) + int.parse(from)) / 2;
  }

  late List img = [];
  late List imgFirebase = [];
  late List imgUrl = [];
  Future getImageFromCamera() async {
    XFile? pickedFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      img.add(XFile(pickedFile.path).path);
      imgFirebase.add(File(pickedFile.path));
    } else {
      print('No image selected.');
    }
    update();
  }

  Future getImage() async {
    List<XFile>? pickedFile = await ImagePicker().pickMultiImage();
    if (pickedFile != null) {
      for (var i = 0; i < pickedFile.length; i++) {
        img.add(XFile(pickedFile[i].path).path);
        imgFirebase.add(File(pickedFile[i].path));
      }
    } else {
      print('No image selected.');
    }
    update();
  }

  late List refrence = [];
  Future<void> uploadFile() async {
    for (var i = 0; i < img.length; i++) {
      String ref = 'uploads/replys/' +
          _serviceProviderModel.serviceProviderId +
          "/" +
          img[i].toString();
      try {
        await firebase_storage.FirebaseStorage.instance
            .ref(ref)
            .putFile(imgFirebase[i]);
      } on firebase_core.FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        print(e);
      }
      refrence.add(ref);
    }

    update();
  }

  Future<void> downloadUrl() async {
    for (var i = 0; i < img.length; i++) {
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(refrence[i])
          .getDownloadURL();
      imgUrl.add(downloadURL);
    }
    print(imgUrl);

    // Within your widgets:
    // Image.network(downloadURL);
    update();
  }

  send(JobModel jobModel, userId) async {
    sending = true;
    update();
    await uploadFile();
    await downloadUrl();
    jobModel.repledIds.add(_serviceProviderModel.serviceProviderId);
    reply(userId, jobModel);
    sending = false;

    update();
  }

  reply(userId, JobModel jobModel) {
    var replyModel = ReplyModel(
      jobId: jobModel.jobId,
      jobDetail: jobDetail!,
      images: imgUrl,
      availabilityFrom: availabilityFrom.toString(),
      availabilityTo: availabilityTo.toString(),
      budgetFrom: budgetFrom!,
      budgetTo: budgetTo!,
      location: _serviceProviderModel.location,
      duration: duration,
      userId: userId,
      service: jobModel.service,
      serviceProviderId: _serviceProviderModel.serviceProviderId,
      userName: _serviceProviderModel.userName,
    );

    FireStoreServiceProvider().addReply(jobModel.jobId,
        _serviceProviderModel.serviceProviderId, replyModel.toJson(), jobModel);
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:yeeo/pressentation/user/jobModel.dart';
import 'package:yeeo/pressentation/user/service/fireStoreService.dart';

class UserViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  final LocalStorageData localStorageData = Get.find();

  UserModel get userModel => _userModel;
  late UserModel _userModel;
  var tapped = false;
  var longPressed = false;

  var send = false;
  var service = [
    HomeStrings.swimmingPool,
    HomeStrings.insect,
    HomeStrings.cons,
    HomeStrings.tech,
    HomeStrings.lands,
    HomeStrings.carp
  ];
  var serviceIndex = 0;
  var locations = [
    locationStrings.amman,
    locationStrings.dubai,
    locationStrings.cario,
  ];
  var locationIndex = 0;
  var locationIndexSelected = 0;
  var budgetFromSelected = "0";
  var budgetToSelected = "0";
  var budgetFrom = "0";
  var budgetTo = "0";
  DateTime availabilityFrom = DateTime.now();
  DateTime availabilityFromSelected = DateTime.now();
  DateTime availabilityTo = DateTime.now();
  DateTime availabilityToSelected = DateTime.now();
  List<XFile> imageFile = [];
  String jobDetail = "";
  TextEditingController textEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  @override
  void onInit() async {
    super.onInit();
    await getCurrentUser();
  }

  getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    _loading.value = false;
    update();
  }

  sending() async {
    if (jobDetail == "") {
      Get.snackbar("job details is empty", "please type job details");
    } else if (img.length == 0) {
      Get.snackbar("img is empty", "please choose one image atleast");
    } else if (availabilityFrom == availabilityTo) {
      Get.snackbar("availability is same",
          "please choose availability From and availability To");
    } else if (budgetFrom == "0" && budgetTo == "0") {
      Get.snackbar(
          "budget is empty", "please choose budget From and budget To");
    } else if (locationIndex == null) {
      Get.snackbar("location is empty", "please choose your location");
    } else if (serviceIndex == null) {
      Get.snackbar("service is empty", "please choose a service");
    } else {
      send = true;
      update();
      await uploadFile();
      await downloadUrl();
      await saveService();
      focusNode.unfocus();
      textEditingController.clear();
      tapped = false;
      img.clear();
      imgFirebase.clear();
      imgUrl.clear();
      availabilityFrom = DateTime.now();
      availabilityTo = DateTime.now();
      budgetFrom = "0";
      budgetTo = "0";
      locationIndex = 0;
      serviceIndex = 0;
      send = false;
      update();
    }
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
      String ref = 'uploads/' + _userModel.userId + "/" + img[i].toString();
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

  saveService() async {
    JobModel jobModel = JobModel(
      userId: _userModel.userId,
      userName: _userModel.userName,
      jobDetail: jobDetail,
      images: imgUrl,
      availabilityFrom: availabilityFrom.toString(),
      availabilityTo: availabilityTo.toString(),
      budgetFrom: budgetFrom,
      budgetTo: budgetTo,
      location: locations[locationIndex],
      service: service[serviceIndex],
    );

    await FireStoreService().addServiceToFirestore(jobModel);
  }
}

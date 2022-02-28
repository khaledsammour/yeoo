import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yeeo/pressentation/auth/loading.dart';
import 'package:yeeo/pressentation/auth/service/fireStoreUser.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/control/userControl/controlView.dart';
import 'package:yeeo/pressentation/control/userControl/controlViewModel.dart';
import 'package:yeeo/pressentation/control/serviceProviderControl/controleViewService.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class AuthViewModel extends GetxController {
  var userSelected = true;
  var terms = false;
  var privacy = false;
  var notSame = false;
  var pass = true;
  var confirmPass = true;
  ServiceProviderModel? get serviceProviderModel => _serviceProviderModel;
  ServiceProviderModel? _serviceProviderModel;
  UserModel? get userModel => _userModel;
  UserModel? _userModel;
  List<UserModel> get userModelList => _userModelList;
  List<UserModel> _userModelList = [];
  List<ServiceProviderModel> get serviceProviderList => _serviceProviderList;
  List<ServiceProviderModel> _serviceProviderList = [];
  late FocusNode focusNode;
  late FocusNode passwordfocusNode;
  late FocusNode confirmPasswordfocusNode;
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  getToHome() async {
    Get.to(LoadingView());
    await Future.delayed(Duration(seconds: 1));
    Get.offAll(ControlView());
  }

  getToServiceProvider() async {
    Get.to(LoadingView());
    await Future.delayed(Duration(seconds: 1));
    Get.offAll(ControlViewService());
  }

  late String email, password, name, userName;
  late String phoneNumber, jobTitle, location;
  late double latitude, longitude;
  String? cityName, areaName;
  late List tradeLicense;

  final LocalStorageData localStorageData = Get.find();
  TextEditingController? emailController, passwordController;

  @override
  void onInit() async {
    super.onInit();
    focusNode = FocusNode();
    passwordfocusNode = FocusNode();
    confirmPasswordfocusNode = FocusNode();
    await getUsersFromLocal();
    await getUsers();
    await getServiceProciders();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getAddressFromLatLong() async {
    var position = Position(
      latitude: latitude,
      longitude: longitude,
      accuracy: 0.0,
      altitude: 0.0,
      heading: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
      timestamp: DateTime.now(),
    );
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark place = placemarks[0];
    cityName = place.locality;
    areaName = place.subLocality;
  }

  getCurrentUser() async {
    await localStorageData.getUser.then((value) {
      _userModel = value;
    });
  }

  getCurrentServiceProvider() async {
    await localStorageData.getServiceProvider.then((value) {
      _serviceProviderModel = value;
    });
  }

  getUsersFromLocal() async {
    await getCurrentUser();
    await getCurrentServiceProvider();
    if (_userModel != null) {
      getToHome();
    } else if (_serviceProviderModel != null) {
      Get.offAll(ControlViewService());
    } else {
      print("noUser");
    }
  }

  void signInUser() async {
    try {
      var found = false;
      for (int i = 0; i < _userModelList.length; i++) {
        if (_userModelList[i].userName == userName) {
          if (_userModelList[i].password == password) {
            found = true;
            getCurrentUserData(_userModelList[i].userId);

            break;
          } else {
            found = true;
            Get.snackbar("wrong Password", "please type the right password");
            break;
          }
        }
      }
      if (found == false) {
        Get.snackbar("no user", "please type the right userName or signUp");
      }
    } catch (e) {
      Get.snackbar('Error login account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  getUsers() async {
    _loading.value = true;
    await FireStoreUser().getUsers().then((value) {
      for (int i = 0; i < value.length; i++) {
        _userModelList
            .add(UserModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
      }
    });
    _loading.value = false;
    update();
  }

  getServiceProciders() async {
    _loading.value = true;
    await FireStoreUser().getServiceProviders().then((value) {
      for (int i = 0; i < value.length; i++) {
        _serviceProviderList.add(ServiceProviderModel.fromJson(
            value[i].data() as Map<dynamic, dynamic>));
      }
    });
    _loading.value = false;
    update();
  }

  signUpUser() async {
    try {
      await saveUser();
    } catch (e) {
      Get.snackbar('Error Create account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  loginService() async {
    try {
      var found = false;
      for (int i = 0; i < _serviceProviderList.length; i++) {
        if (_serviceProviderList[i].userName == userName) {
          if (_serviceProviderList[i].password == password) {
            found = true;

            getCurrentServiceProviderData(
                _serviceProviderList[i].serviceProviderId);

            break;
          } else {
            found = true;
            Get.snackbar("wrong Password", "please type the right password");
            break;
          }
        }
      }
      if (found == false) {
        Get.snackbar("no user", "please type the right userName or signUp");
      }
    } catch (e) {
      Get.snackbar('Error Create account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  saveUser() async {
    UserModel userModel = UserModel(
      userId: userName,
      email: email,
      userName: userName,
      password: password,
    );
    var notSame = true;

    for (int i = 0; i < _userModelList.length; i++) {
      if (_userModelList[i].userName == userModel.userName) {
        notSame = false;
        Get.snackbar("wrong", "userName is already taken");
        break;
      }
      if (_userModelList[i].email == userModel.email) {
        notSame = false;
        Get.snackbar("wrong", "email is already taken");
        break;
      }
    }
    if (notSame == true) {
      await FireStoreUser().addUserToFireStore(userModel);

      setUser(userModel);
    }
  }

  saveServiceProvider() async {
    ServiceProviderModel serviceProviderModel = ServiceProviderModel(
      latitude: latitude.toString(),
      longitude: longitude.toString(),
      serviceProviderId: userName,
      userName: userName,
      phoneNumber: phoneNumber,
      jobTitle: jobTitle,
      companyLogo: logoUrl!,
      location: cityName! + "," + areaName!,
      tradeLicense: imgUrl,
      password: password,
    );
    var notSame = true;
    for (int i = 0; i < _serviceProviderList.length; i++) {
      if (_serviceProviderList[i].userName == serviceProviderModel.userName) {
        notSame = false;
        Get.snackbar("wrong", "userName is already taken");
        break;
      }
    }
    if (notSame == true) {
      await FireStoreUser().addServiceProviderToFireStore(serviceProviderModel);

      await setServiceprovider(serviceProviderModel);
    }
  }

  void getCurrentUserData(String uid) async {
    await FireStoreUser().getCurrentUser(uid).then((value) {
      setUser(UserModel.fromJson(value.data() as Map<dynamic, dynamic>));
    });
  }

  getCurrentServiceProviderData(String uid) async {
    await FireStoreUser().getCurrentServiceProvider(uid).then((value) {
      setServiceprovider(
          ServiceProviderModel.fromJson(value.data() as Map<dynamic, dynamic>));
    });
  }

  void setUser(UserModel userModel) async {
    await localStorageData.setUser(userModel);
    getToHome();
  }

  setServiceprovider(ServiceProviderModel serviceProviderModel) async {
    await localStorageData.setServiceProvider(serviceProviderModel);
    getToServiceProvider();
  }

  signUpService() async {
    try {
      await uploadFile();
      await downloadUrl();
      await saveServiceProvider();
    } catch (e) {
      Get.snackbar('Error Create account', e.toString(),
          colorText: Colors.black, snackPosition: SnackPosition.BOTTOM);
    }
  }

  late List img = [];
  late List imgFirebase = [];
  var logoFirebase;
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

  var companyLogo;
  var companyLogoUrl;
  Future getImageLogo() async {
    XFile? pickedLogo =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedLogo != null) {
      companyLogo = XFile(pickedLogo.path).path;
      logoFirebase = File(pickedLogo.path);
    } else {
      print('No image selected.');
    }
    update();
  }

  Future getImageLogoFromCamera() async {
    XFile? pickedLogo =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedLogo != null) {
      companyLogo = XFile(pickedLogo.path).path;
      logoFirebase = File(pickedLogo.path);
    } else {
      print('No image selected.');
    }
    update();
  }

  late List refrence = [];
  var logorefrence;
  Future<void> uploadFile() async {
    for (var i = 0; i < img.length; i++) {
      String ref = 'uploads/' + userName + "/" + img[i].toString();

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
    String refLogo = 'uploads/' + userName + "/" + "logo";
    await firebase_storage.FirebaseStorage.instance
        .ref(refLogo)
        .putFile(logoFirebase);
    logorefrence = refLogo;
    update();
  }

  String? logoUrl;
  Future<void> downloadUrl() async {
    for (var i = 0; i < img.length; i++) {
      String downloadURL = await firebase_storage.FirebaseStorage.instance
          .ref(refrence[i])
          .getDownloadURL();
      imgUrl.add(downloadURL);
    }
    String downloadLogoUrl = await firebase_storage.FirebaseStorage.instance
        .ref(logorefrence)
        .getDownloadURL();
    logoUrl = downloadLogoUrl;
    // Within your widgets:
    // Image.network(downloadURL);
    update();
  }
}

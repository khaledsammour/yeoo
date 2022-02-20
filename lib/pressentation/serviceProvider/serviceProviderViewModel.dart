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
  List<JobModel> get jobModel => _jobModel;
  List<JobModel> _jobModel = [];
  List<JobModel> get jobModelSwimming => _jobModelSwimming;
  List<JobModel> _jobModelSwimming = [];
  List<JobModel> get jobModelInsect => _jobModelInsect;
  List<JobModel> _jobModelInsect = [];
  List<JobModel> get jobModelConst => _jobModelConst;
  List<JobModel> _jobModelConst = [];
  List<JobModel> get jobModelTech => _jobModelTech;
  List<JobModel> _jobModelTech = [];
  List<JobModel> get jobModelLands => _jobModelLands;
  List<JobModel> _jobModelLands = [];
  List<JobModel> get jobModelCarp => _jobModelCarp;
  List<JobModel> _jobModelCarp = [];

  List<JobModel> get likedJobModelSwimming => _likedJobModelSwimming;
  List<JobModel> _likedJobModelSwimming = [];
  List<JobModel> get likedJobModelInsect => _likedJobModelInsect;
  List<JobModel> _likedJobModelInsect = [];
  List<JobModel> get likedJobModelConst => _likedJobModelConst;
  List<JobModel> _likedJobModelConst = [];
  List<JobModel> get likedJobModelTech => _likedJobModelTech;
  List<JobModel> _likedJobModelTech = [];
  List<JobModel> get likedJobModelLands => _likedJobModelLands;
  List<JobModel> _likedJobModelLands = [];
  List<JobModel> get likedJobModelCarp => _likedJobModelCarp;
  List<JobModel> _likedJobModelCarp = [];

  List<UserModel> get likedUserModelSwimming => _likedUserModelSwimming;
  List<UserModel> _likedUserModelSwimming = [];
  List<UserModel> get likedUserModelInsect => _likedUserModelInsect;
  List<UserModel> _likedUserModelInsect = [];
  List<UserModel> get likedUserModelConst => _likedUserModelConst;
  List<UserModel> _likedUserModelConst = [];
  List<UserModel> get likedUserModelTech => _likedUserModelTech;
  List<UserModel> _likedUserModelTech = [];
  List<UserModel> get likedUserModelLands => _likedUserModelLands;
  List<UserModel> _likedUserModelLands = [];
  List<UserModel> get likedUserModelCarp => _likedUserModelCarp;
  List<UserModel> _likedUserModelCarp = [];

  List<UserModel> get userModelSwimming => _userModelSwimming;
  List<UserModel> _userModelSwimming = [];
  List<UserModel> get userModelInsect => _userModelInsect;
  List<UserModel> _userModelInsect = [];
  List<UserModel> get userModelConst => _userModelConst;
  List<UserModel> _userModelConst = [];
  List<UserModel> get userModelTech => _userModelTech;
  List<UserModel> _userModelTech = [];
  List<UserModel> get userModelLands => _userModelLands;
  List<UserModel> _userModelLands = [];
  List<UserModel> get userModelCarp => _userModelCarp;
  List<UserModel> _userModelCarp = [];

  List<ReplyModel> get onGoing => _onGoing;
  List<ReplyModel> _onGoing = [];
  List<ReplyModel> get onGoingSwimming => _onGoingSwimming;
  List<ReplyModel> _onGoingSwimming = [];
  List<ReplyModel> get onGoingInsect => _onGoingInsect;
  List<ReplyModel> _onGoingInsect = [];
  List<ReplyModel> get onGoingConst => _onGoingConst;
  List<ReplyModel> _onGoingConst = [];
  List<ReplyModel> get onGoingTech => _onGoingTech;
  List<ReplyModel> _onGoingTech = [];
  List<ReplyModel> get onGoingLands => _onGoingLands;
  List<ReplyModel> _onGoingLands = [];
  List<ReplyModel> get onGoingCarp => _onGoingCarp;
  List<ReplyModel> _onGoingCarp = [];

  List<UserModel> get onGoinguserModelSwimming => _onGoinguserModelSwimming;
  List<UserModel> _onGoinguserModelSwimming = [];
  List<UserModel> get onGoinguserModelInsect => _onGoinguserModelInsect;
  List<UserModel> _onGoinguserModelInsect = [];
  List<UserModel> get onGoinguserModelConst => _onGoinguserModelConst;
  List<UserModel> _onGoinguserModelConst = [];
  List<UserModel> get onGoinguserModelTech => _onGoinguserModelTech;
  List<UserModel> _onGoinguserModelTech = [];
  List<UserModel> get onGoinguserModelLands => _onGoinguserModelLands;
  List<UserModel> _onGoinguserModelLands = [];
  List<UserModel> get onGoinguserModelCarp => _onGoinguserModelCarp;
  List<UserModel> _onGoinguserModelCarp = [];
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
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getCurrentServiceProvider();
    focusNode = FocusNode();
    await getService();
    await getOngoing();
    await clear();
    await sortJobmodel();
    await sortOngoing();
    await sortLiked();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    focusNode.dispose();

    super.dispose();
  }

  clear() {
    _loading.value = true;

    for (int x = 0; x < _jobModel.length; x++) {
      for (int y = 0; y < _onGoing.length; y++) {
        if (_jobModel[x].jobId == _onGoing[y].jobId) {
          _jobModel.removeAt(x);
        }
      }
    }
    _loading.value = false;
    update();
  }

  sortOngoing() {
    _loading.value = true;

    for (int i = 0; i < _onGoing.length; i++) {
      if (_onGoing[i].service == HomeStrings.swimmingPool) {
        _onGoingSwimming.add(_onGoing[i]);
        FireStoreServiceProvider().getServiceUser(_onGoing[i].userId).then(
            (value) => _onGoinguserModelSwimming
                .add(UserModel.fromJson(value.data()!)));
      }
      if (_onGoing[i].service == HomeStrings.insect) {
        _onGoingInsect.add(_onGoing[i]);
        FireStoreServiceProvider().getServiceUser(_onGoing[i].userId).then(
            (value) =>
                _onGoinguserModelInsect.add(UserModel.fromJson(value.data()!)));
      }
      if (_onGoing[i].service == HomeStrings.cons) {
        _onGoingConst.add(_onGoing[i]);
        FireStoreServiceProvider().getServiceUser(_onGoing[i].userId).then(
            (value) =>
                _onGoinguserModelConst.add(UserModel.fromJson(value.data()!)));
      }
      if (_onGoing[i].service == HomeStrings.tech) {
        _onGoingTech.add(_onGoing[i]);
        FireStoreServiceProvider().getServiceUser(_onGoing[i].userId).then(
            (value) =>
                _onGoinguserModelTech.add(UserModel.fromJson(value.data()!)));
      }
      if (_onGoing[i].service == HomeStrings.lands) {
        _onGoingTech.add(_onGoing[i]);
        FireStoreServiceProvider().getServiceUser(_onGoing[i].userId).then(
            (value) =>
                _onGoinguserModelLands.add(UserModel.fromJson(value.data()!)));
      }
      if (_onGoing[i].service == HomeStrings.carp) {
        _onGoingCarp.add(_onGoing[i]);
        FireStoreServiceProvider().getServiceUser(_onGoing[i].userId).then(
            (value) =>
                _onGoinguserModelCarp.add(UserModel.fromJson(value.data()!)));
      }
    }
    _loading.value = false;
    update();
  }

  sortJobmodel() {
    _loading.value = true;

    for (int i = 0; i < _jobModel.length; i++) {
      if (_jobModel[i].service == HomeStrings.swimmingPool) {
        _jobModelSwimming.add(_jobModel[i]);
        FireStoreServiceProvider().getServiceUser(_jobModel[i].userId).then(
            (value) =>
                _userModelSwimming.add(UserModel.fromJson(value.data()!)));
      }
      if (_jobModel[i].service == HomeStrings.insect) {
        _jobModelInsect.add(_jobModel[i]);
        FireStoreServiceProvider().getServiceUser(_jobModel[i].userId).then(
            (value) => _userModelInsect.add(UserModel.fromJson(value.data()!)));
      }
      if (_jobModel[i].service == HomeStrings.cons) {
        _jobModelConst.add(_jobModel[i]);
        FireStoreServiceProvider().getServiceUser(_jobModel[i].userId).then(
            (value) => _userModelConst.add(UserModel.fromJson(value.data()!)));
      }
      if (_jobModel[i].service == HomeStrings.tech) {
        _jobModelTech.add(_jobModel[i]);
        FireStoreServiceProvider().getServiceUser(_jobModel[i].userId).then(
            (value) => _userModelTech.add(UserModel.fromJson(value.data()!)));
      }
      if (_jobModel[i].service == HomeStrings.lands) {
        _jobModelTech.add(_jobModel[i]);
        FireStoreServiceProvider().getServiceUser(_jobModel[i].userId).then(
            (value) => _userModelLands.add(UserModel.fromJson(value.data()!)));
      }
      if (_jobModel[i].service == HomeStrings.carp) {
        _jobModelCarp.add(_jobModel[i]);
        FireStoreServiceProvider().getServiceUser(_jobModel[i].userId).then(
            (value) => _userModelCarp.add(UserModel.fromJson(value.data()!)));
      }
    }
    _loading.value = false;
    update();
  }

  sortLiked() {
    _loading.value = true;

    for (int i = 0; i < _jobModelSwimming.length; i++) {
      if (_jobModelSwimming[i]
          .like
          .contains(serviceProviderModel.serviceProviderId)) {
        _likedJobModelSwimming.add(_jobModelSwimming[i]);
        FireStoreServiceProvider()
            .getServiceUser(_jobModelSwimming[i].userId)
            .then((value) =>
                _likedUserModelSwimming.add(UserModel.fromJson(value.data()!)));
        break;
      }
    }
    for (int i = 0; i < _jobModelTech.length; i++) {
      if (_jobModelTech[i]
          .like
          .contains(serviceProviderModel.serviceProviderId)) {
        _likedJobModelTech.add(_jobModelTech[i]);
        FireStoreServiceProvider()
            .getServiceUser(_likedJobModelTech[i].userId)
            .then((value) =>
                _likedUserModelTech.add(UserModel.fromJson(value.data()!)));
        break;
      }
    }
    for (int i = 0; i < _jobModelCarp.length; i++) {
      if (_jobModelCarp[i]
          .like
          .contains(serviceProviderModel.serviceProviderId)) {
        _likedJobModelCarp.add(_jobModelCarp[i]);
        FireStoreServiceProvider()
            .getServiceUser(_likedJobModelCarp[i].userId)
            .then((value) =>
                _likedUserModelCarp.add(UserModel.fromJson(value.data()!)));
        break;
      }
    }
    for (int i = 0; i < _jobModelConst.length; i++) {
      if (_jobModelConst[i]
          .like
          .contains(serviceProviderModel.serviceProviderId)) {
        _likedJobModelConst.add(_jobModelConst[i]);
        FireStoreServiceProvider()
            .getServiceUser(_likedJobModelConst[i].userId)
            .then((value) =>
                _likedUserModelConst.add(UserModel.fromJson(value.data()!)));
        break;
      }
    }
    for (int i = 0; i < _jobModelInsect.length; i++) {
      if (_jobModelInsect[i]
          .like
          .contains(serviceProviderModel.serviceProviderId)) {
        _likedJobModelInsect.add(_jobModelInsect[i]);
        FireStoreServiceProvider()
            .getServiceUser(_likedJobModelInsect[i].userId)
            .then((value) =>
                _likedUserModelInsect.add(UserModel.fromJson(value.data()!)));
        break;
      }
    }
    for (int i = 0; i < _jobModelLands.length; i++) {
      if (_jobModelLands[i]
          .like
          .contains(serviceProviderModel.serviceProviderId)) {
        _likedJobModelLands.add(_jobModelLands[i]);
        FireStoreServiceProvider()
            .getServiceUser(_likedJobModelLands[i].userId)
            .then((value) =>
                _likedUserModelLands.add(UserModel.fromJson(value.data()!)));
        break;
      }
    }
    _loading.value = false;
    update();
  }

  getOngoing() async {
    _loading.value = true;

    for (int x = 0; x < _jobModel.length; x++) {
      await FireStoreServiceProvider()
          .getServices(
              _jobModel[x].jobId, _serviceProviderModel.serviceProviderId)
          .then((value) {
        for (int i = 0; i < value.length; i++) {
          _onGoing.add(ReplyModel.fromJson(value[i].data()));
        }
      });
    }
    _loading.value = false;

    update();
  }

  var filterTypeIndex = 0;
  getService() async {
    _loading.value = true;

    await FireStoreServiceProvider().getService().then((value) {
      for (int i = 0; i < value.length; i++) {
        _jobModel.add(JobModel.fromJson(value[i].data()));
      }
    });
    _loading.value = false;

    update();
  }

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
    reply(jobModel.jobId, userId, jobModel.service);

    sending = false;

    update();
    await reload();
  }

  reload() async {
    _loading.value = true;
    update();
    _jobModel.clear();
    _jobModelSwimming.clear();
    _jobModelCarp.clear();
    _jobModelConst.clear();
    _jobModelInsect.clear();
    _jobModelLands.clear();
    _jobModelTech.clear();
    _userModelSwimming.clear();
    _userModelTech.clear();
    _userModelCarp.clear();
    _userModelConst.clear();
    _userModelInsect.clear();
    _userModelLands.clear();
    _likedJobModelSwimming.clear();
    _likedJobModelCarp.clear();
    _likedJobModelConst.clear();
    _likedJobModelInsect.clear();
    _likedJobModelLands.clear();
    _likedJobModelTech.clear();
    _likedUserModelSwimming.clear();
    _likedUserModelTech.clear();
    _likedUserModelCarp.clear();
    _likedUserModelConst.clear();
    _likedUserModelInsect.clear();
    _likedUserModelLands.clear();
    _onGoing.clear();
    _onGoingSwimming.clear();
    _onGoingCarp.clear();
    _onGoingConst.clear();
    _onGoingInsect.clear();
    _onGoingLands.clear();
    _onGoingTech.clear();
    await getService();
    await getOngoing();
    await clear();
    await sortJobmodel();
    await sortOngoing();
    await sortLiked();
    _loading.value = false;
    update();
  }

  reply(id, userId, service) {
    var replyModel = ReplyModel(
      jobId: id,
      jobDetail: jobDetail!,
      images: imgUrl,
      availabilityFrom: availabilityFrom.toString(),
      availabilityTo: availabilityTo.toString(),
      budgetFrom: budgetFrom!,
      budgetTo: budgetTo!,
      location: _serviceProviderModel.location,
      duration: duration,
      userId: userId,
      service: service,
      serviceProviderId: _serviceProviderModel.serviceProviderId,
    );

    FireStoreServiceProvider().addReply(
        id, _serviceProviderModel.serviceProviderId, replyModel.toJson());
  }
}

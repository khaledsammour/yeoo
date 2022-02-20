import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/control/chat/chatModel.dart';
import 'package:yeeo/pressentation/control/userControl/chat/chatView.dart';
import 'package:yeeo/pressentation/control/userControl/chat/service/firestoreChat.dart';
import 'package:yeeo/pressentation/control/userControl/controlViewModel.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/serviceProvider/replyModel.dart';
import 'package:yeeo/pressentation/user/jobModel.dart';
import 'package:yeeo/pressentation/user/service/fireStoreService.dart';

class InventoryViewModel extends GetxController {
  final LocalStorageData localStorageData = Get.find();
  List<ReplyModel> get replyModel => _replyModel;
  List<ReplyModel> _replyModel = [];

  List<ReplyModel> get replyModelSwimming => _replyModelSwimming;
  List<ReplyModel> _replyModelSwimming = [];
  List<ReplyModel> get replyModelInsect => _replyModelInsect;
  List<ReplyModel> _replyModelInsect = [];
  List<ReplyModel> get replyModelConst => _replyModelConst;
  List<ReplyModel> _replyModelConst = [];
  List<ReplyModel> get replyModelTech => _replyModelTech;
  List<ReplyModel> _replyModelTech = [];
  List<ReplyModel> get replyModelLands => _replyModelLands;
  List<ReplyModel> _replyModelLands = [];
  List<ReplyModel> get replyModelCarp => _replyModelCarp;
  List<ReplyModel> _replyModelCarp = [];

  List<ServiceProviderModel> get serviceProviderModelSwimming =>
      _serviceProviderModelSwimming;
  List<ServiceProviderModel> _serviceProviderModelSwimming = [];
  List<ServiceProviderModel> get serviceProviderModelInsect =>
      _serviceProviderModelInsect;
  List<ServiceProviderModel> _serviceProviderModelInsect = [];
  List<ServiceProviderModel> get serviceProviderModelConst =>
      _serviceProviderModelConst;
  List<ServiceProviderModel> _serviceProviderModelConst = [];
  List<ServiceProviderModel> get serviceProviderModellTech =>
      _serviceProviderModelTech;
  List<ServiceProviderModel> _serviceProviderModelTech = [];
  List<ServiceProviderModel> get serviceProviderModelLands =>
      _serviceProviderModelLands;
  List<ServiceProviderModel> _serviceProviderModelLands = [];
  List<ServiceProviderModel> get serviceProviderModelCarp =>
      _serviceProviderModelCarp;
  List<ServiceProviderModel> _serviceProviderModelCarp = [];
  List<JobModel> get jobModel => _jobModel;
  List<JobModel> _jobModel = [];
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  var filter = false;
  var opened = false;
  var service = [
    HomeStrings.swimmingPool,
    HomeStrings.insect,
    HomeStrings.cons,
    HomeStrings.tech,
    HomeStrings.lands,
    HomeStrings.carp
  ];
  var serviceIndex = 0;
  var filterType = {
    'P': "pending",
    'O': "ongoing",
  };
  var filterTypeIndex = 0;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getCurrentUser();
    await getServices();
    await getReplys();
    await sortOngoing();
  }

  getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    update();
    _loading.value = false;
  }

  getServices() async {
    _loading.value = true;
    await FireStoreService().getServices(_userModel!.userId).then((value) {
      for (int i = 0; i < value.length; i++) {
        _jobModel.add(JobModel.fromJson(value[i].data()));
      }
    });
    _loading.value = false;
    update();
  }

  getReplys() async {
    _loading.value = true;
    for (int x = 0; x < _jobModel.length; x++) {
      await FireStoreService().getReplys(_jobModel[x].jobId).then((value) {
        for (int i = 0; i < value.length; i++) {
          _replyModel.add(ReplyModel.fromJson(value[i].data()));
        }
      });
    }
    _loading.value = false;

    update();
  }

  sortOngoing() {
    _loading.value = true;

    for (int i = 0; i < _replyModel.length; i++) {
      if (_replyModel[i].service == HomeStrings.swimmingPool) {
        _replyModelSwimming.add(_replyModel[i]);
        FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelSwimming
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
      if (_replyModel[i].service == HomeStrings.insect) {
        _replyModelInsect.add(_replyModel[i]);
        FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelInsect
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
      if (_replyModel[i].service == HomeStrings.cons) {
        _replyModelConst.add(_replyModel[i]);
        FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelConst
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
      if (_replyModel[i].service == HomeStrings.tech) {
        _replyModelTech.add(_replyModel[i]);
        FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelTech
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
      if (_replyModel[i].service == HomeStrings.lands) {
        _replyModelTech.add(_replyModel[i]);
        FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelLands
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
      if (_replyModel[i].service == HomeStrings.carp) {
        _replyModelCarp.add(_replyModel[i]);
        FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelCarp
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
    }
    _loading.value = false;

    update();
  }

  accepted(userId, serviceProviderId) async {
    FireStoreService().acceptOrder(userId, serviceProviderId);
    ChatModel chatModel = ChatModel(
      userId: _userModel!.userId,
      serviceProviderId: serviceProviderId,
    );
    await FireStoreChat().addChatToFirestore(chatModel);

    update();
  }
}

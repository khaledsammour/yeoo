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
  int callAnswerRate = 0, serviceRate = 0, priceRate = 0, timeRate = 0;
  final LocalStorageData localStorageData = Get.find();
  var reported = "false";
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

  List<ReplyModel> get likedReplyModelSwimming => _likedReplyModelSwimming;
  List<ReplyModel> _likedReplyModelSwimming = [];
  List<ReplyModel> get likedReplyModelInsect => _likedReplyModelInsect;
  List<ReplyModel> _likedReplyModelInsect = [];
  List<ReplyModel> get likedReplyModelConst => _likedReplyModelConst;
  List<ReplyModel> _likedReplyModelConst = [];
  List<ReplyModel> get likedReplyModelTech => _likedReplyModelTech;
  List<ReplyModel> _likedReplyModelTech = [];
  List<ReplyModel> get likedReplyModelLands => _likedReplyModelLands;
  List<ReplyModel> _likedReplyModelLands = [];
  List<ReplyModel> get likedReplyModelCarp => _likedReplyModelCarp;
  List<ReplyModel> _likedReplyModelCarp = [];

  List<ServiceProviderModel> get likedServiceProviderModelSwimming =>
      _likedServiceProviderModelSwimming;
  List<ServiceProviderModel> _likedServiceProviderModelSwimming = [];
  List<ServiceProviderModel> get likedServiceProviderModelInsect =>
      _likedServiceProviderModelInsect;
  List<ServiceProviderModel> _likedServiceProviderModelInsect = [];
  List<ServiceProviderModel> get likedServiceProviderModelConst =>
      _likedServiceProviderModelConst;
  List<ServiceProviderModel> _likedServiceProviderModelConst = [];
  List<ServiceProviderModel> get likedServiceProviderModellTech =>
      _likedServiceProviderModelTech;
  List<ServiceProviderModel> _likedServiceProviderModelTech = [];
  List<ServiceProviderModel> get likedServiceProviderModelLands =>
      _likedServiceProviderModelLands;
  List<ServiceProviderModel> _likedServiceProviderModelLands = [];
  List<ServiceProviderModel> get likedServiceProviderModelCarp =>
      _likedServiceProviderModelCarp;
  List<ServiceProviderModel> _likedServiceProviderModelCarp = [];

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
  var likeSelected = false;
  Map<String, bool> service = {
    HomeStrings.swimmingPool: true,
    HomeStrings.insect: false,
    HomeStrings.cons: false,
    HomeStrings.tech: false,
    HomeStrings.lands: false,
    HomeStrings.carp: false
  };
  Map<String, bool> filterServices = {
    HomeStrings.swimmingPool: false,
    HomeStrings.insect: false,
    HomeStrings.cons: false,
    HomeStrings.tech: false,
    HomeStrings.lands: false,
    HomeStrings.carp: false
  };
  var filterType = {
    'P': "pending",
    'O': "ongoing",
  };
  int? filterTypeIndex;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getCurrentUser();
    await getServices();
    await getReplys();
    await sortOngoing();
    await sortLiked();
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

  sortOngoing() async {
    _loading.value = true;

    for (int i = 0; i < _replyModel.length; i++) {
      if (_replyModel[i].service == HomeStrings.swimmingPool) {
        _replyModelSwimming.add(_replyModel[i]);
        await FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelSwimming
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
      if (_replyModel[i].service == HomeStrings.insect) {
        _replyModelInsect.add(_replyModel[i]);
        await FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelInsect
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
      if (_replyModel[i].service == HomeStrings.cons) {
        _replyModelConst.add(_replyModel[i]);
        await FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelConst
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
      if (_replyModel[i].service == HomeStrings.tech) {
        _replyModelTech.add(_replyModel[i]);
        await FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelTech
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
      if (_replyModel[i].service == HomeStrings.lands) {
        _replyModelTech.add(_replyModel[i]);
        await FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelLands
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
      if (_replyModel[i].service == HomeStrings.carp) {
        _replyModelCarp.add(_replyModel[i]);
        await FireStoreService()
            .getServiceProviderUser(_replyModel[i].serviceProviderId)
            .then((value) => _serviceProviderModelCarp
                .add(ServiceProviderModel.fromJson(value.data()!)));
      }
    }
    _loading.value = false;

    update();
  }

  sortLiked() {
    _loading.value = true;

    for (int i = 0; i < replyModelSwimming.length; i++) {
      if (_replyModelSwimming[i].like == "true") {
        _likedReplyModelSwimming.add(_replyModelSwimming[i]);
        _likedServiceProviderModelSwimming
            .add(_serviceProviderModelSwimming[i]);
        break;
      }
    }
    for (int i = 0; i < replyModelTech.length; i++) {
      if (_replyModelTech[i].like == "true") {
        _likedReplyModelTech.add(_replyModelTech[i]);
        _likedServiceProviderModelTech.add(_serviceProviderModelTech[i]);
        break;
      }
    }
    for (int i = 0; i < replyModelCarp.length; i++) {
      if (_replyModelCarp[i].like == "true") {
        _likedReplyModelCarp.add(_replyModelCarp[i]);
        _likedServiceProviderModelCarp.add(_serviceProviderModelCarp[i]);
        break;
      }
    }
    for (int i = 0; i < replyModelConst.length; i++) {
      if (_replyModelConst[i].like == "true") {
        _likedReplyModelSwimming.add(_replyModelConst[i]);
        _likedServiceProviderModelConst.add(_serviceProviderModelConst[i]);
        break;
      }
    }
    for (int i = 0; i < replyModelInsect.length; i++) {
      if (_replyModelInsect[i].like == "true") {
        _likedReplyModelInsect.add(_replyModelInsect[i]);
        _likedServiceProviderModelInsect.add(_serviceProviderModelInsect[i]);
        break;
      }
    }
    for (int i = 0; i < replyModelLands.length; i++) {
      if (_replyModelLands[i].like == "true") {
        _likedReplyModelLands.add(_replyModelLands[i]);
        _likedServiceProviderModelLands.add(_serviceProviderModelLands[i]);
        break;
      }
    }
    _loading.value = false;

    update();
  }

  like(ReplyModel replyModel) async {
    await FireStoreService().addLike(replyModel);

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

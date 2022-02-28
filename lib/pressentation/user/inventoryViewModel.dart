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
import 'package:yeeo/pressentation/user/userViewModel.dart';

class InventoryViewModel extends GetxController {
  int callAnswerRate = 0, serviceRate = 0, priceRate = 0, timeRate = 0;
  final LocalStorageData localStorageData = Get.find();
  var reported = "false";
  RxList<ReplyModel> swimming = RxList([]);
  RxList<ReplyModel> insect = RxList([]);
  RxList<ReplyModel> constr = RxList([]);
  RxList<ReplyModel> tech = RxList([]);
  RxList<ReplyModel> lands = RxList([]);
  RxList<ReplyModel> carp = RxList([]);

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

  @override
  void onReady() async {
    // TODO: implement onInit
    super.onReady();
    await getCurrentUser();

    swimming.bindStream(FireStoreService().getReplys(HomeStrings.swimmingPool));
    tech.bindStream(FireStoreService().getReplys(HomeStrings.tech));

    insect.bindStream(FireStoreService().getReplys(HomeStrings.insect));

    carp.bindStream(FireStoreService().getReplys(HomeStrings.carp));

    constr.bindStream(FireStoreService().getReplys(HomeStrings.cons));
    lands.bindStream(FireStoreService().getReplys(HomeStrings.lands));
  }

  getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    update();
    _loading.value = false;
  }

  like(ReplyModel replyModel) async {
    await FireStoreService().addLike(replyModel);

    update();
  }

  accepted(ReplyModel replyModel) async {
    FireStoreService().acceptOrder(replyModel.replyId);
    ServiceProviderModel? s;
    await FireStoreService()
        .getServiceProviderUser(replyModel.serviceProviderId)
        .then((value) {
      s = ServiceProviderModel.fromJson(value.data() as Map<dynamic, dynamic>);
    });
    ChatModel chatModel = ChatModel(
      userId: _userModel!.userId,
      serviceProviderId: replyModel.serviceProviderId,
      userName: _userModel!.userName,
      serviceProviderName: s!.userName,
      serviceProviderImg: s!.companyLogo,
    );
    await FireStoreChat().addChatToFirestore(chatModel);

    update();
  }
}

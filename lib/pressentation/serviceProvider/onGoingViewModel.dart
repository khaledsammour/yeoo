import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/serviceProvider/replyModel.dart';
import 'package:yeeo/pressentation/serviceProvider/service/fireStoreServiceProvider.dart';

import '../auth/serviceProviderModel.dart';

class OnGoingViewModel extends GetxController {
  final LocalStorageData localStorageData = Get.find();
  ServiceProviderModel get serviceProviderModel => _serviceProviderModel;
  late ServiceProviderModel _serviceProviderModel;
  ValueNotifier<bool> get loading => _loading;
  ValueNotifier<bool> _loading = ValueNotifier(false);
  var filter = false;
  var opened = false;
  var filterIndex = 0;
  var filterType = ['old', 'new'];
  RxList<ReplyModel> swimming = RxList([]);
  RxList<ReplyModel> insect = RxList([]);
  RxList<ReplyModel> constr = RxList([]);
  RxList<ReplyModel> tech = RxList([]);
  RxList<ReplyModel> lands = RxList([]);
  RxList<ReplyModel> carp = RxList([]);
  getCurrentServiceProvider() async {
    _loading.value = true;
    await localStorageData.getServiceProvider.then((value) {
      _serviceProviderModel = value!;
    });
    _loading.value = false;
    update();
  }

  @override
  void onReady() async {
    // TODO: implement dispose
    await getCurrentServiceProvider();

    swimming.bindStream(FireStoreServiceProvider().getOngoing(
        _serviceProviderModel.serviceProviderId, HomeStrings.swimmingPool));

    tech.bindStream(FireStoreServiceProvider()
        .getOngoing(_serviceProviderModel.serviceProviderId, HomeStrings.tech));

    insect.bindStream(FireStoreServiceProvider().getOngoing(
        _serviceProviderModel.serviceProviderId, HomeStrings.insect));

    carp.bindStream(FireStoreServiceProvider()
        .getOngoing(_serviceProviderModel.serviceProviderId, HomeStrings.carp));

    constr.bindStream(FireStoreServiceProvider()
        .getOngoing(_serviceProviderModel.serviceProviderId, HomeStrings.cons));

    carp.bindStream(FireStoreServiceProvider()
        .getOngoing(_serviceProviderModel.serviceProviderId, HomeStrings.carp));
  }
}

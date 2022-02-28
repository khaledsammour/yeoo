import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';


class Binding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LocalStorageData>(() => LocalStorageData());
  }
}

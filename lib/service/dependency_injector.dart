import 'package:get/get.dart';
import 'package:unlimit_task/service/api_service.dart';

mixin Dependency {
  static void init() {
    Get.lazyPut(() => RestAPIService(), fenix: true);
  }
}

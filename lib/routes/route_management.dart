import 'package:get/get.dart';
import 'package:unlimit_task/routes/routes.dart';

mixin RouteManagement {
  static void goToJokeScreen() {
    if (Get.currentRoute != Routes.joke) {
      Get.offAllNamed(Routes.joke);
    }
  }
// Other routes method Defined Here
}

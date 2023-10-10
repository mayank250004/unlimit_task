
import 'package:get/get.dart';
import 'package:unlimit_task/ui/joke_screen/joke_controller.dart';

class JokeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => JokeController());
  }
}

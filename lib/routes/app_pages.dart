import 'package:get/get.dart';
import 'package:unlimit_task/routes/routes.dart';
import 'package:unlimit_task/ui/joke_screen/joke_binding.dart';
import 'package:unlimit_task/ui/joke_screen/joke_screen.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: Routes.joke,
      page: () => const JokeScreen(),
      binding: JokeBinding(),
    ),
    // Other Routes Register Here
  ];
}

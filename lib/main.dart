import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unlimit_task/routes/app_pages.dart';
import 'package:unlimit_task/routes/routes.dart';
import 'package:unlimit_task/service/dependency_injector.dart';
import 'package:unlimit_task/utils/const.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Dependency.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: Routes.joke,
      getPages: AppPages.pages,
    );
  }
}

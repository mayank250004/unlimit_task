
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unlimit_task/ui/joke_screen/joke_controller.dart';
import 'package:unlimit_task/utils/const.dart';
class Jokecreen extends StatelessWidget {
  const Jokecreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      GetBuilder<JokeController>(builder: (controller) {
        return Scaffold(
            appBar: AppBar(
              title: const Text(appName),
            ),
            body: Text("Blank"));
      });
}

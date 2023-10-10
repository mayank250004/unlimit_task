import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unlimit_task/ui/common_widgets/loader.dart';
import 'package:unlimit_task/ui/joke_screen/joke_controller.dart';
import 'package:unlimit_task/ui/joke_screen/widgets/count_down_widget.dart';
import 'package:unlimit_task/ui/joke_screen/widgets/joke_card.dart';
import 'package:unlimit_task/utils/const.dart';

class JokeScreen extends StatelessWidget {
  const JokeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JokeController>(
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(appName),
          ),
          body: Obx(
            () {
              if (controller.isLoading.isTrue) {
                return const CustomLoader();
              } else {
                // Replace this with a ListView.builder to display joke cards
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CountdownTimerWidget(
                        jokeController: controller,
                      ),
                    ),
                    const Divider(),
                    Expanded(
                      child: ListView.builder(
                        itemCount: controller.jokeList.length,
                        itemBuilder: (context, index) {
                          final joke = controller.jokeList[index].joke;
                          return JokeCardWidget(joke: joke);
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        );
      },
    );
  }
}

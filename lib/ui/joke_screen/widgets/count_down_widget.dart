// Countdown Timer Widget
import 'package:flutter/material.dart';
import 'package:unlimit_task/ui/joke_screen/joke_controller.dart';

class CountdownTimerWidget extends StatelessWidget {
  final JokeController jokeController;

  const CountdownTimerWidget({super.key, required this.jokeController});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: jokeController.timerValue,
      builder: (context, value, _) {
        return Text(
          'Next joke in: $value seconds',
          style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500),
        );
      },
    );
  }
}

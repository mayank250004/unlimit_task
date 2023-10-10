import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:unlimit_task/model/joke.dart';
import 'package:unlimit_task/service/api_service.dart';
import 'package:unlimit_task/utils/utils.dart';

class JokeController extends GetxController {
  final _apiService = Get.find<RestAPIService>();
  final jokeList = <Joke>[].obs;
  final isLoading = false.obs;

  late ValueNotifier<int> timerValue; // ValueNotifier for countdown timer
  late Timer _timer;

  @override
  void onInit() {
    super.onInit();

    // Initialize timerValue with an initial value
    timerValue = ValueNotifier<int>(0);

    // Load saved jokes on app start
    _fetchJokeFromAPI(initial: true);

    // Fetch a new joke every minute
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _updateTimerValue(); // Update countdown timer value every second
    });
  }

  void _updateTimerValue() {
    final currentTime = DateTime.now();
    final nextMinute = DateTime(currentTime.year, currentTime.month,
        currentTime.day, currentTime.hour, currentTime.minute + 1);
    final secondsRemaining = nextMinute.difference(currentTime).inSeconds;
    timerValue.value = secondsRemaining;
  }

  _fetchJokeFromAPI({bool initial = false}) async {
    if (initial) {
      isLoading.value = true;
      final storageJokes = await retrieveJokeList();
      if (storageJokes.isNotEmpty) {
        jokeList.addAll(storageJokes);
      }
    }
    final jokeResponse = await _apiService.fetchJoke();

    if (jokeResponse != null && jokeResponse.joke.trim().isNotEmpty) {
      // Add the new joke to the beginning of the list
      if (jokeList.contains(jokeResponse)) {
        // Return if Duplicate Entry Found
        return;
      }
      jokeList.insert(0, jokeResponse);
      // Limit the list to 10 jokes
      if (jokeList.length > 10) {
        jokeList.removeLast();
      }
    }
    saveJokeList(jokeList.toList());
    if (initial) {
      isLoading.value = false;
    }
  }

  @override
  void onClose() {
    _timer.cancel(); // Cancel the timer when the controller is closed
    super.onClose();
  }
}

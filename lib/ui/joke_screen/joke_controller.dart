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
    timerValue = ValueNotifier<int>(60);

    // Load saved jokes on app start
    _fetchJokeFromAPI(initial: true);

    // Set up a timer to update the timerValue every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // Update countdown timer value every second

      // Calculate if 60 seconds have passed
      if (timerValue.value <= 0) {
        _fetchJokeFromAPI(); // Fetch a new joke after 60 seconds
      } else {
        timerValue.value--;
      }
    });
  }

  _fetchJokeFromAPI({bool initial = false}) async {
    if (initial) {
      isLoading.value = true;
      final storageJokes = await retrieveJokeList();
      if (storageJokes.isNotEmpty) {
        jokeList.addAll(storageJokes);
        //Don't hit api initially if jokes are already in list , timer will fetch them automatically
        isLoading.value = false;
        return;
      }
    } else {
      timerValue.value = 60;
    }
    final jokeResponse = await _apiService.fetchJoke();

    if (jokeResponse != null && jokeResponse.joke.trim().isNotEmpty) {
      // Check Duplicate Entry Found, Equatable is in model class so this will work automatically
      if (!jokeList.contains(jokeResponse)) {
        // Add the new joke to the beginning of the list
        jokeList.insert(0, jokeResponse);
      }

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

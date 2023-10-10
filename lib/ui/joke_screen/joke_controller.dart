import 'dart:async';

import 'package:get/get.dart';
import 'package:unlimit_task/model/joke.dart';
import 'package:unlimit_task/service/api_service.dart';
import 'package:unlimit_task/utils/utils.dart';

class JokeController extends GetxController {
  final _apiService = Get.find<RestAPIService>();
  final jokeList = <Joke>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();

    // Load saved jokes on app start
    _fetchJokeFromAPI();

    // Fetch a new joke every minute
    Timer.periodic(const Duration(minutes: 1), (_) {
      _fetchJokeFromAPI();
    });
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
}

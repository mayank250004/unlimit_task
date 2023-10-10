import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unlimit_task/model/joke.dart';
import 'package:unlimit_task/utils/const.dart';

void debugPrint(String message, {bool debug = true}) {
  if (kDebugMode) {
    print(message);
  }
}

Future<void> saveJokeList(List<Joke> jokeList) async {
  final prefs = await SharedPreferences.getInstance();
  final jokesJson = jokeList.map((joke) => json.encode(joke.toJson())).toList();
  await prefs.setStringList(keyStorageJokeList, jokesJson);
}

// Method to retrieve jokeList from shared_preferences
Future<List<Joke>> retrieveJokeList() async {
  final prefs = await SharedPreferences.getInstance();
  final jokeJsonList = prefs.getStringList(keyStorageJokeList);
  if (jokeJsonList != null) {
    final jokes =
        jokeJsonList.map((json) => Joke.fromJson(jsonDecode(json))).toList();
    return jokes; // Return the retrieved jokes as a List<Joke>
  } else {
    return []; // Return an empty list if no jokes are found in SharedPreferences
  }
}

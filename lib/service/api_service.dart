import 'package:dio/dio.dart';
import 'package:get/get.dart';

import 'package:unlimit_task/model/joke.dart';
import 'package:unlimit_task/utils/utils.dart';

class RestAPIService extends GetxService {
  Future<Joke?> fetchJoke() async {
    final dio = Dio();

    try {
      final response = await dio
          .get("https://geek-jokes.sameerkumar.website/api?format=json");

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data;
        return Joke.fromJson(data);
      } else {
        throw Exception("Failed to load joke");
      }
    } on DioException catch (e) {
      // Handle DioError exceptions
      if (e.response != null) {
        // The request was made, but the server responded with an error status code
        debugPrint("DioError: ${e.response?.statusCode}");
      } else {
        // Something went wrong with the request
        debugPrint("DioError: ${e.message}");
      }
      throw Exception("Failed to make the request");
    } catch (e) {
      debugPrint("API Error: $e");
    }
    finally{
      return null;
    }
  }
}

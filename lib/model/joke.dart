import 'package:equatable/equatable.dart';

class Joke extends Equatable {
  final String joke;

  const Joke({required this.joke});

  // Serialize the Joke object to a Map
  Map<String, dynamic> toJson() {
    return {
      'joke': joke,
    };
  }

  // Deserialize a Map to create a Joke object
  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      joke: json['joke'],
    );
  }

  @override
  List<Object?> get props => [joke];
}

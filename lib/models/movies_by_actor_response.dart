import 'dart:convert';

import 'movie.dart';

class MoviesByActorResponse {
  List<Movie> cast;
  int id;

  MoviesByActorResponse({
    required this.cast,
    required this.id,
  });

  factory MoviesByActorResponse.fromRawJson(String str) =>
      MoviesByActorResponse.fromJson(json.decode(str));

  factory MoviesByActorResponse.fromJson(Map<String, dynamic> json) =>
      MoviesByActorResponse(
        cast: List<Movie>.from(json["cast"].map((x) => Movie.fromJson(x))),
        id: json["id"],
      );
}

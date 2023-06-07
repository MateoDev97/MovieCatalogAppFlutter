import 'dart:convert';
import 'models.dart';

class MoviesResponse {
  Dates? dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  MoviesResponse({
    this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  factory MoviesResponse.fromRawJson(String str) =>
      MoviesResponse.fromJson(json.decode(str));

  factory MoviesResponse.fromJson(Map<String, dynamic> json) {
    final datesJson = json['dates'];
    final dates = datesJson != null ? Dates.fromJson(datesJson) : null;

    return MoviesResponse(
      dates: dates,
      page: json["page"],
      results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }
}

class Dates {
  DateTime maximum;
  DateTime minimum;

  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromRawJson(String str) => Dates.fromJson(json.decode(str));

  factory Dates.fromJson(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
      );
}

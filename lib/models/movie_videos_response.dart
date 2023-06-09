
import 'dart:convert';

class MovieVideosResponse {
    int id;
    List<VideoResult> results;

    MovieVideosResponse({
        required this.id,
        required this.results,
    });

    factory MovieVideosResponse.fromRawJson(String str) => MovieVideosResponse.fromJson(json.decode(str));

    factory MovieVideosResponse.fromJson(Map<String, dynamic> json) => MovieVideosResponse(
        id: json["id"],
        results: List<VideoResult>.from(json["results"].map((x) => VideoResult.fromJson(x))),
    );
}

class VideoResult {
    String iso6391;
    String iso31661;
    String name;
    String key;
    String site;
    int size;
    String type;
    bool official;
    DateTime publishedAt;
    String id;

    VideoResult({
        required this.iso6391,
        required this.iso31661,
        required this.name,
        required this.key,
        required this.site,
        required this.size,
        required this.type,
        required this.official,
        required this.publishedAt,
        required this.id,
    });

    factory VideoResult.fromRawJson(String str) => VideoResult.fromJson(json.decode(str));


    factory VideoResult.fromJson(Map<String, dynamic> json) => VideoResult(
        iso6391: json["iso_639_1"],
        iso31661: json["iso_3166_1"],
        name: json["name"],
        key: json["key"],
        site: json["site"],
        size: json["size"],
        type: json["type"],
        official: json["official"],
        publishedAt: DateTime.parse(json["published_at"]),
        id: json["id"],
    );
}

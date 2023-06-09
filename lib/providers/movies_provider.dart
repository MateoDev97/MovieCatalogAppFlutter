import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';
import 'package:movies_app/models/search_movie_response.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjM2U4MDcxMTNkZDZmNzRlNzUyNDFhMzljNWExNjM5YiIsInN1YiI6IjY0Nzk0NDg0Y2Y0YjhiMDE0MThlMWIxNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1G7MdHKYUHxz3APq6HI3YU21ttVSwW7vC5F7X-QIKbQ';

  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};
  Map<int, List<Movie>> actorMovies = {};

  int _popularPage = 0;

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));

  final _streamController = StreamController<List<Movie>>.broadcast();
  Stream<List<Movie>> get sugestionStream => _streamController.stream;

  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

  Future<Response> _getJsonData(String path, [int page = 1]) async {
    final url = Uri.https(_baseUrl, path, {
      'language': 'en-US',
      'page': '$page',
    });

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });

    return response;
  }

  getNowPlayingMovies() async {
    final response = await _getJsonData('3/movie/now_playing');

    if (response.statusCode == 200) {
      final modelNowPlaying = MoviesResponse.fromRawJson(response.body);
      nowPlayingMovies = modelNowPlaying.results;
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getPopularMovies() async {
    _popularPage++;

    final response = await _getJsonData('3/movie/popular', _popularPage);

    if (response.statusCode == 200) {
      final modelPopular = MoviesResponse.fromRawJson(response.body);
      popularMovies = [...popularMovies, ...modelPopular.results];
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<List<Cast>> getCastByMovieId(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final response = await _getJsonData('3/movie/$movieId/credits');

    final modelCredits = CreditsResponse.fromRawJson(response.body);

    final actingMembers = modelCredits.cast
        .where((member) => member.knownForDepartment == 'Acting')
        .toList();

    moviesCast[movieId] = actingMembers;

    return actingMembers;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(
      _baseUrl,
      '3/search/movie',
      {
        'language': 'en-US',
        'page': '1',
        'query': query,
      },
    );

    final response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });

    final modelSearchResponse = SearchMovieResponse.fromRawJson(response.body);
    return modelSearchResponse.results;
  }

  getSuggestionsByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final result = await searchMovies(value);
      _streamController.add(result);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }

  Future<List<Movie>?> getMoviestByPersonId(int personId) async {
    if (actorMovies.containsKey(personId)) return actorMovies[personId]!;

    final response = await _getJsonData('3/person/$personId/movie_credits');

    final MoviesByActorResponse modelMoviesByActor;

    try {
      modelMoviesByActor = MoviesByActorResponse.fromRawJson(response.body);
      actorMovies[personId] = modelMoviesByActor.cast;

      return modelMoviesByActor.cast;
    } catch (e) {
      // No specified type, handles all
      print('Error: $e');
      return null;
    }
  }

  Future<ActorInfoResponse> getActorInfo(int personId) async {
    final response = await _getJsonData('3/person/$personId');

    final modelActorInfo = ActorInfoResponse.fromRawJson(response.body);

    return modelActorInfo;
  }

  Future<VideoResult?> getTrailerByMovieId(int movieId) async {
    final response = await _getJsonData('3/movie/$movieId/videos');

    final MovieVideosResponse modelMoviesVideos;

    try {
      modelMoviesVideos = MovieVideosResponse.fromRawJson(response.body);

      VideoResult? videoTrailer = modelMoviesVideos.results.firstWhere((video) {
        return video.site == 'YouTube' && video.type == 'Trailer';
      });

      return videoTrailer;
    } catch (e) {
      // No specified type, handles all
      print('Error: $e');
      return null;
    }
  }
}

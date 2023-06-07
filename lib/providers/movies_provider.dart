import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier {
  final String _baseUrl = 'api.themoviedb.org';
  final String _token =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjM2U4MDcxMTNkZDZmNzRlNzUyNDFhMzljNWExNjM5YiIsInN1YiI6IjY0Nzk0NDg0Y2Y0YjhiMDE0MThlMWIxNCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.1G7MdHKYUHxz3APq6HI3YU21ttVSwW7vC5F7X-QIKbQ';

  List<Movie> nowPlayingMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

  getNowPlayingMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/now_playing');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
      final modelNowPlaying = MoviesResponse.fromRawJson(response.body);
      nowPlayingMovies = modelNowPlaying.results;
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  getPopularMovies() async {
    var url = Uri.https(_baseUrl, '3/movie/popular');

    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $_token',
    });
    if (response.statusCode == 200) {
      final modelPopular = MoviesResponse.fromRawJson(response.body);
      popularMovies = modelPopular.results;
      notifyListeners();
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }
}

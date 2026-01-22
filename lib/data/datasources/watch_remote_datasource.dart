import 'package:movie_app/data/models/tmdb_movie_details_model.dart';

import '../../core/constants/api_constants.dart';
import '../models/tmdb_movie_model.dart';
import 'api_service.dart';

class WatchRemoteDatasource {
  final ApiService _apiService;

  WatchRemoteDatasource(this._apiService);

  // ---------------------------
  // Upcoming Movies
  // ---------------------------
  Future<List<TmdbMovieModel>> fetchUpcomingMovies() async {
    final json = await _apiService.get(ApiConstants.upcomingMovies);
    final List results = json['results'];

    return results
        .map((movieJson) => TmdbMovieModel.fromJson(movieJson))
        .toList();
  }

  // ---------------------------
  // Movie Details
  // ---------------------------
  Future<TmdbMovieDetailsModel> fetchMovieDetails(String movieId) async {
    final json = await _apiService.get(
      ApiConstants.movieDetails(movieId),
    );

    return TmdbMovieDetailsModel.fromJson(json);
  }

  // ---------------------------
  // 🔥 SEARCH MOVIES (NEW)
  // ---------------------------
  Future<List<TmdbMovieModel>> searchMovies(String query) async {
    final json = await _apiService.get(
      ApiConstants.searchMovie(query),
    );

    final List results = json['results'];

    return results
        .map((movieJson) => TmdbMovieModel.fromJson(movieJson))
        .toList();
  }
}

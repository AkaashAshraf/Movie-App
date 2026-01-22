import 'package:movie_app/data/models/tmdb_movie_details_model.dart';

import '../datasources/watch_remote_datasource.dart';
import '../models/tmdb_movie_model.dart';

class WatchRepository {
  final WatchRemoteDatasource remote;

  WatchRepository(this.remote);

  Future<List<TmdbMovieModel>> getUpcomingMovies() {
    return remote.fetchUpcomingMovies();
  }

  Future<TmdbMovieDetailsModel> getMovieDetails(String movieId) {
    return remote.fetchMovieDetails(movieId);
  }

  Future<List<TmdbMovieModel>> searchMovies(String query) {
    return remote.searchMovies(query);
  }
}

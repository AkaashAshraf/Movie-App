import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:movie_app/core/utils/helper.dart';
import 'package:provider/provider.dart';

import '../data/models/movie_model.dart';
import '../data/models/movie_details_model.dart';
import '../data/models/category_model.dart';
import '../data/models/video_model.dart';
import '../data/models/tmdb_movie_details_model.dart';
import '../data/repositories/watch_repository.dart';
import '../data/datasources/watch_remote_datasource.dart';
import '../data/datasources/api_service.dart';
import '../views/watch/states/watch_ui_state.dart';
import '../views/watch/watch_details_view.dart';
import '../views/watch/subviews/watch_trailer_player_view.dart';
import 'base_viewmodel.dart';

class WatchViewModel extends BaseViewModel {
  WatchUIState _state = WatchUIState.home;
  WatchUIState get state => _state;

  final List<WatchUIState> _stateHistory = [];

  List<MovieModel> _movies = [];
  List<MovieModel> get movies => _movies;

  List<CategoryModel> _categories = [];
  List<CategoryModel> get categories => _categories;

  List<MovieModel> _searchResults = [];
  List<MovieModel> get searchResults => _searchResults;

  MovieModel? _selectedMovie;
  MovieModel? get selectedMovie => _selectedMovie;

  VideoModel? _selectedTrailer;
  VideoModel? get selectedTrailer => _selectedTrailer;

  MovieDetailsModel? _selectedMovieDetails;
  MovieDetailsModel? get selectedMovieDetails => _selectedMovieDetails;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _error;
  String? get error => _error;

  final TextEditingController searchController = TextEditingController();
  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  Timer? _debounce;

  late final WatchRepository _repository;

  WatchViewModel() {
    final apiService = ApiService();
    final remoteDatasource = WatchRemoteDatasource(apiService);
    _repository = WatchRepository(remoteDatasource);

    fetchHomeMovies();
    fetchCategories();
  }

  void _setState(WatchUIState newState) {
    _stateHistory.add(_state);
    _state = newState;
    notifyListeners();
  }

  void goToHome() => _setState(WatchUIState.home);
  void goToSearch() => _setState(WatchUIState.searchEmpty);
  void goToFinalResults() => _setState(WatchUIState.finalResults);

  Future<void> fetchHomeMovies() async {
    if (_movies.isNotEmpty) return;

    _setLoading(true);
    _error = null;

    try {
      final tmdbMovies = await _repository.getUpcomingMovies();

      _movies = tmdbMovies.map((tmdb) {
        return MovieModel(
          id: tmdb.id.toString(),
          title: tmdb.title,
          overview: tmdb.overview,
          rating: tmdb.voteAverage,
          releseDate: tmdb.releaseDate,
          imageUrl: tmdb.posterPath != null
              ? 'https://image.tmdb.org/t/p/w500${tmdb.posterPath}'
              : '',
        );
      }).toList();
    } catch (e, s) {
      log('fetchHomeMovies error', error: e, stackTrace: s);
      _error = 'Failed to load movies';
    }

    _setLoading(false);
  }

  Future<void> fetchCategories() async {
    if (_categories.isNotEmpty) return;

    _setLoading(true);
    _error = null;

    await Future.delayed(const Duration(seconds: 1));

    _categories = const [
      CategoryModel(
          id: '1',
          title: 'Action',
          genres: 'action',
          imageUrl: 'https://picsum.photos/400/300?1'),
      CategoryModel(
          genres: 'drama',
          id: '2',
          title: 'Drama',
          imageUrl: 'https://picsum.photos/400/300?2'),
      CategoryModel(
          id: '3',
          title: 'Comedy',
          genres: 'comedy',
          imageUrl: 'https://picsum.photos/400/300?3'),
      CategoryModel(
          id: '4',
          title: 'Thriller',
          genres: 'thriller',
          imageUrl: 'https://picsum.photos/400/300?4'),
      CategoryModel(
          id: '5',
          title: 'Horror',
          genres: 'horror',
          imageUrl: 'https://picsum.photos/400/300?5'),
      CategoryModel(
          id: '6',
          title: 'Sci-Fi',
          genres: 'scifi',
          imageUrl: 'https://picsum.photos/400/300?6'),
      CategoryModel(
          id: '7',
          title: 'Romance',
          genres: 'romance',
          imageUrl: 'https://picsum.photos/400/300?7'),
      CategoryModel(
          id: '8',
          title: 'Fantasy',
          genres: 'fantacy',
          imageUrl: 'https://picsum.photos/400/300?8'),
    ];

    _setLoading(false);
  }

  Future<void> onSearchChanged(String query) async {
    _searchQuery = query;
    notifyListeners();

    _debounce?.cancel();

    if (query.isEmpty) {
      _searchResults = [];
      _setState(WatchUIState.searchEmpty);
      return;
    }

    _debounce = Timer(const Duration(milliseconds: 400), () async {
      _setLoading(true);
      _error = null;

      try {
        final tmdbResults = await _repository.searchMovies(query);

        _searchResults = tmdbResults.map((tmdb) {
          return MovieModel(
            id: tmdb.id.toString(),
            title: tmdb.title,
            overview: tmdb.overview,
            rating: tmdb.voteAverage,
            releseDate: tmdb.releaseDate,
            imageUrl: tmdb.posterPath != null
                ? 'https://image.tmdb.org/t/p/w500${tmdb.posterPath}'
                : '',
          );
        }).toList();

        _setState(WatchUIState.results);
      } catch (e, s) {
        log('search error', error: e, stackTrace: s);
        _error = 'Search failed';
      }

      _setLoading(false);
    });
  }

  void clearSearch() {
    searchController.clear();
    _searchQuery = '';
    _searchResults = [];
    _setState(WatchUIState.searchEmpty);
  }

  Future<void> openDetails(BuildContext context, String movieId) async {
    try {
      _setLoading(true);
      _error = null;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: this,
            child: const WatchDetailsView(),
          ),
        ),
      );

      final tmdbDetails = await _repository.getMovieDetails(movieId);
      _selectedMovieDetails = _mapToDomain(tmdbDetails);

      _setLoading(false);
    } catch (e, s) {
      log('details error', error: e, stackTrace: s);
      _setLoading(false);
      _error = e.toString();
      notifyListeners();
    }
  }

  MovieDetailsModel _mapToDomain(TmdbMovieDetailsModel tmdb) {
    return MovieDetailsModel(
      id: tmdb.id.toString(),
      title: tmdb.title,
      overview: tmdb.overview,
      backdropUrl: tmdb.backdropPath != null
          ? 'https://image.tmdb.org/t/p/w780${tmdb.backdropPath}'
          : '',
      posterUrl: tmdb.posterPath != null
          ? 'https://image.tmdb.org/t/p/w500${tmdb.posterPath}'
          : '',
      rating: tmdb.voteAverage,
      tagline: tmdb.tagline,
      runtime: tmdb.runtime,
      releaseDate: tmdb.releaseDate,
      genres: tmdb.genres.map((g) => g.name).toList(),
    );
  }

  // Future<void> openTrailer(BuildContext context) async {
  //   _selectedTrailer = VideoModel(
  //     id: 't1',
  //     name: 'Trailer',
  //     url:
  //         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  //   );

  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (_) => ChangeNotifierProvider.value(
  //         value: this,
  //         child: const WatchTrailerPlayerView(),
  //       ),
  //     ),
  //   );
  // }
  Future<void> openTrailer(BuildContext context) async {
    try {
      _setLoading(true);

      final movieId = _selectedMovieDetails?.id;
      if (movieId == null) return;

      final videos = await _repository.getMovieVideos(movieId);

      final trailer = pickBestTrailer(videos);
      // inspect(trailer);
      // if (trailer == null) {
      //   _error = "No trailer found";
      //   notifyListeners();
      //   return;
      // }

      _selectedTrailer = VideoModel(
        id: trailer?.id ?? '',
        key: trailer?.key ?? '',
        name: trailer?.name ?? '',
        url: trailer?.key ?? '',
      );

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: this,
            child: const WatchTrailerPlayerView(),
          ),
        ),
      );
    } catch (e, s) {
      log('openTrailer error', error: e, stackTrace: s);
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void retry() {
    if (_state == WatchUIState.home) {
      fetchHomeMovies();
    } else if (_state == WatchUIState.results) {
      onSearchChanged(_searchQuery);
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    searchController.dispose();
    super.dispose();
  }
}

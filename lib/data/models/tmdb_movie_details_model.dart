import 'tmdb_genre_model.dart';

class TmdbMovieDetailsModel {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final double voteAverage;
  final String releaseDate;
  final int runtime;
  final String tagline;
  final List<TmdbGenreModel> genres;

  TmdbMovieDetailsModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.voteAverage,
    required this.releaseDate,
    required this.runtime,
    required this.tagline,
    required this.genres,
  });

  factory TmdbMovieDetailsModel.fromJson(Map<String, dynamic> json) {
    return TmdbMovieDetailsModel(
      id: json['id'],
      title: json['title'],
      overview: json['overview'],
      posterPath: json['poster_path'] ?? '',
      backdropPath: json['backdrop_path'] ?? '',
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'] ?? '',
      runtime: json['runtime'] ?? 0,
      tagline: json['tagline'] ?? '',
      genres: (json['genres'] as List)
          .map((e) => TmdbGenreModel.fromJson(e))
          .toList(),
    );
  }
}

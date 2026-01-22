class MovieDetailsModel {
  final String id;
  final String title;
  final String overview;
  final String backdropUrl;
  final String posterUrl;
  final double rating;
  final String tagline;
  final int runtime;
  final String releaseDate;
  final List<String> genres;

  MovieDetailsModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.backdropUrl,
    required this.posterUrl,
    required this.rating,
    required this.tagline,
    required this.runtime,
    required this.releaseDate,
    required this.genres,
  });
}

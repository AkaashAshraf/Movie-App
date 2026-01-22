class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String apiKey = '2f8fdaf94ea75e898afde9db75b77183';

  static String upcomingMovies = '$baseUrl/movie/upcoming?api_key=$apiKey';

  static String movieDetails(String movieId) =>
      '$baseUrl/movie/$movieId?api_key=$apiKey';

  static String searchMovie(String query) =>
      '$baseUrl/search/movie?query=$query&api_key=$apiKey';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String noImageUrl =
      "https://dummyimage.com/300x300/cccccc/000000&text=No+Image";
}

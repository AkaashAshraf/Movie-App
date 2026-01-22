class TmdbGenreModel {
  final int id;
  final String name;

  TmdbGenreModel({
    required this.id,
    required this.name,
  });

  factory TmdbGenreModel.fromJson(Map<String, dynamic> json) {
    return TmdbGenreModel(
      id: json['id'],
      name: json['name'],
    );
  }
}

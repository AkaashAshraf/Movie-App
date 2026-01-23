class TmdbVideoModel {
  final String id;
  final String name;
  final String key;
  final String type;
  final bool official;

  TmdbVideoModel({
    required this.id,
    required this.name,
    required this.key,
    required this.type,
    required this.official,
  });

  factory TmdbVideoModel.fromJson(Map<String, dynamic> json) {
    return TmdbVideoModel(
      id: json['id'],
      name: json['name'],
      key: json['key'],
      type: json['type'],
      official: json['official'],
    );
  }
}

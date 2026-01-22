class TmdbImageItem {
  final String filePath;
  final int width;
  final int height;
  final double aspectRatio;

  TmdbImageItem({
    required this.filePath,
    required this.width,
    required this.height,
    required this.aspectRatio,
  });

  factory TmdbImageItem.fromJson(Map<String, dynamic> json) {
    return TmdbImageItem(
      filePath: json['file_path'],
      width: json['width'],
      height: json['height'],
      aspectRatio: (json['aspect_ratio'] as num).toDouble(),
    );
  }
}

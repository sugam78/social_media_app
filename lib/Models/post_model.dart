class Post {
  String caption;
  List<String>? images;
  DateTime date;
  int likes;
  List<String>? comments;

  Post({
    required this.caption,
    this.images,
    required this.date,
    this.likes = 0,
    this.comments,
  });

  Map<String, dynamic> toJson() {
    return {
      'caption': caption,
      'images': images,
      'date': date.toIso8601String(),
      'likes': likes,
      'comments': comments,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      caption: json['caption'],
      images: json['images'] != null ? List<String>.from(json['images']) : null,
      date: DateTime.parse(json['date']),
      likes: json['likes'] ?? 0,
      comments: json['comments'] != null ? List<String>.from(json['comments']) : null,
    );
  }
}

class Banner {
  final String? id;
  final String? title;
  final String? url;
  final String? createdAt;

  Banner({
    this.id,
    this.title,
    this.url,
    this.createdAt,
  });

  factory Banner.fromJson(Map<String, dynamic> json) {
    return Banner(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      createdAt: json['created_at'],
    );
  }
}

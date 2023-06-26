class News {
  final String header;
  final String title;
  final String description;
  final String imageName;
  final String body;

  News(
      {required this.header,
      required this.title,
      required this.description,
      required this.body,
      required this.imageName});

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
        header: json['header'],
        title: json['title'],
        description: json['description'],
        imageName: json['imageName'],
        body: json['body']);
  }

  Map<String, dynamic> toJsonReduced() {
    return {
      'title': title,
      'description': description,
      'imageName': imageName,
      'header': header,
      'body': body,
    };
  }
}

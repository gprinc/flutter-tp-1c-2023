class News {
  final String header;
  final String title;
  final String description;
  final String imageName;

  News(
      {required this.header,
      required this.title,
      required this.description,
      required this.imageName});

  factory News.fromJson(Map<String, dynamic> json ){
    return News(
      header: json['header'], 
      title: json['title'], 
      description: json['description'], 
      imageName: json['imageName'], 
    );
  }
}

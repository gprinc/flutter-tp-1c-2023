class Volunteering {
  final String title;
  final String description;
  final String imageName;
  final String address;
  final String about;
  List<String> requisites = [];
  List<String> availability = [];
  final int id;
  List<String> appliersEmail;
  List<String> participantsEmail;
  List<String> favoritos;

  Volunteering(
      {required this.about,
      required this.title,
      required this.description,
      required this.imageName,
      required this.address,
      required this.requisites,
      required this.availability,
      required this.id,
      this.appliersEmail = const [],
      this.participantsEmail = const [],
      this.favoritos = const []});

  factory Volunteering.fromJson(Map<String, dynamic> json) {
    return Volunteering(
        title: json['title'],
        description: json['description'],
        imageName: json['imageName'],
        about: json['about'],
        address: json['address'],
        requisites: List.from(['requisites']),
        availability: List.from(json['availability']),
        id: json['id'],
        appliersEmail: List.from(json['appliersEmail']),
        participantsEmail: List.from(json['participantsEmail']),
        favoritos: List.from(json['favoritos']));
  }

  Map<String, dynamic> toJsonReduced() {
    return {
      'title': title,
      'description': description,
      'imageName': imageName,
      'address': address,
      'requisites': requisites,
      'availability': availability,
      'about': about,
      'id': id,
      'appliersEmail': appliersEmail,
      'participantsEmail': participantsEmail,
      'favoritos': favoritos
    };
  }

  static Map<String, dynamic> toJson(Volunteering vol) {
    return {
      'title': vol.title,
      'description': vol.description,
      'imageName': vol.imageName,
      'address': vol.address,
      'requisites': vol.requisites,
      'about': vol.about,
      'availability': vol.availability,
      'id': vol.id,
      'appliersEmail': vol.appliersEmail,
      'participantsEmail': vol.participantsEmail,
      'favoritos': vol.favoritos
    };
  }
}

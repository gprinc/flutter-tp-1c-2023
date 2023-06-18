class Volunteering {
  final String title;
  final String description;
  final String imageName;
  var requisites = [];
  var availability = [];

  Volunteering(
      {required this.title,
      required this.description,
      required this.imageName,
      required this.requisites,
      required this.availability});
}

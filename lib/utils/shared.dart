class SharedUtils {
  static List<String> getFirebaseStringArray(List<dynamic> jsonArray) {
    List<String> aux = [];
    jsonArray.forEach((element) {
      aux.add(element);
    });
    return aux;
  }
}
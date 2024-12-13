// Create the class
class MovieSearch {
  // property
  final String imdbId;
  final String title;
  final String year;
  final String poster;
  final String type;

  // Constructor // Pembuat Object
  // Class is the blueprint/format, cth: Makanan, Hotel
  /// Object an istance, cth: Snack Plate, Burger,
  /// Hotel AB Inn, Hard Rock
MovieSearch({required this.imdbId,
  required this.title, required this.year,
required this.poster, required this.type});


// Create a JSON (data dari API) to Object transformer
// Tukarkan JSON ke Object
// kanan [hijau] kena ikut JSON (data dari API)
  // kiri [hitam] ikut property
factory MovieSearch.fromJson(Map<String,dynamic> json){
  return MovieSearch(
      imdbId: json["imdbID"],
      title: json["Title"],
      year: json["Year"],
      poster: json["Poster"],
      type: json["Type"]);
}

}
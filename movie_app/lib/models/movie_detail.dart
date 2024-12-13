// Create the class
class MovieDetail {
  // properties
  final String imdbId;
  final String title;
  final String poster;
  final String year;
  final String genre;
  final String plot;
  final String director;
  final String actors;
  final String country;
  final String language;

  //Constructor
MovieDetail({required this.imdbId, required this.title,
required this.poster, required this.year,
required this.genre, required this.plot,
  required this.director,required this.actors,
required this.country, required this.language});

factory MovieDetail.fromJson(Map<String,dynamic> json){
  return MovieDetail(imdbId: json["imdbID"],
      title: json["Title"],
      poster: json["Poster"],
      year: json["Year"],
      genre: json["Genre"],
      plot: json["Plot"],
      director: json["Director"],
      actors: json["Actors"],
      country: json["Country"],
      language: json["Language"]);
}
}
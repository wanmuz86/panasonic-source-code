import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailPage extends StatefulWidget {
  // Create a variable where the passed data will be stored
  String imdbId;

  // Create the constuctor
  DetailPage({required this.imdbId});


  @override
  State<DetailPage> createState() => _DetailPageState();
}

// Kalau stateless cara dapatkan data adalah $imdbId
// Kalau stateful cara dapatkan data adalah ${widget.imdbId}
class _DetailPageState extends State<DetailPage> {

  MovieDetail? _movieDetail;

  @override
  void initState() {
    super.initState();
    loadMovie();
  }
  void loadMovie() async {
    var movie = await fetchMovie();
    setState(() {
      _movieDetail = movie;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Page"),),
      body:
      _movieDetail == null ?
          Center(child: CircularProgressIndicator())
          :
      Center(
        child: Text(_movieDetail!.title),
      ),
    );
  }

  Future<MovieDetail> fetchMovie() async {
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?i=tt1669165&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return MovieDetail.fromJson(jsonDecode(response.body)
      as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

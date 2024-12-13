import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_search.dart';
import 'package:movie_app/widgets/detail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _movies = [];
  var searchEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Movie app"),),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextField(
                  controller: searchEditingController,
                  decoration:
                InputDecoration(hintText:"Movie name"), ),
              ),
              Expanded(
                child: ElevatedButton(onPressed: () async {

                  if (searchEditingController.text.length < 3){
                    SnackBar snackBar = SnackBar(content:
                    Text("Please fill in at least 3 characters"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  else {
                    // Function fetchMovies <Future>
                    // Use async await to call the function
                    try {
                      var data = await fetchMovies(
                          searchEditingController.text);
                      setState(() {
                        // data = List<MovieSearch>>
                        // _movies = List<Map<String,String>>
                        _movies = data;
                      });
                    }
                    catch (e) {
                      SnackBar snackBar = SnackBar(content:
                      Text("No movie result. Please try again"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  }

                }, child:
                Text("Search movie")),
              )
            ],
          ),
          Expanded(child:
          ListView.builder(
            // How may rows are there?
              itemCount: _movies.length,
            // What to show on every row
              itemBuilder: (context,index){
                return Card(
                  child: ListTile(
                    // Map<String,String> [""]
                    // Object .
                  title: Text(_movies[index].title),
                    subtitle: Text(_movies[index].year),
                    leading: _movies[index].poster != "N/A" ?
                    Image.network(_movies[index].poster) : SizedBox(),
                    trailing: Icon(Icons.chevron_right),
                    onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context)=> DetailPage(
                        imdbId: _movies[index].imdbId,))
                    );
                    }
                    ,
                  ),
                );
              })
          )
        ],
      ),
    );
  }

  // Future - This is an asynchronous method
  // This method will call a background process

  // <> - The return type of the http request /JSON
  // [] -> List<ClassName>
  // {} -> <ClassName>
  Future<List<MovieSearch>> fetchMovies(String searchText) async {
    // import http as http
    final response = await http
        .get(Uri.parse('https://www.omdbapi.com/?s=$searchText&apikey=87d10179'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      //jsonDecode cari baiki - import 'dart:convert'
      // Page 122 buku (reference)
// [] -> (jsonDecode(response.body)['Search'] as List].map((movie)=> MovieSearch.fromJson(movie)).toList();
// {} -> MovieSearch.fromJson(jsonDecode(response.body))

    // jsonDecode
 // Transform String into List , List of dynamic
      // .map -> Untuk setiap movie di dalam List movies (foreach)
      // tukarkan movie JSON ke Object Movie
      return (jsonDecode(response.body)["Search"] as List)
          .map((movie)=>MovieSearch.fromJson(movie)).toList();

    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}

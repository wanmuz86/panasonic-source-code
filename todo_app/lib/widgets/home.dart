import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:todo_app/widgets/add.dart';
import 'package:todo_app/widgets/detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<dynamic> _todos = [
    {
      "name":"Navigation",
      "desc":"Simple Navigation, Pass forward datam Pass backward data",
      "completed":true
    },
    {
      "name":"Breakfast",
      "desc":"Fried Mee & Nescafe",
      "location":"Canteen",
      "completed":true
    },
    {
      "name":"ListView",
      "desc":"ListView, ListTile and Card",
      "location":"Training Room",
      "completed":true
    },
    {
      "name":"Shared Preference",
      "desc":"See how to store and retrieve data in app",
      "location":"Training",
      "completed":false
    }
  ];

  void saveData() async{

    // Get the file manager
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save Data

    // import 'dart:convert'
    //jsonEncode ->Transform from List<Map> to String
    // SharedPref can only store, String, int, double , boolean dan List<String>
    prefs.setString("todos", jsonEncode(_todos));

  }

  void retrieveData() async {

    // Get the file manager
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Open data
// DAta ini boleh jadi null -> user delete data, clear cache/data
    // kali pertama buka app
    // Since the return type is String?
     var stringData = prefs.getString("todos");

     // Pastikan String? tidak null (1)
     if (stringData != null){
       // jsonDecode = Transform from String to List<dynamic>
       setState(() {
         _todos = jsonDecode(stringData);
       });
     }
  }
  // When the page is loaded
  @override
  void initState() {
    super.initState();
    retrieveData();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("To do app"),
        backgroundColor: Colors.blueAccent,),
      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          // How many rows are there?
          // 90% Length of list (_todos)
          itemCount: _todos.length,
          // What to show on every row
          // Untuk setiap row, tunjukkan Container, berketinggian 50
          // Bewarna amber dan mempunyai isi, Centered Text dengan item name
          // ps: index merujuk kepada row, row 0 , index 0, row 1, index 1
          itemBuilder: (BuildContext context, int index) {
            // return Container(
            //   height: 50,
            //   color: Colors.amber,
            //   child: Center(child: Text(_todos[index]["name"]!)),
            // );

            return Card(
              color: Colors.yellow,
              child: ListTile(
                leading: _todos[index]["completed"]
                    ? Icon(Icons.check_box):
                Icon(Icons.check_box_outline_blank) ,
                title: Text(_todos[index]["name"]!),
                subtitle: Text(_todos[index]["location"] ?? ""),
                trailing: Icon(Icons.chevron_right),
                onTap: () async {

                  // 3) Hantar _todos[index] ke page ke2 melalui constructor
                 var actionItem = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context)=>
                        DetailPage(todoItem: _todos[index],index: index,))
                  );
                 if (actionItem != null){
                   if (actionItem["action"] == 1){
                     // DELETE
                     _todos.removeAt(actionItem["index"]);
                     // Refresh the page with new todos

                     saveData();
                     setState(() {
                       _todos;
                     });
                   }
                   else {
                     // MARK AS COMPLETED
                     var index = actionItem["index"];
                     // _todos[index]["completed"] adalah lawannya
                     // kalau true = false, kalau false = true
                     _todos[index]["completed"]  = !_todos[index]["completed"];
                     saveData();
                     setState(() {
                       _todos;
                     });

                   }
                 }
                },
              ),
            );
          }
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
          onPressed: () async {
          // BUkaaa
            // TUNGGGUUUUUUU sehingga page Add ditutup (await)
            // Ambil item yang dihantar , masukkan di dalam new item
            // Kalau ada "await" tambahkan "async" di {} function terdekat
          var newItem = await Navigator.push(
            context,
            // Route/URL untuk page AddPage
            MaterialPageRoute(builder: (context)=>AddPage())
          );
          // {"name":"","desc":"","location":""};
          if (newItem != null){

            _todos.add(newItem);
            saveData();

            setState(() {
              _todos = _todos;
            });

          }
          },
        child: Icon(Icons.add,
          color: Colors.white,),
      ),
    );
  }
}

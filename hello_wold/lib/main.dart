import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage());
  }
}

class HomePage extends StatelessWidget {
  // 1 textfield kena ada 1 texteditingcontroller
  // Untuk link kan textfield dan logic code -> Dapatkan data
  var nameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello World"),
          backgroundColor: Colors.red,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Text(
                  "Welcome to my app",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(color: Colors.blue, fontSize: 32)
                  ),
                ),
                Text(
                  "This is my first app",
                  style: GoogleFonts.yujiMai(
                    textStyle: TextStyle(fontSize: 24, color: Colors.green)
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  "I hope you enjoy this",
                  style: TextStyle(fontSize: 20, color: Colors.blueGrey),
                ),
                SizedBox(height: 8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("This is left"),
                    SizedBox(width: 8,),
                    Text("This is right")
                  ],
                ),
                SizedBox(height: 8,),
                Container(
                  color: Colors.blue,
                  width: 150,
                  height: 150,
                  child: Center(child: Text("Hello World ",
                    style: TextStyle(color: Colors.white),)),
                ),
                SizedBox(height: 8,),
                Image.network("https://pbs.twimg.com/profile_images/1682334807525826561/9tzK-iaH_400x400.jpg"),
                Image.asset("assets/poster.png"),
                TextField(
                  // Link kan textfield ke controller (logic)
                  controller: nameEditingController,
                  decoration: InputDecoration(hintText: "Enter your name"),),
                ElevatedButton(
                    onPressed: (){
                      print("Hello World"); // Print in console
                      // Retrieve the value of textfield using property .text of nameEditingController
                      var snackBar = SnackBar(content: Text("Hello ${nameEditingController.text}"));
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    },
                    child: Text("Press me"))
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class AddPage extends StatelessWidget {

  var nameEditingController = TextEditingController();
  var descEditingController = TextEditingController();
  var placeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Add Page"),
        backgroundColor: Colors.blueAccent,),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: Column(
          children: [
            Text("Add new To do list", style: TextStyle(fontSize: 32),),
            TextField(decoration: InputDecoration(hintText: "Enter item name"),
            controller: nameEditingController,),
            TextField(decoration: InputDecoration(hintText: "Enter item description"),
            controller: descEditingController,),
            TextField(decoration: InputDecoration(hintText: "Enter item place"),
            controller: placeEditingController,),
            ElevatedButton(onPressed: (){

              print(nameEditingController.text);
              print(descEditingController.text);
              print(placeEditingController.text);

              // Pergi ke page sebelum ini
              // Tutup page ini

              // Send the data as the second argument of Navigator.pop
              var newItem = {
                "name":nameEditingController.text,
                "location":placeEditingController.text,
                "desc":descEditingController.text,
                "completed":false
              };
              Navigator.pop(context, newItem);

            }, child: Text("Add new item"))
          ],
        )),
      ),
    );
  }
}

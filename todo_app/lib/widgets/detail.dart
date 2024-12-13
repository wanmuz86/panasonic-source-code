import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  // 1) Variable yang akan menyimpan data yang dihantar
  Map<String,dynamic> todoItem;
  int index;

  // 2) Create constructor with variable
  // Pembuat page / const key (constuctor)
  // Bila page ini dibuat, kita perlu hantar todoItem sebagai argument
  DetailPage({required this.todoItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Page"), backgroundColor: Colors.blueAccent,),
      // Keluarkan data di dalam UI
      body: Center(
        child: Column(
          children: [
            Text(todoItem["name"]!, style: TextStyle(fontSize: 32,),),
            SizedBox(height: 8,),
            Text(todoItem["location"]!, style: TextStyle(fontSize: 24),),
            SizedBox(height: 8,),
            Text(todoItem["desc"]!, style: TextStyle(fontSize: 18), textAlign: TextAlign.center,),
            SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(onPressed: (){

                  print("TODO: delete item at $index");
                  // CODE 1 (DELETE) , 2 (MARK AS COMPLETED)
                  var actionItem = {
                    "index":index,
                    "action":1
                  };
                  Navigator.pop(context,actionItem);
                }, child: Text("Delete")),
                ElevatedButton(onPressed: (){
                  var actionItem = {
                    "index":index,
                    "action":2
                  };
                  Navigator.pop(context, actionItem);

                }, child: Text(todoItem["completed"] ? "Unmark Completion": "Mark as complete"))
              ],
            )
          ],
        ),
      ),
    );
  }
}

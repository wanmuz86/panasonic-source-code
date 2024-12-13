import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  DateTime _selectedSentDate = DateTime.now();
  DateTime _selectedPickupDate = DateTime.now();


  // DRopdown menu

  // Option di drop down menu
  var _models = ["Mio","Beat","Vario","Scoopy"];

  var nameEditingController = TextEditingController();
  var emailEditingController = TextEditingController();
  var passwordEditingController = TextEditingController();
  var addressEditingController = TextEditingController();
  var modelController = TextEditingController();

  // Default model selected
  var _selectedModel = "Mio";

  // Create photolibrary or camera picker
  final ImagePicker _picker = ImagePicker();
  // Simpan gambar (private variable)
  // import dart:io
  File? _imageFile;


// code = 1 (pickup), 2 = sent
  Future<void> _selectDate(BuildContext context, int code) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      // Get the current Date Time
      initialDate: DateTime.now(),
      // Book dari bila
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (code == 1) {
      // Jikalau user pilih, dan tarikhnya berbeza dengan tarikh yang dipilih sebelum ini
      if (pickedDate != null && pickedDate != _selectedPickupDate) {
        // Update UI
        setState(() {
          _selectedPickupDate = pickedDate;
        });
      }
    } else {
      if (pickedDate != null && pickedDate != _selectedSentDate) {
        // Update UI
        setState(() {
          _selectedSentDate = pickedDate;
        });
      }
    }
  }
  String formatDate(DateTime date){
    //13-12-2024
    return "${date.day}-${date.month}-${date.year}";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Booking app"), backgroundColor: Colors.red,),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Center(child: Column(
            children: [
              Text("Booking app"),
              TextField(
                  controller: nameEditingController,
                  decoration :InputDecoration(hintText:"Enter name")),
              TextField(
                controller: emailEditingController,
                decoration: InputDecoration(hintText: "Enter email",),
                keyboardType: TextInputType.emailAddress,),
              // COntoh sahaja data ini tidak akan dihantar ke server
              TextField(
                  controller: passwordEditingController,
                  decoration: InputDecoration(hintText: "Enter password"),obscureText: true),
              TextField(
                controller: addressEditingController,
                decoration: InputDecoration(hintText: "Enter address"), ),
              ElevatedButton(onPressed: () async {
                // Kalau photo gallery ubah jadi ImageSource.gallery
                final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
                if (pickedFile != null){
                  setState(() {
                    // UPDATE UI , TUNJUKKAN GAMBAR DI UI
                    _imageFile = File(pickedFile.path);
                  });
                }
              }, child: Text("Upload license picture")),
              _imageFile != null ?   Image.file(_imageFile!) : Placeholder(),
              Row(
                children: [
                  Text("Select pickup date : (${formatDate(_selectedPickupDate) })"),
                  ElevatedButton(onPressed: (){
                    _selectDate(context, 1);
                  }, child: Text("Select date"))
                ],
              ),
              Row(
                children: [
                  Text("Select sent date: (${formatDate(_selectedSentDate)})"),
                  ElevatedButton(onPressed: (){
                    _selectDate(context,2);
              }
                  , child: Text("Select date"))
                ],
              ),
              DropdownMenu<String>(
                initialSelection: _models[0], // By default pilih - Neo
                controller: modelController,
                // requestFocusOnTap is enabled/disabled by platforms when it is null.
                requestFocusOnTap: true,
                label: const Text('Select Model'),
                onSelected: (String? model) {
                  setState(() {
                    _selectedModel = model!;
                  });
                },
                dropdownMenuEntries: _models.map(
                        (model)  => DropdownMenuEntry(value: model, label: model))
                    .toList(),
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(0, 75, 160, 1),
                    foregroundColor: Colors.white
                  ),
                  onPressed: () async {
                    await createBooking(
                      nameEditingController.text,
                      emailEditingController.text,
                      addressEditingController.text,
                        formatDate(_selectedPickupDate),
                      formatDate(_selectedSentDate),
                      _selectedModel
                    );
                    SnackBar snackBar = SnackBar(content:
                    Text("Succesfully add booking"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
          
          
              }, child: Text("Book a motor"))
            ],
          )),
        ),
      )
    );
  }

  Future<http.Response> createBooking(String name, String email,
      String address, String pickup, String sent, String model)
  {
   // POST  - CREATE   = Need body
    // PUT - UPDATE = Need Body
    // GET  - READ
    // DELETE - DELETE
    // Selepas http. , http.post ->  Ia merujuk kepada method API (CRUD)
    // Eg: Rujuk video untuk PUT dan DELETE

    // Kalau tidak perlukan body -> http.get(address) -> 1 argument
    // Kalau perlukan body -> http.post (3 argument) -> 1 address, headers, body

    // Ps: In the future , for example with login function, you might want to pass
    // login credential (token) in headers
    // in that case, get and delete will have two arguments, address dan headers
    return http.post(
      Uri.parse('https://api.sheety.co/4db58997dd33ab7eaa3d621c48bdea06/booking/sheet1'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "sheet1": {
          "name":name,
          "email":email,
          "address":address,
          "pickup":pickup,
          "sent":sent,
          "motor":model
        }
      }),
    );
  }
}

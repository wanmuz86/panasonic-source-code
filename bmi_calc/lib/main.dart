

import 'dart:math';

import 'package:flutter/material.dart';

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
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double _heightSliderValue = 170;
  double _weightSliderValue = 70;
  var _bmi = 0;
  var _message = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      appBar: AppBar(title: Text("BMI Calculator"),
        backgroundColor: Colors.red,),
      body:SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Text("BMI Calculator", style: TextStyle(
                fontSize: 32,
                color: Colors.red
              ),),
              SizedBox(height: 8,),
              Text("We care about your health", style: TextStyle(fontSize: 24),),
              SizedBox(height: 8,),
              Image.network("https://rtaesthetics.co.uk/wp-content/uploads/2021/03/bmi-adult-fb-600x315-1.jpeg"),
              SizedBox(height: 8,),
              Text("Height ( ${_heightSliderValue.round()} cm)"),
          Slider(
            // Where I get the value of slider ? almost the same as TextEditingController
            value: _heightSliderValue,
            // Max value on slider
            max: 200,
            // Min value on slider
            min:20,
            // When the slider is dragged
            // setState -> Update the value of heightslidervalue
            // And refresh the UI (setState)
            onChanged: (double value) {
              setState(() {
                _heightSliderValue = value;
              });
            },
          ),
              SizedBox(height: 8,),
              Text("Weight ( ${_weightSliderValue.round()} kg)"),
          Slider(
            value: _weightSliderValue,
            max: 180,
            min:10,
            onChanged: (double value) {
              setState(() {
                _weightSliderValue = value;
              });
            },
          ),
              SizedBox(height: 8,),
              _bmi != 0 ? Text("Your BMI is $_bmi") : SizedBox(),
              Text(_message),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white
                ),
                icon: Icon(Icons.favorite),
                  onPressed: (){
                  // berat / (tinggi (m))^2
                    // local variable
                    var bmiTemp = _weightSliderValue / pow((_heightSliderValue/100),2);
                    var messageTemp="";
                    if (bmiTemp < 18.5){
                      messageTemp = "You are underweight";
                    } else if (bmiTemp < 25){
                      messageTemp = "You are normal";
                    }
                     else if (bmiTemp < 30){
                       messageTemp = "You are overweight";
                    }
                     else {
                       messageTemp = "You are obese";
                    }

                    // Set the value and update the UI
                    // _bmi = bmiTemp.round(); // assign the value
                    // assign AND update the UI (refresj the UI with new value)
                    setState(() {
                      // since we do var
                      // _bmi is int
                      // bmiTemp is double
                      // We need to transform bmiTemp to int .round()
                      // Type safe language
                      _bmi = bmiTemp.round();
                      _message = messageTemp;
                    });
                  },
                  label: Text("Calculate BMI"))
            ],
          ),
        ),
      )
    );
  }
}


import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("의식 설정 위젯 활용하기"),
          ), // AppBar

          body: Stack(children: [
            Align(
                alignment: Alignment(0.0, 0.0),
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.yellow,
                ) // Container
                ), // Align
            Align(
                alignment: FractionalOffset(1.0, 0.0),
                child: Container(
                  width: 150,
                  height: 150,
                  color: Colors.blue,
                ) // Container
                ), // Align
            Positioned(
              left: 40.0,
              top: 40.0,
              child: Container(
                color: Colors.red,
                height: 150.0,
                width: 150.0,
              ), // Container
            ) // Positioned
          ]) // Stack
          ),
    );
  }
}

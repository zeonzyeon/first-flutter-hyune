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
            title: Text("크기 설정 위젯 활용하기"),
          ), // AppBar

          body: Column(children: [
            IntrinsicWidth(
              // IntrinsicWidth 위젯은 자식 위젯들의 최대 너비에 맞춰서 너비를 조정
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(color: Colors.red, width: 50.0, height: 50.0),
                  Container(color: Colors.green, width: 150.0, height: 150.0),
                  Container(color: Colors.blue, width: 100.0, height: 100.0),
                ],
              ), // Column
            ), // IntrinsicWidth
            ConstrainedBox(
                // ConstrainedBox**는 자식 위젯의 크기를 제한하는 위젯
                constraints: BoxConstraints(
                  minWidth: 300,
                  maxHeight: 50,
                ),
                child: Container(
                    color: Colors.amber,
                    width: 150,
                    height: 150)) // ConstrainedBox
          ]) // Column
          ), // Scaffold
    );
  }
}

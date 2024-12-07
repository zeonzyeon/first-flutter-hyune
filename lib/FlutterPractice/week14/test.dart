import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageTestScreen(),
    );
  }
}

class ImageTestScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Test"),
      ),
      body: Center(
        child: Image.asset('images/dash_cam.png'), // 테스트 이미지 경로
      ),
    );
  }
}

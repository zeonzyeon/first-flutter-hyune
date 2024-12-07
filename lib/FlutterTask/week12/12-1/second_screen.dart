import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SecondScreen extends StatefulWidget {
  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String resultMessage = "Result: null";
  String receiveMessage = "Receive Message: null";

  // 입력 값을 관리할 TextEditingController
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> nativeCall() async {
    const methodChannel = MethodChannel('myMethodChannel');

    try {
      // 사용자가 입력한 값을 가져옴
      var details = {
        'Username': usernameController.text,
        'Password': passwordController.text,
      };

      // 네이티브 메서드 호출 및 결과 받기
      final Map result = await methodChannel.invokeMethod("oneMethod", details);
      setState(() {
        resultMessage = "Result: ${result['status']}"; // 성공 또는 실패 메시지 설정
      });

      // 네이티브에서 추가 메서드 호출 처리
      methodChannel.setMethodCallHandler((call) async {
        if (call.method == "twoMethod") {
          setState(() {
            receiveMessage = "Receive Message: ${call.arguments}";
          });
          return 'Reply from Dart';
        }
      });
    } on PlatformException catch (e) {
      setState(() {
        resultMessage = "Result: Error";
        receiveMessage = "Receive Message: Failed to communicate with native.";
      });
      print("Failed: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Integrating Platforms Example"),
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: Colors.deepPurpleAccent,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController, // username 입력 값을 관리
              decoration: InputDecoration(
                hintText: 'Username',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController, // password 입력 값을 관리
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: nativeCall,
              child: Text("Login"),
            ),
            SizedBox(height: 20),
            Text(resultMessage,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text(receiveMessage,
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FirstScreen extends StatefulWidget {
  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  String? resultMessage;
  String? receiveMessage;

  Future<Null> nativeCall() async {
    const channel =
        BasicMessageChannel<String>('myMessageChannel', StringCodec());
    String? result = await channel.send('Hello from Dart');
    setState(() {
      resultMessage = result;
    });
    channel.setMessageHandler((String? message) async {
      setState(() {
        receiveMessage = message;
      });
      return 'Reply from Dart';
    });
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("resultMessage: $resultMessage",
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 10),
              Text("receiveMessage: $receiveMessage",
                  style: TextStyle(color: Colors.white)),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: nativeCall,
                child: Text("native call"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

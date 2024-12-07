import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThirdScreen extends StatefulWidget {
  @override
  _ThirdScreenState createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  static const eventChannel = EventChannel('eventChannel');
  int streamCount = 0;

  @override
  void initState() {
    super.initState();
    eventChannel.receiveBroadcastStream().listen(
      (data) {
        setState(() {
          streamCount = data;
        });
      },
      onError: (error) {
        setState(() {
          streamCount = -1;
        });
      },
    );
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
          child: Text(
            streamCount >= 0
                ? "Stream Count: $streamCount"
                : "Error: Unable to fetch stream data",
            style: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

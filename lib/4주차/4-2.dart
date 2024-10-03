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
          title: Text('Key Test(StatefulWidget)'),
        ),
        body: MyWidget(),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyWidgetState();
  }
}

class _MyWidgetState extends State<MyWidget> {
  List<Widget> widgetList = [
    MyColorItemWidget(Colors.red, key: UniqueKey()),
    MyColorItemWidget(Colors.blue, key: UniqueKey()),
  ];

  void onChange() {
    setState(() {
      widgetList.insert(1, widgetList.removeAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: widgetList),
        ElevatedButton(onPressed: onChange, child: Text("toggle"))
      ],
    );
  }
}

class MyColorItemWidget extends StatefulWidget {
  Color color;
  MyColorItemWidget(this.color, {Key? key}): super(key: key);

  @override
  State<StatefulWidget> createState(){
    return _MyColorItemWidgetState(color);
  }
}

class _MyColorItemWidgetState extends State<MyColorItemWidget>{
  Color color;
  _MyColorItemWidgetState(this.color);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: color,
        width: 150,
        height: 150,
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';

class ThirdScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer2<MyDataModel1, MyDataModel2>(
        builder: (context, model1, model2, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SubWidget1(
                  model1: model1,
                  model2: model2), // SubWidget1 내부에 SubWidget2 포함
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: model1.increment,
                child: Text('Count Increment'),
              ),
              ElevatedButton(
                onPressed: model2.toggleText,
                child: Text('Toggle Text'),
              ),
            ],
          );
        },
      ),
    );
  }
}

class SubWidget1 extends StatelessWidget {
  final MyDataModel1 model1;
  final MyDataModel2 model2;

  SubWidget1({required this.model1, required this.model2});

  @override
  Widget build(BuildContext context) {
    print('SubWidget1 build...');
    return Container(
      color: Colors.green,
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'I am SubWidget1',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            'Counter: ${model1.count}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Text(
            'String: ${model2.text}',
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20),
          SubWidget2(),
        ],
      ),
    );
  }
}

class SubWidget2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('SubWidget2 build...');
    return Container(
      color: Colors.deepPurpleAccent,
      padding: EdgeInsets.all(20),
      child: Text(
        'I am SubWidget2',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}

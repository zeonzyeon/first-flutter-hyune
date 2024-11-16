import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model1 = Provider.of<MyDataModel1>(context);
    final model2 = Provider.of<MyDataModel2>(context);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Counter: ${model1.count}'),
          Text('String: ${model2.text}'),
        ],
      ),
    );
  }
}

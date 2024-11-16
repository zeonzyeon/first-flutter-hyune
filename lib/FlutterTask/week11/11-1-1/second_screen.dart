import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final streamValue = Provider.of<int>(context);
    return Center(
      child: Text('Stream: $streamValue'),
    );
  }
}

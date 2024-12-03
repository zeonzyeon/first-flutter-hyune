import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models.dart';

class FourthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Selector<MyDataModel1, String>(
            selector: (context, model) => model.data,
            builder: (context, data, child) {
              return Container(
                color: Colors.lightBlue,
                padding: EdgeInsets.all(20),
                child: Text(
                  'Selector String: $data',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Provider.of<MyDataModel1>(context, listen: false).toggleText();
            },
            child: Text('Toggle Text'),
          ),
        ],
      ),
    );
  }
}

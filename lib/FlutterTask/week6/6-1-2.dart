import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<String> citys = ['서울시', '인천시', '부산시', '대구시', '대전시', '광주시', '울산시', '세종시'];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('그리드 뷰 활용하기'),
        ),
        body: GridView.builder(
          itemCount: citys.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Text(citys[index]),
                  Image.asset('images/cat.png'),
                ],
              ),
            );
          },
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
        ),
      ),
    );
  }
}

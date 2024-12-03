import 'package:flutter/material.dart';

void main() {
  runApp(MyApp()); // MyApp을 루트 위젯으로 사용
}

class MyApp extends StatelessWidget {
  // StatelessWidget : 상태를 가지지 않는 위젯
  @override
  Widget build(BuildContext context) {
    // build는 위젯 트리 구성
    return MaterialApp(
      // MaterialApp: 루트 위젯으로 사용되는 클래스, 앱의 시작점
      home: Scaffold(
        // Scaffold: Material 디자인에서 기본적인 화면 레이아웃 제공
        appBar: AppBar(
          // 상단에 고정되는 앱의 제목 바
          title: Text('화면을 구성하는 위젯'),
        ),
        body: Center(
            // 앱의 본문, Center를 사용해 자식 위젯을 중앙에 배치
            child: GestureDetector(child: Text('Hello World'))),
        // GestureDetector로 사용자의 터치 이벤트를 감지
      ),
    );
  }
}

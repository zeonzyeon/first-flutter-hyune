import 'package:flutter/material.dart';

// MyInheritedWidget:
//
// InheritedWidget을 상속받아 상태 공유를 구현
// count와 increment 메서드를 제공
// updateShouldNotify는 항상 true를 반환하여 자식 위젯에 상태 변화를 알림

// TestWidget:
//
// MyInheritedWidget에서 상태를 가져와 사용
// 상태를 직접 변경하지 않고 increment() 메서드를 호출하거나 UI 로직으로 상태를 처리

// TestSubWidget:
//
// MyInheritedWidget에서 count를 참조하여 상태를 표시

// -> InheritedWidget을 통해 공용 상태를 자식 위젯들에게 전달하는 방법

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Inherited Test'),
        ),
        body: MyInheritedWidget(
          child: TestWidget(),
        ),
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final int count = 0;

  MyInheritedWidget({required Widget child}) : super(child: child);

  void increment() {
    print('Increment function called');
  }

  @override
  bool updateShouldNotify(MyInheritedWidget oldWidget) {
    return true;
  }

  static MyInheritedWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>()!;
  }
}

class TestWidget extends StatelessWidget {
  TestWidget() {
    print('TestWidget constructor...');
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        MyInheritedWidget myInheritedWidget = MyInheritedWidget.of(context);
        int counter = myInheritedWidget.count;
        Function increment = myInheritedWidget.increment;

        return Center(
          child: Container(
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  'TestWidget $counter',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  child: Text('increment()'),
                  onPressed: () => increment(),
                ),
                ElevatedButton(
                  child: Text('count++'),
                  onPressed: () {
                    setState(() {
                      // Just an example logic for UI update
                      counter++;
                    });
                  },
                ),
                TestSubWidget(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TestSubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int count = MyInheritedWidget.of(context).count;

    return Container(
      width: 200,
      height: 200,
      color: Colors.yellow,
      child: Center(
        child: Text(
          'SubWidget: $count',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

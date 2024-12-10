import 'package:flutter/material.dart';

// ParentWidget:
//
// 부모 상태(favorited, favoriteCount)를 관리하며, 자식 위젯과 데이터를 주고받음
// GlobalKey를 활용해 자식의 상태(ChildWidgetState)를 참조

// ChildWidget:
//
// 자체적인 childCount를 관리하며 버튼으로 증가/감소 가능
// 부모가 상태를 가져갈 수 있도록 GlobalKey 사용

// IconWidget:
//
// 부모의 상태를 findAncestorStateOfType을 통해 참조하여 즐겨찾기 기능을 제공

// ContentWidget:
//
// 부모의 상태를 참조하여 favoriteCount를 표시

// -> Flutter의 위젯 트리를 통해 부모와 자식 간 상태를 주고받는 구조

void main() {
  runApp(ParentWidget());
}

// ParentWidget 정의
class ParentWidget extends StatefulWidget {
  @override
  ParentWidgetState createState() => ParentWidgetState();
}

class ParentWidgetState extends State<ParentWidget> {
  bool favorited = false;
  int favoriteCount = 10;

  GlobalKey<ChildWidgetState> childKey = GlobalKey();
  int childCount = 0;

  void toggleFavorite() {
    setState(() {
      if (favorited) {
        favoriteCount -= 1;
        favorited = false;
      } else {
        favoriteCount += 1;
        favorited = true;
      }
    });
  }

  void getChildData() {
    ChildWidgetState? childState = childKey.currentState;
    setState(() {
      childCount = childState?.childCount ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('State Test'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Text(
                    'I am Parent, child count: $childCount',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                ElevatedButton(
                  child: Text('get child data'),
                  onPressed: getChildData,
                ),
              ],
            ),
            ChildWidget(key: childKey),
            IconWidget(),
            ContentWidget(),
          ],
        ),
      ),
    );
  }
}

// ChildWidget 정의
class ChildWidget extends StatefulWidget {
  ChildWidget({Key? key}) : super(key: key);

  @override
  ChildWidgetState createState() => ChildWidgetState();
}

class ChildWidgetState extends State<ChildWidget> {
  int childCount = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: Text(
            'I am Child, childCount: $childCount',
            style: TextStyle(fontSize: 20),
          ),
        ),
        ElevatedButton(
          child: Text('Increment'),
          onPressed: () {
            setState(() {
              childCount++;
            });
          },
        ),
        ElevatedButton(
          child: Text('Decrement'),
          onPressed: () {
            setState(() {
              childCount--;
            });
          },
        ),
      ],
    );
  }
}

// IconWidget 정의
class IconWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ParentWidgetState? state =
        context.findAncestorStateOfType<ParentWidgetState>();
    return Center(
      child: IconButton(
        icon: (state?.favorited ?? false)
            ? Icon(Icons.favorite)
            : Icon(Icons.favorite_border),
        color: Colors.red,
        iconSize: 200,
        onPressed: state?.toggleFavorite,
      ),
    );
  }
}

// ContentWidget 정의
class ContentWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ParentWidgetState? state =
        context.findAncestorStateOfType<ParentWidgetState>();
    return Center(
      child: Text(
        'favoriteCount: ${state?.favoriteCount}',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

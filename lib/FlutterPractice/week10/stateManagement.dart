import 'package:flutter/material.dart';

// ParentWidget:
//
// StatefulWidget으로 구현되어 상태 관리 가능
// favorited와 favoriteCount를 관리하며, toggleFavorite 메서드를 통해 상태를 변경

// IconWidget:
//
// StatelessWidget으로 구현
// favorited 상태에 따라 다른 아이콘과 색상을 표시
// 부모로부터 전달된 onChanged를 통해 상태를 업데이트

// ContentWidget:
//
// StatelessWidget으로 구현
// 부모로부터 전달된 favoriteCount를 표시

// -> ParentWidget을 루트 위젯으로 실행하며 상태 변화가 IconWidget과 ContentWidget에 반영

void main() {
  runApp(MaterialApp(
    home: ParentWidget(),
  ));
}

// ParentWidget 정의
class ParentWidget extends StatefulWidget {
  @override
  ParentWidgetState createState() => ParentWidgetState();
}

class ParentWidgetState extends State<ParentWidget> {
  bool favorited = false;
  int favoriteCount = 10;

  void toggleFavorite() {
    setState(() {
      if (favorited) {
        favoriteCount--;
      } else {
        favoriteCount++;
      }
      favorited = !favorited;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconWidget(
                favorited: favorited,
                onChanged: toggleFavorite,
              ),
              ContentWidget(favoriteCount: favoriteCount),
            ],
          ),
        ),
      ),
    );
  }
}

// IconWidget 정의
class IconWidget extends StatelessWidget {
  final bool favorited;
  final Function onChanged;

  IconWidget({required this.favorited, required this.onChanged});

  void _handleTap() {
    onChanged();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Text(
            'I am IconWidget',
            style: TextStyle(fontSize: 30),
          ),
        ),
        IconButton(
          icon: Icon(
            favorited ? Icons.favorite : Icons.favorite_border,
          ),
          color: favorited ? Colors.red : null,
          onPressed: _handleTap,
        ),
      ],
    );
  }
}

// ContentWidget 정의
class ContentWidget extends StatelessWidget {
  final int favoriteCount;

  ContentWidget({required this.favoriteCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Text(
            'I am ContentWidget, favoriteCount: $favoriteCount',
            style: TextStyle(fontSize: 20),
          ),
        ),
      ],
    );
  }
}

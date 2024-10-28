import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => OneScreen(),
        '/two': (context) => TwoScreen(),
        '/three': (context) => ThreeScreen(),
      },
    );
  }
}

class OneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/two');
          },
          child: CircleAvatar(
            radius: 80,
            backgroundImage: AssetImage('images/cat.png'),
          ),
        ),
      ),
    );
  }
}

class TwoScreen extends StatelessWidget {
  final List<User> users = [
    User(name: '홍길동', phone: '010-1111-1111'),
    User(name: '김철수', phone: '010-2222-2222'),
    User(name: '이영희', phone: '010-3333-3333'),
    User(name: '박민수', phone: '010-4444-4444')
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('친구 목록'),
      ),
      body: ListView.separated(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage('images/cat.png'),
            ),
            title: Text(users[index].name),
            subtitle: Text(users[index].phone),
            trailing: Icon(Icons.more_vert),
            onTap: () async {
              final message = await Navigator.pushNamed(
                context,
                '/three',
                arguments: users[index],
              );

              if (message != null && message is String) {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('입력한 메시지'),
                      content: Text(message),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('확인',
                              style: TextStyle(color: Colors.purple)),
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            height: 2,
            color: Colors.black,
          );
        },
      ),
    );
  }
}

class User {
  final String name;
  final String phone;

  User({required this.name, required this.phone});
}

class ThreeScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final User user = ModalRoute.of(context)!.settings.arguments as User;

    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name}에게 메시지 보내기'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: '메시지를 입력하세요.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.purple),
                ),
                prefixIcon: Icon(Icons.send, color: Colors.purple),
                hintText: 'Hello World!',
                hintStyle: TextStyle(color: Colors.purple),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.purple, width: 2.0),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String message = _controller.text;
                Navigator.pop(context, message);
              },
              child: Text('메시지 전송'),
            ),
          ],
        ),
      ),
    );
  }
}

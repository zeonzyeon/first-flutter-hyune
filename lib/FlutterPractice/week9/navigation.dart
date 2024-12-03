import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => OneScreen(),
        '/two': (context) => TwoScreen(),
      },
    );
  }
}

class User {
  final String name;
  final String location;

  User(this.name, this.location);
}

class OneScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('One Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final result = await Navigator.pushNamed(
              context,
              '/two',
            );

            if (result is User) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('Received User'),
                    content: Text(
                        'Result: ${result.name}, Location: ${result.location}'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            }
          },
          child: Text('Go Two Screen'),
        ),
      ),
    );
  }
}

class TwoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Two Screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(
              context,
              User('Jeon', 'Daejeon'),
            );
          },
          child: Text('Go Back with User'),
        ),
      ),
    );
  }
}

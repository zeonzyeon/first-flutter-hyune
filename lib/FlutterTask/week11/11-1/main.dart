import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models.dart';
import 'first_screen.dart';
import 'second_screen.dart';
import 'third_screen.dart';
import 'fourth_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<MyDataModel1>(create: (_) => MyDataModel1()),
        ChangeNotifierProvider<MyDataModel2>(create: (_) => MyDataModel2()),
        StreamProvider<int>(
          create: (_) => streamFun(),
          initialData: 0,
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    FirstScreen(),
    SecondScreen(),
    ThirdScreen(),
    FourthScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.orange,
          title: Text('Provider Package'),
        ),
        body: _widgetOptions[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'First',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.business),
              label: 'Second',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Third',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Fourth',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}

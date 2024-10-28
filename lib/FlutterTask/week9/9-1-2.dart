import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  List items = [];

  Future<void> fetchData() async {
    var client = http.Client();
    try {
      final response = await client
          .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
      if (response.statusCode == 200 || response.statusCode == 201) {
        setState(() {
          items = json.decode(response.body);
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      client.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Jsonplaceholder Contents'),
          backgroundColor: Colors.yellow,
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: fetchData,
            ),
          ],
        ),
        body: items.isEmpty
            ? Center(child: Text('데이터가 없습니다.'))
            : ListView.separated(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(items[index]['id'].toString()),
                    subtitle: Text(items[index]['title']),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 2,
                    color: Colors.black,
                  );
                },
              ),
      ),
    );
  }
}

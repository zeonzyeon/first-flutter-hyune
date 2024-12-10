import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

// SQLite Database 초기화:
//
// openDatabase를 통해 데이터베이스를 생성 및 초기화
// CREATE TABLE 명령어로 User 테이블을 만듦

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NativePluginWidget(),
    );
  }
}

class NativePluginWidget extends StatefulWidget {
  @override
  NativePluginWidgetState createState() => NativePluginWidgetState();
}

class NativePluginWidgetState extends State<NativePluginWidget> {
  late Database db;
  int lastId = 0;

  @override
  void initState() {
    super.initState();
    _createTable();
  }

  Future<void> _createTable() async {
    db = await openDatabase(
      join(await getDatabasesPath(), "my_db.db"),
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE User (
            id INTEGER PRIMARY KEY,
            name TEXT,
            address TEXT
          )
        ''');
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) {},
    );
  }

  Future<void> insert() async {
    lastId++;
    User user = User.fromData('name$lastId', 'seoul$lastId');
    lastId = await db.insert("User", user.toMap());
    print('${user.toMap()}');
  }

  Future<void> update() async {
    User user = User.fromData('name${lastId - 1}', 'seoul${lastId - 1}');
    await db.update(
      "User",
      user.toMap(),
      where: 'id=?',
      whereArgs: [lastId],
    );
  }

  Future<void> delete() async {
    await db.delete(
      'User',
      where: 'id=?',
      whereArgs: [lastId],
    );
    lastId--;
  }

  Future<void> query() async {
    List<Map> maps = await db.query(
      'User',
      columns: ['id', 'name', 'address'],
    );
    List<User> users = List.empty(growable: true);
    maps.forEach((element) {
      users.add(User.fromMap(element as Map<String, Object>));
    });
    if (maps.isNotEmpty) {
      print('select: ${maps.first}');
    }
    users.forEach((user) {
      print('${user.name}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SQLite"),
      ),
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text('insert'),
                onPressed: insert,
              ),
              ElevatedButton(
                child: Text('update'),
                onPressed: update,
              ),
              ElevatedButton(
                child: Text('delete'),
                onPressed: delete,
              ),
              ElevatedButton(
                child: Text('query'),
                onPressed: query,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class User {
  int? id;
  String? name;
  String? address;

  User.fromData(this.name, this.address);

  User.fromMap(Map<String, Object> map) {
    id = map['id'] as int?;
    name = map['name'] as String?;
    address = map['address'] as String?;
  }

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      'name': name,
      'address': address,
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}

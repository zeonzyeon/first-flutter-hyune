import 'package:flutter/material.dart';

class MyDataModel1 with ChangeNotifier {
  int count = 0;
  String data = "Mobile";

  void increment() {
    count++;
    notifyListeners();
  }

  void toggleText() {
    data = data == "Mobile" ? "Programming" : "Mobile";
    notifyListeners();
  }
}

class MyDataModel2 with ChangeNotifier {
  String text = "Hello";

  void toggleText() {
    text = text == "Hello" ? "World" : "Hello";
    notifyListeners();
  }
}

Stream<int> streamFun() async* {
  for (int i = 1; i < 100; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield i;
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ProxyProvider
// 코드 수정 필요 class Sum {}, Sum(model.count)
void main() => runApp(MyApp());

class Counter extends ChangeNotifier {
  int count = 0;

  void increment() {
    count++;
    notifyListeners();
  }
}

class Sum {
  int _sum;

  Sum(this._sum);

  int get sum => _sum;

  void set sum(int value) {
    _sum = value;
  }

  void add(int value) {
    _sum += value;
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('ProxyProvider Test'),
        ),
        body: MultiProvider(
          providers: [
            ChangeNotifierProvider<Counter>.value(
              value: Counter(),
            ),
            ProxyProvider<Counter, Sum>(
              update: (context, model, sum) {
                if (sum != null) {
                  sum.sum = model.count;
                  return sum;
                } else {
                  return Sum(model.count);
                }
              },
            ),
            ProxyProvider2<Counter, Sum, String>(
              update: (context, model1, model2, data) {
                return "count : ${model1.count}, sum : ${model2.sum}";
              },
            ),
          ],
          child: SubWidget(),
        ),
      ),
    );
  }
}

class SubWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var counter = Provider.of<Counter>(context);
    var sum = Provider.of<Sum>(context);
    var string_data = Provider.of<String>(context);
    return Container(
      color: Colors.orange,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'count : ${counter.count}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Text(
              'sum : ${sum.sum}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            Text(
              'string : ${string_data}',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              child: Text('increment'),
              onPressed: () {
                counter.increment();
              },
            ),
          ],
        ),
      ),
    );
  }
}

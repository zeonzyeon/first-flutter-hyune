import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// SharedPreferences 사용:
//
// SharedPreferences는 간단한 키-값 데이터를 저장할 수 있는 Flutter의 패키지

// getInitData 메서드:
//
// 앱 시작 시 호출되며 저장된 slider와 switch 값을 불러온다
// 불러온 데이터를 sliderValue와 switchValue에 할당하고 UI를 업데이트

// _save 메서드:
//
// 현재 sliderValue와 switchValue 값을 SharedPreferences에 저장

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  double sliderValue = 0.0;
  bool switchValue = false;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    getInitData();
  }

  Future<void> getInitData() async {
    prefs = await SharedPreferences.getInstance();
    sliderValue = prefs.getDouble('slider') ?? 0.0;
    switchValue = prefs.getBool('switch') ?? false;
    setState(() {});
  }

  Future<void> _save() async {
    await prefs.setDouble('slider', sliderValue);
    await prefs.setBool('switch', switchValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Preferences"),
      ),
      body: Container(
        color: Colors.yellow,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Slider(
                value: sliderValue,
                min: 0,
                max: 10,
                onChanged: (double value) {
                  setState(() {
                    sliderValue = value;
                  });
                },
              ),
              Switch(
                value: switchValue,
                onChanged: (bool value) {
                  setState(() {
                    switchValue = value;
                  });
                },
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

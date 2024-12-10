import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

// ImagePicker 사용:
//
// ImagePicker를 통해 갤러리 또는 카메라에서 이미지를 선택

// getGalleryImage와 getCameraImage 메서드:
//
// 각각 갤러리와 카메라에서 이미지를 선택하도록 구현

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
  XFile? _image;

  Future getGalleryImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future getCameraImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Picker"),
      ),
      body: Container(
        color: Colors.indigo,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text('gallery'),
                onPressed: getGalleryImage,
              ),
              Center(
                child: _image == null
                    ? Text(
                        'No image selected.',
                        style: TextStyle(color: Colors.white),
                      )
                    : CircleAvatar(
                        backgroundImage: FileImage(File(_image!.path)),
                        radius: 100,
                      ),
              ),
              ElevatedButton(
                child: Text('camera'),
                onPressed: getCameraImage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

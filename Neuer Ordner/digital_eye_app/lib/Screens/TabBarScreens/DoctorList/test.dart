

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera_camera/camera_camera.dart';
import 'package:flutter_native_image/flutter_native_image.dart';


class HomeScreen2 extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen2> {
  File val;

  Future<String> _resizePhoto(String filePath) async {
    ImageProperties properties =
    await FlutterNativeImage.getImageProperties(filePath);

    int width = properties.width;
    var offset = (properties.height - properties.width) / 2;

    File croppedFile = await FlutterNativeImage.cropImage(
        filePath, 0, offset.round(), width, width);

    return croppedFile.path;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("")),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.camera_alt),
            onPressed: () async {
              val = await showDialog(
                  context: context,
                  builder: (context) => Camera(
                    mode: CameraMode.fullscreen,
                    imageMask: CameraFocus.rectangle(
                      color: Colors.black.withOpacity(0.5),
                    ),
                    //initialCamera: CameraSide.front,
                    //enableCameraChange: false,
                    //  orientationEnablePhoto: CameraOrientation.landscape,
                    onChangeCamera: (direction, _) {
                      print('--------------');
                      print('$direction');
                      print('--------------');
                    },

                    // imageMask: CameraFocus.square(
                    //   color: Colors.black.withOpacity(0.5),
                    // ),
                  ));
              setState(() {});
            }),
        body: Center(
            child: Container(
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width * 0.8,
                child: val != null
                    ? Image.file(
                  val,
                  fit: BoxFit.contain,
                )
                    : Text("Tire a foto"))));
  }
}
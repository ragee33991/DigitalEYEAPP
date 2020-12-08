import 'dart:io';
import 'dart:typed_data';

import 'package:digital_eye_app/Screens/TabBarScreens/DoctorList/firebase_ml_vision.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core ;


import 'detector_painters.dart';



class ClipperExamples extends StatefulWidget {
  final _imageFile ;
  ClipperExamples( this._imageFile, Size imageSize);
  @override
  _RemakeState createState() => _RemakeState();
}

class Datum {
  final int height, width, x, y;

  Datum({this.height, this.width, this.x, this.y});
}





class _RemakeState extends State<ClipperExamples> {
  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 800;

  Image _image =  Image.network(
      'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60');
  Image _image2;
  @override
  Widget build(BuildContext context) {



    takeScreenShot() async {
      RenderRepaintBoundary boundary =
      previewContainer.currentContext.findRenderObject();
      double pixelRatio = originalSize / MediaQuery.of(context).size.width;
      ui.Image image = await boundary.toImage(pixelRatio: pixelRatio);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData.buffer.asUint8List();
      setState(() {
        _image2 = Image.memory(pngBytes.buffer.asUint8List());
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      File imgFile = new File('$directory/screenshot.png');
     await imgFile.writeAsBytes(pngBytes);

      firebase_storage.FirebaseStorage storage =
          firebase_storage.FirebaseStorage.instance;
      try {
        await firebase_storage.FirebaseStorage.instance
            .ref()
            .child(RouterName.id)
            .child('image.png')
            .putFile(imgFile);
      } on firebase_core.FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
      }

      final snackBar = SnackBar(
        content: Text('Saved to ${directory}'),
        action: SnackBarAction(
          label: 'Ok',
          onPressed: () {
            // Some code
          },
        ),
      );

      Scaffold.of(context).showSnackBar(snackBar);
    }


    double size = MediaQuery
        .of(context)
        .size
        .width;
    double factor = size / originalSize;
    Datum data = Datum(
      height: (106 * factor).floor(),
      width: (247 * factor).floor(),
      x: (410.16668701171875 * factor).floor(),
      y: (30.23333740234375 * factor).floor(),
    );
    Datum data2 = Datum(
      height: (49 * factor).floor(),
      width: (178 * factor).floor(),
      x: (74.16668701171875 * factor).floor(),
      y: (472.23333740234375 * factor).floor(),
    );
    return Container(
      width: size,
      padding: EdgeInsets.only(top: 40.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RepaintBoundary(
              key: previewContainer,
              child: Stack(
                children: <Widget>[
                  Image.file(
                            widget._imageFile),
                  Positioned(
                    top: data2.y.toDouble() - 15,
                    left: data2.x.toDouble(),
                    child: Container(
                      width: data2.width.toDouble(),
                      height: data2.height.toDouble(),
                      child:
                      Material(
                        child: TextField(
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Write here..",
                          ),
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            RaisedButton(
              child: Text('Download'),
              onPressed: () {
                FocusScope.of(context).requestFocus(FocusNode());
                takeScreenShot();
              },
            ),
            _image2 != null ? _image2 : Container(),
          ],
        ),
      ),
    );
  }
  }
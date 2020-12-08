import 'dart:io';

import 'package:camera/camera.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/services/database.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';
import 'package:image_picker/image_picker.dart';



import '../../../main.dart';
import 'camera_preview_scanner.dart';
import 'material_barcode_scanner.dart';
import 'picture_scanner.dart';


class DoctorsList extends StatefulWidget {


  @override
  _ExampleListState createState() => _ExampleListState();
}

class _ExampleListState extends State<DoctorsList> {
  static final List<String> _exampleWidgetNames = <String>[
    '$PictureScanner',
    '$CameraPreviewScanner',
    '$MaterialBarcodeScanner',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
        title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.drawerDoctors ),Colors.white),
        backgroundColor: AppColor.themeColor,
        elevation: 1.0,
        actions: setCommonCartNitificationView(context),
      ),

      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Eye Scanner",
                  textAlign: TextAlign.center,),
              ),
              SizedBox(height: 24,),
          InkWell(
              onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CameraPreviewScanner())),
                child: new Container(
                  height: 50,
                  width: 400,
                  child: new Material(
                    color: AppColor.themeColor,
                    borderRadius: BorderRadius.circular(25),
                    elevation: 5.0,
                    child: new Center(
                      child: new Text("Start Eye Scanner",
                        textDirection: SharedManager.shared.direction,
                        style: new TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],),
        ),
      ),
      drawer: SharedManager.shared.setDrawer(context,PersonalInfo.name,PersonalInfo.email),

    );
  }
}
import 'dart:io';

import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/DoctorProfileScreen/DoctorProfileScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:image_picker/image_picker.dart';


/*

void main() => runApp(new DoctorListTabScreen());

class DoctorListTabScreen extends StatefulWidget {
  @override
  _DoctorListTabScreenState createState() => _DoctorListTabScreenState();
}

class _DoctorListTabScreenState extends State<DoctorListTabScreen> {
  File profile;

  // Show Option (Camera or Gallery) for Selecting Image
  void imagePicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            padding: EdgeInsets.only(top: 20, bottom: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.photo_camera),
                  color: AppColor.themeColor,
                  iconSize: 80,
                  onPressed: () {
                    Navigator.pop(context);
                    _cameraPicker();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.photo_library),
                  color: AppColor.themeColor,
                  iconSize: 80,
                  onPressed: () {
                    Navigator.pop(context);
                    _galleryPicker();
                  },
                ),
              ],
            ),
          );
        });
  }

  // Open Camera For Selecting Image
  _cameraPicker() async {
    File image = await ImagePicker.pickImage(source: ImageSource.camera);
    profile = image;
    if (image != null) {
      profile = image;
      setState(() {});
    }
  }

// Open Gallery For Selecting Image
  _galleryPicker() async {
    File image = await ImagePicker.pickImage(source: ImageSource.gallery);
    profile = image;
    if (image != null) {
      profile = image;
      setState(() {});
    }
  }

  AppTranslationsDelegate _newLocaleDelegate;
  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale:null);
    application.onLocaleChanged = onLocaleChange;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle("Upload Your Image",Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          actions: setCommonCartNitificationView(context),
        ),

        drawer: SharedManager.shared.setDrawer(context,PersonalInfo.name,PersonalInfo.email),
        body: Container(
          padding: EdgeInsets.only(top: 10),
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              // Image Container
              Expanded(
                child: profile == null
                    ? LightText(text: 'No Photo Selected ')
                    : Image.file(
                  profile,
                ),
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              // Button For Selecting Image
              ButtonTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                minWidth: 300.0,
                height: 50.0,
                child:           InkWell(
                  onTap: (){
                    imagePicker(context);
                  },
                  child: new Container(
                    height: 50,
                    width: 400,
                    child: new Material(
                      color: AppColor.themeColor,
                      borderRadius: BorderRadius.circular(25),
                      elevation: 5.0,
                      child: new Center(
                        child: new Text("Select Image",
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
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }


  //This is for localization
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

}

 */



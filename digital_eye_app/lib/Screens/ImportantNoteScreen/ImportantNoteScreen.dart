import 'package:flutter/material.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';


class ImportantNoteScreen extends StatefulWidget {
  @override
  _ImportantNoteScreenState createState() => _ImportantNoteScreenState();
}

class _ImportantNoteScreenState extends State<ImportantNoteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
         centerTitle: true,
          title: setHeaderTitle(AppTranslations.of(context).text("importantNote"),Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
      ),
      body: new Container(
        padding: new EdgeInsets.all(15),
        child:new ListView(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                setCommonText("*",Colors.red, 29.0, FontWeight.w500, 2),
                SizedBox(width:5),
                new Expanded(
                  child:setCommonText(AppTranslations.of(context).text("note"),Colors.black, 18.0, FontWeight.w500, 3)
                  )
              ],
            ),
            SizedBox(height:30),
            ListTile(
              title:setCommonText(AppTranslations.of(context).text("note1"),Colors.grey[800], 16.0, FontWeight.w500, 2),
              subtitle:setCommonText(AppTranslations.of(context).text("subNote1"),Colors.grey[600], 16.0, FontWeight.w500, 2),
            ),
            ListTile(
              title:setCommonText(AppTranslations.of(context).text("note2"),Colors.grey[800], 16.0, FontWeight.w500, 2),
              subtitle:setCommonText(AppTranslations.of(context).text("subNote2"),Colors.grey[600], 13.0, FontWeight.w500, 3),
            ),
            ListTile(
              title:setCommonText(AppTranslations.of(context).text("note3"),Colors.grey[800], 16.0, FontWeight.w500, 2),
              subtitle:setCommonText(AppTranslations.of(context).text("subNote3"),Colors.grey[600], 14.0, FontWeight.w500, 2),
            ),
            ListTile(
              title:setCommonText(AppTranslations.of(context).text("note4"),Colors.grey[800], 16.0, FontWeight.w500, 2),
              subtitle:setCommonText(AppTranslations.of(context).text("subNote4"),Colors.grey[600], 14.0, FontWeight.w500, 2),
            ),
            SizedBox(height:30),
            new Container(
              height: 65,
              padding: new EdgeInsets.only(left:70,right:70,top:5,bottom:5),
                child: new InkWell(
                  onTap: (){
                    // 
                  },
                  child: new Container(
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppColor.themeColor,
                    borderRadius: BorderRadius.circular(8)
                  ),
                  child: new Center(
                    child: setCommonText(AppTranslations.of(context).text("agree"), Colors.white, 18.0, FontWeight.w500, 1),
                  ),
              ),
                ),
            )
          ],
        )
      ),
    );
  }
}
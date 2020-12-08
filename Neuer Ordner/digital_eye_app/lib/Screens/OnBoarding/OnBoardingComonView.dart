import 'package:flutter/material.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/Model.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
 setLocalView(String img,String title,String description){
  return new Container(
        color: Colors.white,
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              new Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(img)
                  )
                ),
              ),
              SizedBox(height: 50,),
              new Text(title,
              textDirection: SharedManager.shared.direction,
              style: new TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black
              ),
              ),
              SizedBox(height: 5,),
              new Padding(
                padding: new EdgeInsets.all(15),
                child:  new Text(description,
                textDirection: SharedManager.shared.direction,
                textAlign: TextAlign.justify,
                style: new TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54
                ),
                ),
              )
            ],
          ),
        ),
      );
}
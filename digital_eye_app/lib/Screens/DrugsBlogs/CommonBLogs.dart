
import 'package:flutter/material.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';


setCommonBlog(String imgUrl,String title,String description,double width,double height){
  return new Container(
    height: height,
    width: width,
    padding: new EdgeInsets.only(left: 15,right: 15,bottom: 15,top:0),
    child: new Material(
      elevation: 2.0,
      borderRadius: BorderRadius.circular(5),
      // color: Colors.white,
      child:new Padding(
        padding: new EdgeInsets.all(12),
        child: new Column(
          children: <Widget>[
            new Expanded(
              flex: 3,
              child: new Container(
                // color: Colors.red,
              decoration: BoxDecoration(
                borderRadius: new BorderRadius.circular(8),
                image: DecorationImage(
                  image: AssetImage(imgUrl),
                  fit: BoxFit.cover
                )
              ),
            ),
          ),
          new Expanded(
            child: new Container(
              // color: Colors.blue,
              padding: new EdgeInsets.only(top: 10),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  setCommonText(title, Colors.black, 17.0, FontWeight.w500, 1),
                  SizedBox(height: 5,),
                  setCommonText(description, Colors.grey, 16.0, FontWeight.w500, 2),
                ],
              ),
            ),
          ),
          ],
        ),
      )
    ),
  );
}
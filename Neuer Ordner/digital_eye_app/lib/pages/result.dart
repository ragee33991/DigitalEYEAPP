
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:flutter/material.dart';

import '../globals.dart';


int counter = 1;
int neck = 0;
int blurred = 0;
int irritation = 0;
int headaches = 0;
int doublev = 0;
int dry = 0;


class Results extends StatefulWidget {

  @override
  _ResultsState createState() => _ResultsState();

}

class _ResultsState extends State<Results> {

  @override
  Widget build(BuildContext context) {



     //neck += (int.parse(widget.neck.toString())/counter).round();
     // dry += (int.parse(widget.dry.toString())/counter).round();
     //irritation += (int.parse(widget.irritation.toString())/counter).round();
     //headaches += (int.parse(widget.headaches.toString())/counter).round();
   // doublev += (int.parse(widget.doublev.toString())/counter).round();

   return Scaffold(
     appBar: new AppBar(
       centerTitle: true,
       // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
       title: setHeaderTitle("Results",Colors.white),
       backgroundColor: AppColor.themeColor,
       elevation: 1.0,
       leading: new IconButton(
         icon: Icon(Icons.arrow_back_ios,color:Colors.white),
         onPressed: (){
           Navigator.of(context).pop();
         },
       ),
     ),
      // drawer: DrawerOnly(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 5,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  "Thank you for completing the Questionnaire",
                  textAlign: TextAlign.center,),
              ),
              SizedBox(height: 24,),
              InkWell(
                onTap: (){
                  Navigator.of(context).pop();
                },

                child: new Container(
                  height: 50,
                  width: 400,
                  child: new Material(
                    color: AppColor.themeColor,
                    borderRadius: BorderRadius.circular(25),
                    elevation: 5.0,
                    child: new Center(
                      child: new Text("Submit",
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
    );
  }
}






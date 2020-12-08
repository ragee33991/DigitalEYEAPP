import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gradient_widgets/gradient_widgets.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/generated/i18n.dart';
import 'package:digital_eye_app/model/doctor_model.dart';
import 'package:digital_eye_app/utils/utils.dart';


InputDecoration inputImageDecoration({image: String, hintText: String}) =>
    InputDecoration(
        contentPadding: EdgeInsets.all(0),
        prefixIcon: SvgPicture.asset(
          image,
          fit: BoxFit.none,
        ),
        focusedBorder: _borderTextField(),
        border: _borderTextField(),
        enabledBorder: _borderTextField(),
        hintText: hintText,
        hintStyle: hintStyle());

InputBorder _borderTextField() => OutlineInputBorder(
      borderRadius: BorderRadius.circular(200),
      borderSide: BorderSide(
          width: 0, style: BorderStyle.solid, color: R.color.dark_white),
    );

TextStyle inputTextStyle() =>
    TextStyle(fontSize: 16, color: R.color.dark_black);

TextStyle hintStyle() => TextStyle(fontSize: 16, color: R.color.gray);

GradientButton button(
        {text: String,
        Function onPressed,
        double height = 16,
        double width = 200}) =>
    GradientButton(
      increaseHeightBy: height,
      increaseWidthBy: width,
      child: Text(
        text,
      ),
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      callback: onPressed,
      gradient: BlueGradient(),
      shadowColor: Colors.black,
    );

InputDecoration inputDecoration({hintText: String}) => InputDecoration(
    contentPadding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    focusedBorder: _borderTextField(),
    border: _borderTextField(),
    enabledBorder: _borderTextField(),
    hintText: hintText,
    hintStyle: TextStyle(fontSize: 16, color: R.color.gray));

Widget ButtonBackGrey(BuildContext context) => IconButton(
    icon: SvgPicture.asset(R.image.ic_back_grey),
    onPressed: () {
      Navigator.of(context).pop();
    });

Widget ButtonBackWhite(BuildContext context) => IconButton(
    icon: SvgPicture.asset(R.image.ic_back_white),
    onPressed: () {
      Navigator.of(context).pop();
    });

Widget TitleAppBarBlack({String title}) => Text(
      title,
      style: TextStyle(
          fontSize: 18, color: R.color.black, fontWeight: FontWeight.w600),
    );

Widget TitleAppBarWhite({String title}) => Text(
      title,
      style: TextStyle(
          fontSize: 18, color: Colors.white, fontWeight: FontWeight.w600),
    );

Widget ButtonSkip({BuildContext context, Function onPressed}) => Center(
      child: IconButton(
          icon: Text(
            "Skip",
            style: TextStyle(fontSize: 16, color: R.color.blue),
          ),
          onPressed: onPressed),
    );

Widget InputWidget(
        {String hint,
        String text = '',
        double bottom = 0,
        double top = 0,
        Function onTap}) =>
    Padding(
      padding: EdgeInsets.only(bottom: bottom, top: top),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          child: Text(
            text.isEmpty ? hint : text,
            style: text.isEmpty ? hintStyle() : inputTextStyle(),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            border: Border.all(
              width: 1,
              color: R.color.dark_white,
            ),
          ),
          padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
        ),
      ),
    );

Widget MainAppBar(
        {BuildContext context,
        Widget leading,
        Widget title,
        List<Widget> actions,
        Widget bottom}) =>
    PreferredSize(
        child: Container(
          padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
          child: Stack(
            children: <Widget>[
              Positioned(
                child: leading == null ? Container() : leading,
                left: 0,
              ),
              Center(
                child: title == null
                    ? Container()
                    : Padding(
                        padding: EdgeInsets.only(left: 50, right: 20),
                        child: title,
                      ),
              ),
              Positioned(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: actions == null ? [] : actions,
                ),
                right: 0,
              )
            ],
          ),
          decoration: BoxDecoration(gradient: BlueGradient()),
        ),
        preferredSize: Size(MediaQuery.of(context).size.width, 50.0));

Widget CustomCircleAvatar(
        {double size = 50, Widget child, BoxDecoration decoration}) =>
    Container(
      width: size,
      height: size,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50 / 2),
        child: child,
      ),
      decoration: decoration,
    );

Gradient BlueGradient() => LinearGradient(
    colors: [R.color.blue, R.color.light_blue],
    begin: Alignment.bottomLeft,
    end: Alignment.centerRight);

BoxDecoration ShadowDecorationWhite() => BoxDecoration(
      color: R.color.white,
      borderRadius: BorderRadius.circular(8),
      boxShadow: [
        BoxShadow(
            color: Color(0xFF000000).withOpacity(0.1),
            blurRadius: 8,
            spreadRadius: -5,
            offset: Offset(0, 2))
      ],
    );

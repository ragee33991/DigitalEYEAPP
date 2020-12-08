import 'package:circular_check_box/circular_check_box.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:digital_eye_app/generated/i18n.dart';
import 'package:digital_eye_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


import 'package:provider/provider.dart';
import '../../main.dart';
import 'signin_page_model.dart';

class SignInPage extends StatelessWidget {
  static Widget ProviderPage() {
    return ChangeNotifierProvider<SignInPageModel>(
      create: (context) => SignInPageModel(),
      child: SignInPage(),
    );
  }

  static SignInPageModel of(BuildContext context) =>
      Provider.of<SignInPageModel>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(left: 36, right: 36, bottom: 30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      child: Text(
                        S.of(context).title_sign_in.toUpperCase(),
                        style:
                        TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                      ),
                      margin: EdgeInsets.only(bottom: 30),
                    ),
                    Container(
                      child: TextFormField(
                        focusNode: SignInPage.of(context).focusUsername,
                        style: inputTextStyle(),
                        textInputAction: TextInputAction.next,
                        obscureText: false,
                        decoration: inputImageDecoration(
                          hintText: S.of(context).hint_input_username,
                          image: R.image.ic_user,
                        ),
                        onFieldSubmitted: (value) {
                          SignInPage.of(context).nextFocus(
                              context,
                              SignInPage.of(context).focusUsername,
                              SignInPage.of(context).focusPassword);
                        },
                      ),
                      margin: EdgeInsets.only(bottom: 20),
                    ),
                    TextFormField(
                      focusNode: SignInPage.of(context).focusPassword,
                      style: inputTextStyle(),
                      textInputAction: TextInputAction.done,
                      obscureText: true,
                      decoration: inputImageDecoration(
                        hintText: S.of(context).hint_input_password,
                        image: R.image.ic_password,
                      ),
                      onFieldSubmitted: (value) {
                        SignInPage.of(context).closeFocus(
                            context, SignInPage.of(context).focusPassword);
                      },
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        CircularCheckBox(
                          value:
                          Provider.of<SignInPageModel>(context).isRemembered,
                          onChanged: (value) {
                            Provider.of<SignInPageModel>(context)
                                .updateRemember();
                          },
                          activeColor: Colors.blue,
                        ),
                        Text(
                          S.of(context).btn_remember_me,
                          style: TextStyle(color: R.color.gray, fontSize: 14),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        InkWell(
                          child: Container(
                            child: SvgPicture.asset(R.image.ic_forgot_pass),
                            decoration: BoxDecoration(boxShadow: [
                              BoxShadow(
                                blurRadius: 10,
                                spreadRadius: -4,
                                offset: Offset(
                                  0,
                                  0,
                                ),
                              )
                            ]),
                          ),
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(RouterName.FORGOT_PASSWORD);
                          },
                        )
                      ],
                    ),
                    Container(
                      child: button(
                          text: S.of(context).btn_sign_in.toUpperCase(),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (contextTrans) => MyHomePage()),
                              ModalRoute.withName(RouterName.MAIN),
                            );
                          }),
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                    ),
                    button(
                        text: S.of(context).btn_sign_in_facebook.toUpperCase(),
                        onPressed: () {}),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    S.of(context).lbl_dont_have_account,
                    style: TextStyle(fontSize: 16, color: R.color.gray),
                  ),
                  InkWell(
                    child: Text(
                      S.of(context).btn_sign_up.toUpperCase(),
                      style: TextStyle(fontSize: 16, color: R.color.blue),
                    ),
                    onTap: () {
                      Navigator.of(context).pushNamed(RouterName.SIGN_UP);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

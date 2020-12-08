import 'package:flutter/material.dart';
import 'package:digital_eye_app/Helper/Constant.dart';

import 'package:digital_eye_app/Localization/app_translations.dart';

import 'OnBoardingComonView.dart';

void main() => runApp(new OnBoardingDoctor());

class OnBoardingDoctor extends StatefulWidget {
  @override
  _OnBoardingDoctorState createState() => _OnBoardingDoctorState();
}

class _OnBoardingDoctorState extends State<OnBoardingDoctor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: setLocalView(
      AppImage.onBoardImg1,
      AppTranslations.of(context).text(AppTitle.onBoardTitle1),
      AppTranslations.of(context).text(AppString.onBoard1Descript),
    ));
  }
}

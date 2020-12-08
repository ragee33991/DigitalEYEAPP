import 'package:flutter/material.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';

import 'OnBoardingComonView.dart';

void main() => runApp(new OnBoardingMedicine());

class OnBoardingMedicine extends StatefulWidget {
  @override
  _OnBoardingMedicineState createState() => _OnBoardingMedicineState();
}

class _OnBoardingMedicineState extends State<OnBoardingMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: setLocalView(
      AppImage.onBoardImg2,
      AppTranslations.of(context).text(AppTitle.onBoardTitle2),
      AppTranslations.of(context).text(AppString.onBoard2Descript),
    ));
  }
}

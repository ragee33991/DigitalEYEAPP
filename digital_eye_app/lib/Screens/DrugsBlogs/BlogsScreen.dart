import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';

import '../../globals.dart';
import 'FoodBlog.dart';
import 'LifeStyle.dart';

void main() => runApp(new DrugsBlogsScreen(firebaseId));

class DrugsBlogsScreen extends StatefulWidget {
  final String firebaseId;

  DrugsBlogsScreen(this.firebaseId);

  @override
  _DrugsBlogsScreenState createState() => _DrugsBlogsScreenState();
}

class _DrugsBlogsScreenState extends State<DrugsBlogsScreen> {
  AppTranslationsDelegate _newLocaleDelegate;
  @override
  void initState() {
    super.initState();
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 1,
        initialIndex: 0,
        child: Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
            title: setHeaderTitle(
                AppTranslations.of(context).text(AppTitle.drawerBlogs),
                Colors.white),
            backgroundColor: AppColor.themeColor,
            elevation: 1.0,
            bottom: TabBar(
              indicatorColor: Colors.red,
              tabs: <Widget>[
                Tab(
                  text: ",",
                ),
              ],
            ),
            actions: setCommonCartNitificationView(context),
          ),
          body: TabBarView(
            children: <Widget>[LifeStyle()],
          ),
          drawer: SharedManager.shared
              .setDrawer(context, PersonalInfo.name, PersonalInfo.email),
        ),
      ),
      routes: {
        '/DrugsBlogsScreen': (BuildContext context) =>
            DrugsBlogsScreen(RouterName.id.toString())
      },
      theme: SharedManager.shared.getThemeType(),
      localizationsDelegates: [
        _newLocaleDelegate,
        //provides localised strings
        GlobalMaterialLocalizations.delegate,
        //provides RTL support
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [SharedManager.shared.language],
    );
  }

  //This is for localization
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

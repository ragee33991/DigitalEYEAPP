import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/DrugsBlogs/BlogsScreen.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/DashBoard/Dashboard.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/DoctorList/DoctorList.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/Indicators/TestIndicators.dart';
import 'package:digital_eye_app/Screens/TabBarScreens/UserProfile/UserProfile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';

import '../../../globals.dart';

void main() => runApp(new TabBarScreen(firebaseId));

class TabBarScreen extends StatefulWidget {
  final String firebaseId;

  TabBarScreen(this.firebaseId);

  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  bool isButtonClick = false;
  List<Widget> listScreen = [
    DashboardScreen(firebaseId),
    DoctorsList(),
    DrugsBlogsScreen(firebaseId),
    TestIndicators(),
    UserProfile(),
  ];

  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    SharedManager.shared.isOnboarding = true;
    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          body: listScreen[SharedManager.shared.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: SharedManager.shared.currentIndex,
              onTap: onTabTapped,
              items: [
                new BottomNavigationBarItem(
                  icon: Icon(
                    Icons.home,
                  ),
                  activeIcon: Icon(
                    Icons.home,
                  ),
                  label: AppTranslations.of(context).text(AppTitle.drawerHome),
                ),
                new BottomNavigationBarItem(
                  icon: Icon(Icons.camera_alt),
                  label: "Scanner",
                ),
                new BottomNavigationBarItem(
                  icon: Icon(
                    Icons.grain,
                    color: Colors.white.withAlpha(0),
                  ),
                  label: AppTranslations.of(context).text(AppTitle.drawerBlogs),
                ),
                new BottomNavigationBarItem(
                  icon: Icon(Icons.grain),
                  label: AppTranslations.of(context)
                      .text(AppTitle.drawerIndicators),
                ),
                new BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label:
                      AppTranslations.of(context).text(AppTitle.drawerProfile),
                ),
              ]),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            child: new Icon(
              Icons.speaker_group,
              color: isButtonClick ? Colors.blue : Colors.black,
            ),
            onPressed: () {
              setState(() {
                isButtonClick = true;
                SharedManager.shared.currentIndex = 2;
              });
            },
            backgroundColor: Colors.grey[300],
          ),
        ),
        localizationsDelegates: [
          _newLocaleDelegate,
          //provides localised strings
          GlobalMaterialLocalizations.delegate,
          //provides RTL support
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [SharedManager.shared.language],
        routes: {'/TabBar': (BuildContext context) => TabBarScreen(firebaseId)},
        theme: SharedManager.shared.getThemeType());
  }

  void onTabTapped(int index) {
    setState(() {
      if (index != 2) {
        isButtonClick = false;
        SharedManager.shared.currentIndex = index;
      } else {
        SharedManager.shared.currentIndex = index;
      }
    });
  }

  //This is for localization
  void onLocaleChange(Locale locale) {
    setState(() {
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }
}

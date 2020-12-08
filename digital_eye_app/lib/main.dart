import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Screens/Notifications/store/AppState.dart';
import 'Screens/Notifications/store/store.dart';
import 'Screens/Notifications/utils/notificationHelper.dart';
import 'dart:async' show Future;
import 'dart:io' show File;
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;

import 'package:flutter/cupertino.dart';
import 'Localization/app_translations_delegate.dart';
import 'Notifications/notification_service.dart';
import 'Notifications/schedule_notifications.dart';
import 'Screens/OnBoarding/OnBoardingAppointment.dart';
import 'Screens/OnBoarding/OnBoardingDoctors.dart';
import 'Screens/OnBoarding/OnBoardingMedicine.dart';
import 'globals.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Helper/Constant.dart';
import 'Helper/SharedManager.dart';
import 'Localization/application.dart';
import 'Screens/LoginPage/LoginPage.dart';
import 'Screens/TabBarScreens/DoctorList/camera_preview_scanner.dart';
import 'Screens/contanst/contanst.dart';
import 'Screens/create_account/create_account_page.dart';
import 'Screens/create_account_birthday/create_account_birthday_page.dart';
import 'Screens/create_account_fullname/create_account_fullname_page.dart';
import 'Screens/create_account_gender/create_account_gender_page.dart';
import 'Screens/create_account_weight/create_account_weight_page.dart';
import 'Screens/forgot_password/forgot_password_page.dart';
import 'dart:async';
import 'dart:ui';
import 'package:path_provider/path_provider.dart';

final df = new DateFormat('dd-MM-yyyy hh:mm a');

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;
Store<AppState> store;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initStore();
  store = getStore();
  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  await initNotifications(flutterLocalNotificationsPlugin);
  requestIOSPermissions(flutterLocalNotificationsPlugin);
  RouterName.store = store;

  SharedPreferences.getInstance().then((prefs) async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    prefrenceObjects = prefs;
    runApp(LaunchingApp());
  });
}

class LaunchingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print("error");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Digital Eye APP',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: new MyHomePage(),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<MyHomePage> {
  final _controller = new PageController();
  static const _kDuration = const Duration(milliseconds: 300);
  static const _kCurve = Curves.ease;
  final _kArrowColor = Colors.black;
  final List<Widget> _pages = <Widget>[LoginPage()];

  AppTranslationsDelegate _newLocaleDelegate;

  @override
  void initState() {
    super.initState();
    NotificationService.instance.start();

    print("hello + shownotification");

    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;

    notifications = ScheduleNotifications(
      'your channel id',
      'your other channel name',
      'your other channel description',
    );

    notifications.init(onSelectNotification: (String payload) async {
      if (payload == null || payload.trim().isEmpty) return null;
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondScreen(payload)),
      );
      return;
    });

    notifications.getNotificationAppLaunchDetails().then((details) {
      notificationAppLaunchDetails = details;
    });
  }

  ScheduleNotifications notifications;

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          body: new IconTheme(
            data: new IconThemeData(color: _kArrowColor),
            child: SharedManager.shared.isOnboarding
                ? LoginPage()
                : Container(
                    color: Colors.white,
                    child: new Stack(
                      children: <Widget>[
                        new PageView.builder(
                          physics: new AlwaysScrollableScrollPhysics(),
                          controller: _controller,
                          itemCount: _pages.length,
                          itemBuilder: (BuildContext context, int index) {
                            return _pages[index % _pages.length];
                          },
                        ),
                        new Positioned(
                          bottom: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: new Container(
                            color: AppColor.themeColor.withOpacity(0.0),
                            padding: const EdgeInsets.all(20.0),
                            child: new Center(
                              child: new DotsIndicator(
                                controller: _controller,
                                itemCount: _pages.length,
                                color: AppColor.themeColor,
                                onPageSelected: (int page) {
                                  _controller.animateToPage(
                                    page,
                                    duration: _kDuration,
                                    curve: _kCurve,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
        routes: {
          '/$CameraPreviewScanner': (BuildContext context) =>
              CameraPreviewScanner(),
          RouterName.FORGOT_PASSWORD: (context) =>
              ForgotPasswordPage.ProviderPage(),
          RouterName.CREATE_ACCOUNT: (context) =>
              CreateAccountPage.ProviderPage(),
          RouterName.CREATE_ACCOUNT_BIRTHDAY: (context) =>
              CreateAccountBirthdayPage.ProviderPage(),
          RouterName.CREATE_ACCOUNT_GENDER: (context) =>
              CreateAccountGenderPage.ProviderPage(),
          RouterName.CREATE_ACCOUNT_FULLNAME: (context) =>
              CreateAccountFullnamePage.ProviderPage(),
          //RouterName.CREATE_ACCOUNT_HEIGHT: (context) =>
          //   CreateAccountHeightPage.ProviderPage(),

          '/MyHomePage': (BuildContext context) => MyHomePage()
        },
        theme: SharedManager.shared.getThemeType());
  }

  //This is for localization
  void onLocaleChange(Locale locale) {
    setState(() {
      notifications.show(
        id: 0,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        title: 'Questionnaire',
        body: 'It is time for the next Questionnaire',
        payload: 'item x',
      );
      _newLocaleDelegate = AppTranslationsDelegate(newLocale: locale);
    });
  }

  Future<void> _showNotification() async {
    print("hello inside showNotification");

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
            'your channel id', 'your channel name', 'your channel description',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Questionnaire',
        'Your next Questionnaire awaits!', platformChannelSpecifics,
        payload: 'item x');
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }

  Future<String> _downloadAndSaveFile(String url, String fileName) async {
    var directory = await getApplicationDocumentsDirectory();
    var filePath = '${directory.path}/$fileName';
    var response = await http.get(url);
    var file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

class _PaddedRaisedButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onPressed;

  const _PaddedRaisedButton({
    @required this.buttonText,
    @required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 8.0),
      child: RaisedButton(child: Text(buttonText), onPressed: onPressed),
    );
  }
}

class SecondScreen extends StatefulWidget {
  SecondScreen(this.payload);

  final String payload;

  @override
  State<StatefulWidget> createState() => SecondScreenState();
}

class SecondScreenState extends State<SecondScreen> {
  String _payload;
  @override
  void initState() {
    super.initState();
    _payload = widget.payload;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen with payload: ${(_payload ?? '')}'),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

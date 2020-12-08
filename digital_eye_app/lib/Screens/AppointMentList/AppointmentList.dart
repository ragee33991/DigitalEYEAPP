import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_eye_app/Helper/CommonWidgets/CommonWidgets.dart';
import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Helper/SharedManager.dart';
import 'package:digital_eye_app/Localization/app_translations.dart';
import 'package:digital_eye_app/Localization/app_translations_delegate.dart';
import 'package:digital_eye_app/Localization/application.dart';
import 'package:digital_eye_app/Screens/contanst/contanst.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:table_calendar/table_calendar.dart';

void main() => runApp(new AppointMentList());

class AppointMentList extends StatefulWidget {
  @override
  _AppointMentListState createState() => _AppointMentListState();
}

class _AppointMentListState extends State<AppointMentList>
    with TickerProviderStateMixin {
  final Map<DateTime, List> _holidays = {
    DateTime(2019, 1, 1): ['New Year\'s Day'],
    DateTime(2019, 1, 6): ['Epiphany'],
    DateTime(2019, 2, 14): ['Valentine\'s Day'],
    DateTime(2019, 4, 21): ['Easter Sunday'],
    DateTime(2019, 4, 22): ['Easter Monday'],
  };

  Map<DateTime, List> _events;
  List selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;
  final firestoreInstance = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();

    firestoreInstance
        .collection("users")
        .doc(RouterName.id)
        .collection("Quiz")
        .get()
        .then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print("KKKKK" + result.get('quizTitle'));

        result.get('quizTitle');
      });
    });

    // final _selectedDay22 = DateTime.parse(_selectedDay2.toString());
    _events = {
      //   _selectedDay22.add(Duration(hours:2, minutes:3, seconds:2)): ['Event'],
    };

    selectedEvents = _events[_selectedDay] ?? [];
    _calendarController = CalendarController();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();

    _newLocaleDelegate = AppTranslationsDelegate(newLocale: null);
    application.onLocaleChanged = onLocaleChange;
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events, _) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
  }

  _setColenderView() {
    return new Container(
      child: new Material(
        color: AppColor.themeColor,
        elevation: 10.0,
        child: TableCalendar(
          calendarController: _calendarController,
          events: _events,
          holidays: _holidays,
          startingDayOfWeek: StartingDayOfWeek.monday,
          daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: TextStyle(color: Colors.white),
              weekendStyle: TextStyle(color: Colors.white)),
          calendarStyle: CalendarStyle(
            weekdayStyle: TextStyle(
              color: Colors.white,
            ),
            weekendStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            selectedColor: Colors.deepOrange[400],
            todayColor: Colors.orange[400],
            markersColor: Colors.black,
            outsideDaysVisible: false,
          ),
          headerStyle: HeaderStyle(
            formatButtonTextStyle:
                TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
            formatButtonDecoration: BoxDecoration(
              color: Colors.deepOrange,
              borderRadius: BorderRadius.circular(16.0),
            ),
          ),
          onDaySelected: _onDaySelected,
          onVisibleDaysChanged: _onVisibleDaysChanged,
        ),
      ),
    );
  }

  _setAppointmentList() {
    return Container(
      color: Colors.grey[100],
      height: 550,
      padding: new EdgeInsets.all(20),
      child: new ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        itemCount: 1,
        itemBuilder: (context, index) {
          return getAppointmentListView(index, context);
        },
      ),
    );
  }

  AppTranslationsDelegate _newLocaleDelegate;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        body: new Container(
          color: Colors.grey[100],
          child: ListView(
            children: <Widget>[
              _setColenderView(),
              SizedBox(
                height: 20,
              ),
              _setAppointmentList()
            ],
          ),
        ),
        appBar: new AppBar(
          centerTitle: true,
          // title: setHeaderTitle(AppTranslations.of(context).text(AppTitle.appTitle),Colors.white),
          title: setHeaderTitle(
              AppTranslations.of(context).text(AppTitle.dashbAppointment),
              Colors.white),
          backgroundColor: AppColor.themeColor,
          elevation: 1.0,
          leading: new IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
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

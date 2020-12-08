import 'dart:io';

import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Screens/Notifications/actions/actions.dart';
import 'package:digital_eye_app/Screens/Notifications/models/Reminder.dart';
import 'package:digital_eye_app/Screens/Notifications/store/store.dart';
import 'package:digital_eye_app/Screens/Notifications/utils/notificationHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';

const String playMusic = 'Daily Questionnaire Reminder';
const String lookAfterPlants = 'Look after plants';
const String walk = '5 min walk';
const String drinkingWater = 'Drink some water';
const String custom = 'Time to take a Questionnaire';

const remindersIcons = {
  playMusic: Icons.access_alarm_sharp,
  lookAfterPlants: Icons.local_florist,
  walk: Icons.directions_walk,
  drinkingWater: Icons.local_drink,
  custom: Icons.access_time_rounded,
};

class ReminderAlertBuilder extends StatefulWidget {
  ReminderAlertBuilder({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReminderAlertBuilderState createState() => _ReminderAlertBuilderState();
}

class _ReminderAlertBuilderState extends State<ReminderAlertBuilder> {
  bool playMusicReminder = false;
  bool lookAfterPlantsReminder = false;
  bool walkFor5minReminder = false;
  bool drinkSomeWaterReminder = false;
  bool customReminder = false;
  bool customReminder2 = false;

  double margin = Platform.isIOS ? 10 : 5;

  TimeOfDay customNotificationTime;
  TimeOfDay customNotificationTime2;

  @override
  Widget build(BuildContext context) {
    _prepareState();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        /*
        children: <Widget>[
          RaisedButton(
            child: Text('Clear'),
            color: AppColor.themeColor,
            onPressed: _showMaterialDialog1,
            textColor: Colors.white,
          ),
        ],
        */
      ),
    );
  }

  _showMaterialDialog() {
    TimeOfDay roomBooked =
        TimeOfDay.fromDateTime(DateTime.parse('2020-11-25 01:50:04Z'));
    TimeOfDay roomBooked2 = TimeOfDay.fromDateTime(
        DateTime.parse('2020-11-25 24:50:04Z')
            .add(Duration(hours: 0, minutes: 5))); // 4:30pm
// 4:30pm

    getStore().dispatch(ClearReminderAction());
    TimeOfDay releaseTime = TimeOfDay(hour: 23, minute: 29); // 3:00pm
    //TimeOfDay roomBooked = TimeOfDay.fromDateTime(DateTime.parse(releaseTime.toString()).add(Duration(hours:0,minutes: 5))); // 4:30pm
    setState(() {
      customNotificationTime = releaseTime;
      customReminder = true;
      //  customNotificationTime2 = roomBooked2;
    });
    _configureCustomReminder(true);
    //  _configureCustomReminder2(true);
  }

  _showMaterialDialog1() {
    getStore().dispatch(ClearReminderAction());

    //getStore().dispatch(RemoveReminderAction(custom));
  }

  _prepareState() {
    List<Reminder> list = getStore().state.remindersState.reminders;

    list.forEach((item) {
      switch (item.name) {
        case playMusic:
          playMusicReminder = true;
          break;
        case lookAfterPlants:
          lookAfterPlantsReminder = true;
          break;
        case walk:
          walkFor5minReminder = true;
          break;
        case drinkingWater:
          drinkSomeWaterReminder = true;
          break;
        case custom:
          customReminder = true;
          break;
        default:
          return;
      }
    });
  }

  void _configurePlayMusic(bool value) {
    if (value) {
      getStore().dispatch(SetReminderAction(
          time: new DateTime.now().toIso8601String(),
          name: playMusic,
          repeat: RepeatInterval.daily));

      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '0',
          playMusic, RepeatInterval.daily);
    } else {
      turnOffNotificationById(flutterLocalNotificationsPlugin, 0);
      getStore().dispatch(RemoveReminderAction(playMusic));
    }
  }

  void _configureLookAfterPlants(bool value) {
    if (value) {
      getStore().dispatch(SetReminderAction(
          time: new DateTime.now().toIso8601String(),
          name: lookAfterPlants,
          repeat: RepeatInterval.daily));
      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '1',
          lookAfterPlants, RepeatInterval.weekly);
    } else {
      getStore().dispatch(RemoveReminderAction(lookAfterPlants));
      turnOffNotificationById(flutterLocalNotificationsPlugin, 1);
    }
  }

  void _configure5minWalk(bool value) {
    if (value) {
      getStore().dispatch(SetReminderAction(
          time: new DateTime.now().toIso8601String(),
          name: walk,
          repeat: RepeatInterval.hourly));
      scheduleNotificationPeriodically(
          flutterLocalNotificationsPlugin, '2', walk, RepeatInterval.hourly);
    } else {
      getStore().dispatch(RemoveReminderAction(walk));
      turnOffNotificationById(flutterLocalNotificationsPlugin, 2);
    }
  }

  void _configureDrinkSomeWater(bool value) {
    if (value) {
      getStore().dispatch(SetReminderAction(
          time: new DateTime.now().toIso8601String(),
          name: drinkingWater,
          repeat: RepeatInterval.everyMinute));
      scheduleNotificationPeriodically(flutterLocalNotificationsPlugin, '3',
          drinkingWater, RepeatInterval.everyMinute);
    } else {
      getStore().dispatch(RemoveReminderAction(drinkingWater));
      turnOffNotificationById(flutterLocalNotificationsPlugin, 3);
    }
  }

  void _configureCustomReminder(bool value) {
    if (customNotificationTime != null) {
      if (value) {
        var now = new DateTime.now();
        var notificationTime = new DateTime(now.year, now.month, now.day,
            customNotificationTime.hour, customNotificationTime.minute);

        getStore().dispatch(SetReminderAction(
            time: notificationTime.toIso8601String(),
            name: custom,
            repeat: RepeatInterval.daily));

        scheduleNotification(
            flutterLocalNotificationsPlugin, '3', custom, notificationTime);
      } else {
        getStore().dispatch(RemoveReminderAction(custom));
        turnOffNotificationById(flutterLocalNotificationsPlugin, 4);
      }
    }
  }

  void _configureCustomReminder2(bool value) {
    if (customNotificationTime2 != null) {
      if (value) {
        var now = new DateTime.now();
        var notificationTime = new DateTime(now.year, now.month, now.day,
            customNotificationTime2.hour, customNotificationTime2.minute);

        getStore().dispatch(SetReminderAction(
            time: notificationTime.toIso8601String(),
            name: custom,
            repeat: RepeatInterval.daily));

        scheduleNotification(
            flutterLocalNotificationsPlugin, '3', custom, notificationTime);
      } else {
        getStore().dispatch(RemoveReminderAction(custom));
        turnOffNotificationById(flutterLocalNotificationsPlugin, 4);
      }
    }
  }
}

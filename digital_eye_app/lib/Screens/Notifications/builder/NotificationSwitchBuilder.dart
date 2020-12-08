import 'package:digital_eye_app/Helper/Constant.dart';
import 'package:digital_eye_app/Screens/Notifications/utils/notificationHelper.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';


class NotificationSwitchBuilder extends StatefulWidget {
  @override
  _NotificationSwitchBuilderState createState() =>
      _NotificationSwitchBuilderState();
}

class _NotificationSwitchBuilderState extends State<NotificationSwitchBuilder> {
  bool isSwitched = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Center(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
            Switch(
              value: isSwitched,
              onChanged: (value) {
                if (!value) {
                  turnOffNotification(flutterLocalNotificationsPlugin);
                }
                setState(() {
                  isSwitched = value;
                });
              },
              activeTrackColor: Colors.lightBlueAccent,
              activeColor: AppColor.themeColor,
            ),
            Text(
              'Turn off',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ])),
    );
  }
}

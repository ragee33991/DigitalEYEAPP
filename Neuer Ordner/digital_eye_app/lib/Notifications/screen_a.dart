import 'dart:async';

import 'package:digital_eye_app/Notifications/screen_b.dart';
import 'package:flutter/material.dart';

import 'notification_bloc.dart';


class ScreenA extends StatefulWidget {
  @override
  _ScreenAState createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> {

  StreamSubscription<Map> _notificationSubscription;



  @override
  void dispose() {
    _notificationSubscription.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _notificationSubscription = NotificationsBloc.instance.notificationStream
        .listen(_performActionOnNotification);
  }

  _performActionOnNotification(Map<String, dynamic> message) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ScreenB(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Screen A'),
      ),
      body: Center(
        child: Text(
          'Welcome to Screen A',
        ),
      ),
    );
  }
}
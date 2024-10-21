import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:dring/mainScreen.dart';
import 'package:dring/timerService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() {
  AwesomeNotifications().initialize(
    null, 
    [
      NotificationChannel(
        channelKey: 'basic_channel', 
        channelName: 'Basic Notifications', 
        channelDescription: 'Basic notifications channel'
      ),
    ],
    debug: true,
    );
  runApp(
    ChangeNotifierProvider<TimerService>(
      create: (_) => TimerService(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: null,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
    return const MainScreen();
  }
}
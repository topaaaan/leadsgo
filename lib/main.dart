import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:leadsgo_apps/Screens/launcher/launcher_screen.dart';
import 'package:leadsgo_apps/Screens/provider/approval_disbursment_agen_provider.dart';
import 'package:leadsgo_apps/Screens/provider/approval_disbursment_provider.dart';
import 'package:leadsgo_apps/Screens/provider/approval_interaction_provider.dart';
import 'package:leadsgo_apps/Screens/provider/disbursment_akad_provider.dart';
import 'package:leadsgo_apps/Screens/provider/filter_report_disbursment_provider.dart';
import 'package:leadsgo_apps/Screens/provider/filter_report_disbursment_sl_provider.dart';
import 'package:leadsgo_apps/Screens/provider/filter_report_interaction_provider.dart';
import 'package:leadsgo_apps/Screens/provider/filter_report_interaction_sl_provider.dart';
import 'package:leadsgo_apps/Screens/provider/history_income_provider.dart';
import 'package:leadsgo_apps/Screens/provider/modul_provider.dart';
import 'package:leadsgo_apps/Screens/provider/pipeline_akad_provider.dart';
import 'package:leadsgo_apps/Screens/provider/pipeline_provider.dart';
import 'package:leadsgo_apps/Screens/provider/pipeline_submit_provider.dart';
import 'package:leadsgo_apps/Screens/provider/planning_interaction_provider.dart';
import 'package:leadsgo_apps/Screens/provider/report_disbursment_sl_provider.dart';
import 'package:leadsgo_apps/Screens/provider/report_interaction_sl_provider.dart';
import 'package:leadsgo_apps/Screens/provider/report_marketing_sl_provider.dart';
import 'package:leadsgo_apps/Screens/provider/report_pipeline_sl_provider.dart';
import 'package:leadsgo_apps/Screens/provider/simulation_kp74_provider.dart';
import 'package:leadsgo_apps/constants.dart';
import 'package:leadsgo_apps/Screens/provider/simulation_provider.dart';
import 'package:provider/provider.dart';

import 'Screens/provider/disbursment_provider.dart';
import 'Screens/provider/disbursmentA_provider.dart';
import 'Screens/provider/disbursmentC_provider.dart';
import 'Screens/provider/disbursmentCPlus_provider.dart';
import 'Screens/provider/leaderboard_provider.dart';
import 'Screens/provider/interaction_provider.dart';
import 'Screens/provider/planning_provider.dart';
import 'Screens/provider/report_disbursment_provider.dart';
import 'Screens/provider/report_interaction_provider.dart';
import 'Screens/provider/berita_provider.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel channel;

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // status bar color
    statusBarBrightness: Brightness.dark, //status bar brigtness
    statusBarIconBrightness: Brightness.dark, //status barIcon Brightness
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true // optional: set false to disable printing logs to console
      );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyApp createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channel.description,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigation to page
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => SimulationProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DisbursmentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DisbursmentAProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DisbursmentCProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DisbursmentCPlusProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => LeaderboardProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => InteractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportInteractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportDisbursmentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PlanningProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PlanningInteractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => HistoryIncomeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ModulProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PipelineProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ApprovalInteractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ApprovalDisbursmentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ApprovalDisbursmentAgenProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterReportInteractionProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterReportDisbursmentProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportDisbursmentSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportInteractionSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterReportInteractionSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => FilterReportDisbursmentSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportMarketingSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ReportPipelineSlProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => SimulationKp74Provider(),
          ),
          ChangeNotifierProvider(
            create: (context) => DisbursmentAkadProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => BeritaProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PipelineSubmitProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => PipelineAkadProvider(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LeadsGo',
          theme: ThemeData(
            primaryColor: leadsGoColor,
            scaffoldBackgroundColor: Colors.white,
            bottomSheetTheme: BottomSheetThemeData(
                backgroundColor: Colors.black.withOpacity(0)),
          ),
          // theme: ThemeData(
          //   primarySwatch: Colors.blue,
          // ),
          initialRoute: '/home',
          home: LauncherScreen(),
        ));
  }
}

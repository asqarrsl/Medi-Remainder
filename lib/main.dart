import 'package:flutter/material.dart';
import 'package:flutter_project/app_config.dart';
import 'package:flutter_project/db/dbHelper.dart';
import 'package:flutter_project/my_theme.dart';
import 'package:flutter_project/screen/splash.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Dbhelper.initDb();
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.app_name,
      theme: ThemeData(
        primaryColor: MyTheme.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        accentColor: MyTheme.accent_color,
        // the below code is getting fonts from http
        // textTheme: GoogleFonts.sourceSansProTextTheme(textTheme).copyWith(
        //   bodyText1: GoogleFonts.sourceSansPro(textStyle: textTheme.bodyText1),
        //   bodyText2: GoogleFonts.sourceSansPro(
        //       textStyle: textTheme.bodyText2, fontSize: 12),
        // ),
      ),
      home: Splash(),
    );
  }
}
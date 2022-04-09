import 'package:flutter/material.dart';
<<<<<<< HEAD
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
=======
import 'package:flutter/services.dart';
import 'package:medi_remainder/app_config.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/screen/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';


int? initScreen;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black.withOpacity(0.05),
      statusBarColor: Colors.black.withOpacity(0.05),
      statusBarIconBrightness: Brightness.dark));
>>>>>>> main
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
      home: Splash(initScreen: initScreen),
    );
  }
}
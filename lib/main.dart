import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/services.dart';
import 'package:medi_remainder/app_config.dart';
import 'package:medi_remainder/db/dbHelper.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/screen/splash.dart';

int? initScreen;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Dbhelper.initDb();
  await GetStorage.init();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  initScreen = preferences.getInt('initScreen');
  await preferences.setInt('initScreen', 1);
  runApp(MyApp());
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black.withOpacity(0.05),
      statusBarColor: Colors.black.withOpacity(0.05),
      statusBarIconBrightness: Brightness.dark));
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
      ),
      home: Splash(),
    );
  }
}
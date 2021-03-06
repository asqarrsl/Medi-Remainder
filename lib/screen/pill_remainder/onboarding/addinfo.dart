import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/screen/main.dart';
import 'package:medi_remainder/screen/pill_remainder/platform_flat_button.dart';
import 'package:medi_remainder/screen/pill_remainder/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class AddInfo extends StatefulWidget {
  AddInfo({Key? key, this.title, this.showBackButton = false})
      : super(key: key);

  final String? title;
  bool showBackButton;
  @override
  _AddInfoState createState() => _AddInfoState();
}

class _AddInfoState extends State<AddInfo> {
  File? _image;
  String? _imagepath;
  String? name;
  String? phoneno;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final Snackbar snackbar = Snackbar();
  @override
  void initState() {
    super.initState();
    LoadImage();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final focus = FocusScope.of(context);
    final deviceHeight = MediaQuery.of(context).size.height - 60.0;

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: buildAppBar(statusBarHeight, context),
      backgroundColor: MyTheme.bg_color,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Choose a Profile Picture",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(color: Colors.black87),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  GestureDetector(
                    onTap: () async {
                      chooseImage();
                      SaveImage(_image!.path);
                      LoadImage();
                    },
                    child: _imagepath != null
                        ? CircleAvatar(
                            backgroundImage: FileImage(File(_imagepath!)),
                            radius: 50.0,
                          )
                        : _image != null
                            ? CircleAvatar(
                                radius: 50.0,
                                backgroundImage: FileImage(_image!))
                            : const CircleAvatar(
                                radius: 50.0,
                                backgroundImage: AssetImage(
                                    'assets/onboard/temp_profile.png')),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            const Divider(
              thickness: 2,
              height: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nameController,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    labelText: "Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(width: 0.5, color: Colors.grey)),
                  ),
                  maxLines: 1,
                  onSubmitted: (val) => focus.nextFocus(),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: phoneController,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0),
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    labelText: "Phone No",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide:
                            const BorderSide(width: 0.5, color: Colors.grey)),
                  ),
                  maxLines: 1,
                  keyboardType: TextInputType.phone,
                  onSubmitted: (val) => focus.unfocus(),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: deviceHeight * 0.09,
                  width: double.infinity,
                  child: PlatformFlatButton(
                    handler: () async => addInfo(),
                    color: MyTheme.accent_color,
                    buttonChild: const Text(
                      "Start",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 17.0),
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future addInfo() async {
    if (nameController.text.isEmpty || phoneController.text.isEmpty) {
      if (nameController.text.isEmpty) {
        snackbar.showSnack("Check your Name", _scaffoldKey, null);
      }
      // if (double.tryParse(phoneController.text) == null) {
      //   snackbar.showSnack("Enter a Valid Number", _scaffoldKey, null);
      // }
      if (phoneController.text.isEmpty) {
        snackbar.showSnack("Check your Number", _scaffoldKey, null);
      }
    } else {
      SharedPreferences saveName = await SharedPreferences.getInstance();
      saveName.setString("username", nameController.text);
      SharedPreferences savePhone = await SharedPreferences.getInstance();
      savePhone.setString("phone", phoneController.text);
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (c, a1, a2) => Main(),
          // transitionDuration: Duration(milliseconds: 350),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            const begin = Offset(0.0, 1.0);
            const end = Offset.zero;
            final tween = Tween(begin: begin, end: end);
            final offsetAnimation = animation.drive(tween);
            return SlideTransition(
              position: offsetAnimation,
              child: child,
            );
          },
        ),
      );
    }
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          widget.title!.isNotEmpty
              ? Text(
                  widget.title!,
                  style: TextStyle(color: MyTheme.accent_color),
                )
              : Image.asset(
                  'assets/logo/appbar_icon.png',
                  fit: BoxFit.fitWidth,
                  height: 40,
                )
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        widget.showBackButton
            ? InkWell(
                onTap: () {
                  // ToastComponent.showDialog("Coming soon", context,
                  //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
                },
                child: Visibility(
                  visible: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 12.0),
                    child: Icon(Icons.settings_outlined),
                  ),
                ),
              )
            : InkWell(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return Address();
                  // }));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 12.0, horizontal: 12.0),
                  child: Icon(
                    Icons.settings,
                    color: MyTheme.accent_color,
                  ),
                ),
              ),
      ],
    );
  }

  void chooseImage() async {
    var image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image as File?;
    });
  }

  void SaveImage(path) async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    saveImage.setString("imagepath", path);
  }

  void LoadImage() async {
    SharedPreferences saveImage = await SharedPreferences.getInstance();
    setState(() {
      _imagepath = saveImage.getString("imagepath");
    });
  }
}

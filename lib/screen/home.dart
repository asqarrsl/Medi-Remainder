import 'package:flutter/material.dart';
import 'package:medi_remainder/Models/medicine-model.dart';
import 'package:medi_remainder/Services/medicine-service.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/screen/view-all-medicines.dart';
import 'package:medi_remainder/uisections/drawer.dart';
import 'package:uuid/uuid.dart';

class Home extends StatefulWidget {
  Home({Key? key, this.title, this.showBackButton = false}) : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var medicineNameController = TextEditingController();
  var medicineQuantityController = TextEditingController();
  var medicinePriceController = TextEditingController();
  bool _validateName = false;
  bool _validatePrice = false;
  bool _validateQuantity = false;
  var medicineService= MedicineService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentSlider = 0;
  ScrollController? _featuredProductScrollController;


  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: buildAppBar(statusBarHeight, context),
      drawer: MainDrawer(),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(),
              Container(
                height: 80,
              )
            ]),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      leading: GestureDetector(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: widget.showBackButton
            ? Builder(
                builder: (context) => IconButton(
                  icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              )
            : Builder(
                builder: (context) => Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 0.0),
                  child: Container(
                    child: Image.asset(
                      'assets/icons/hamburger.png',
                      height: 16,
                      //color: MyTheme.dark_grey,
                      color: MyTheme.dark_grey,
                    ),
                  ),
                ),
              ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/logo/appbar_icon.png',
            fit: BoxFit.fitWidth,
            height: 40,
          )
        ],
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        InkWell(
          onTap: () {
            // ToastComponent.showDialog("Coming soon", context,
            //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Icon(Icons.settings_outlined),
          ),
        ),
      ],
    );
  }

}

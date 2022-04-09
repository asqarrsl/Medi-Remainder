import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:medi_remainder/Models/medicine-model.dart';
import 'package:medi_remainder/Services/medicine-service.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/screen/view-all-medicines.dart';
import 'package:medi_remainder/uisections/drawer.dart';
import 'package:uuid/uuid.dart';
=======
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/uisections/drawer.dart';
>>>>>>> main

class Home extends StatefulWidget {
  Home({Key? key, this.title, this.showBackButton = false}) : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
<<<<<<< HEAD
  var medicineNameController = TextEditingController();
  var medicineQuantityController = TextEditingController();
  var medicinePriceController = TextEditingController();
  bool _validateName = false;
  bool _validatePrice = false;
  bool _validateQuantity = false;
  var medicineService= MedicineService();
=======
>>>>>>> main
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _currentSlider = 0;
  ScrollController? _featuredProductScrollController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // In initState()
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: buildAppBar(statusBarHeight, context),
      drawer: MainDrawer(),
<<<<<<< HEAD
      // body: SingleChildScrollView(
      //   child: Container(
      //     padding: const EdgeInsets.all(16.0),
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         const Text(
      //           'Add New Medicine',
      //           style: TextStyle(
      //               fontSize: 20,
      //               color: Colors.teal,
      //               fontWeight: FontWeight.w500),
      //         ),
      //         const SizedBox(
      //           height: 20.0,
      //         ),
      //         TextField(
      //             controller: medicineNameController,
      //             decoration: InputDecoration(
      //               border: const OutlineInputBorder(),
      //               hintText: 'Enter Medicine Name',
      //               labelText: 'Name',
      //               errorText:
      //               _validateName ? 'Name Value Can\'t Be Empty' : null,
      //             )),
      //         const SizedBox(
      //           height: 20.0,
      //         ),
      //         TextField(
      //             controller: medicinePriceController,
      //             decoration: InputDecoration(
      //               border: const OutlineInputBorder(),
      //               hintText: 'Enter Medicine Price',
      //               labelText: 'Price',
      //               errorText: _validatePrice
      //                   ? 'Price Value Can\'t Be Empty'
      //                   : null,
      //             )),
      //         const SizedBox(
      //           height: 20.0,
      //         ),
      //         TextField(
      //             controller: medicineQuantityController,
      //             decoration: InputDecoration(
      //               border: const OutlineInputBorder(),
      //               hintText: 'Enter In Stock Quantity',
      //               labelText: 'Quantity',
      //               errorText: _validateQuantity
      //                   ? 'Quantity Value Can\'t Be Empty'
      //                   : null,
      //             )),
      //         const SizedBox(
      //           height: 20.0,
      //         ),
      //         Row(
      //           children: [
      //             TextButton(
      //                 style: TextButton.styleFrom(
      //                     primary: Colors.white,
      //                     backgroundColor: Colors.teal,
      //                     textStyle: const TextStyle(fontSize: 15)),
      //                 onPressed: () async {
      //                   setState(() {
      //                     medicineNameController.text.isEmpty
      //                         ? _validateName = true
      //                         : _validateName = false;
      //                     medicinePriceController.text.isEmpty
      //                         ? _validatePrice = true
      //                         : _validatePrice = false;
      //                     medicineQuantityController.text.isEmpty
      //                         ? _validateQuantity = true
      //                         : _validateQuantity = false;
      //
      //                   });
      //                   if (_validateName == false &&
      //                       _validatePrice == false &&
      //                       _validateQuantity == false) {
      //                     // print("Good Data Can Save");
      //                     var medicine = MedicineModel();
      //                     // medicine.id=const Uuid().v1();
      //                     medicine.medicineName = medicineNameController.text;
      //                     medicine.inStockQuantity = medicineQuantityController.text;
      //                     medicine.medicinePrice = medicinePriceController.text;
      //                     await medicineService.saveMedicine(medicine);
      //                     //var result=await medicineService.saveMedicine(medicine);
      //                     // Navigator.pop(context,result);
      //                   }
      //                 },
      //                 child: const Text('Save Details')),
      //             const SizedBox(
      //               width: 10.0,
      //             ),
      //             TextButton(
      //                 style: TextButton.styleFrom(
      //                     primary: Colors.white,
      //                     backgroundColor: Colors.red,
      //                     textStyle: const TextStyle(fontSize: 15)),
      //                 onPressed: () {
      //                   Navigator.push(context, MaterialPageRoute(builder: (context)=> const ViewAllMedicines()));
      //                   medicineNameController.text = '';
      //                   medicinePriceController.text = '';
      //                   medicineQuantityController.text = '';
      //                 },
      //                 child: const Text('Clear Details'))
      //           ],
      //         )
      //       ],
      //     ),
      //   ),
      // ),
      // body: CustomScrollView(
      //   slivers: <Widget>[
      //     SliverList(
      //       delegate: SliverChildListDelegate([
      //         Container(),
      //         // Padding(
      //         //   padding: const EdgeInsets.fromLTRB(
      //         //     8.0,
      //         //     16.0,
      //         //     8.0,
      //         //     0.0,
      //         //   ),
      //         //   child: buildHomeCarouselSlider(context),
      //         // ),
      //         // Padding(
      //         //   padding: const EdgeInsets.fromLTRB(
      //         //     8.0,
      //         //     16.0,
      //         //     8.0,
      //         //     0.0,
      //         //   ),
      //         //   child: buildHomeMenuRow(context),
      //         // ),
      //     //   ]),
      //     // ),
      //     // SliverList(
      //     //   delegate: SliverChildListDelegate([
      //     //     Padding(
      //     //       padding: const EdgeInsets.fromLTRB(
      //     //         16.0,
      //     //         16.0,
      //     //         8.0,
      //     //         0.0,
      //     //       ),
      //     //       child: Column(
      //     //         crossAxisAlignment: CrossAxisAlignment.start,
      //     //         children: [
      //     //           Text(
      //     //             "Featured Categories",
      //     //             style: TextStyle(
      //     //               fontSize: 16,
      //     //             ),
      //     //           ),
      //     //         ],
      //     //       ),
      //     //     ),
      //     //   ]),
      //     // ),
      //     // SliverToBoxAdapter(
      //     //   child: Padding(
      //     //     padding: const EdgeInsets.fromLTRB(
      //     //       16.0,
      //     //       16.0,
      //     //       0.0,
      //     //       0.0,
      //     //     ),
      //     //     child: SizedBox(
      //     //       height: 154,
      //     //       child: buildHomeFeaturedCategories(context),
      //     //     ),
      //     //   ),
      //     // ),
      //     // SliverList(
      //     //   delegate: SliverChildListDelegate([
      //     //     Padding(
      //     //       padding: const EdgeInsets.fromLTRB(
      //     //         16.0,
      //     //         16.0,
      //     //         8.0,
      //     //         0.0,
      //     //       ),
      //     //       child: Column(
      //     //         crossAxisAlignment: CrossAxisAlignment.start,
      //     //         children: [
      //     //           Text(
      //     //             "Featured Products",
      //     //             style: TextStyle(fontSize: 16),
      //     //           ),
      //     //         ],
      //     //       ),
      //     //     ),
      //         // SingleChildScrollView(
      //         //   child: Column(
      //         //     children: [
      //               // Padding(
      //               //   padding: const EdgeInsets.fromLTRB(
      //               //     4.0,
      //               //     16.0,
      //               //     8.0,
      //               //     0.0,
      //               //   ),
      //               //   child: buildHomeFeaturedProducts(context),
      //               // ),
      //         //     ],
      //         //   ),
      //         // ),
      //         Container(
      //           height: 80,
      //         )
      //       ]),
      //     ),
      //   ],
      // ),
=======
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
>>>>>>> main
    );
  }

  AppBar buildAppBar(double statusBarHeight, BuildContext context) {
    return AppBar(
      backgroundColor : Colors.white,
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
<<<<<<< HEAD
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: Text('Medi- Reminder',style: const TextStyle(color: Colors.black),),
            //  margin: const EdgeInsets.only(left: 75),
            // child: Image.asset(
            //   'assets/logo/appbar_icon.png',
            //   fit: BoxFit.fitWidth,
            //   height: 40,
            // ),
          )
        ],
=======
      title: SingleChildScrollView( 
        child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(left: 75),
            child: Image.asset(
              'assets/logo/appbar_icon.png',
              fit: BoxFit.fitWidth,
              height: 40,
            ),
          )
        ],
      )
>>>>>>> main
      ),
      elevation: 0.0,
      titleSpacing: 0,
      actions: <Widget>[
        InkWell(
          onTap: () {
            // ToastComponent.showDialog("Coming soon", context,
            //     gravity: Toast.CENTER, duration: Toast.LENGTH_LONG);
          },
          child: Visibility(
            visible: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
              child: Image.asset(
                'assets/bell.png',
                height: 16,
                color: MyTheme.dark_grey,
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) {
            //   return Address();
            // }));
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
            child: Icon(
              Icons.settings,
              color: MyTheme.accent_color,
            ),
          ),
        ),
      ],
    );
  }
}

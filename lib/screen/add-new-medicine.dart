import 'package:flutter/material.dart';
import 'package:medi_remainder/my_theme.dart';
import '../Models/medicine-model.dart';
import '../Services/medicine-service.dart';

class AddNewMedicine extends StatefulWidget {
  const AddNewMedicine({Key? key}) : super(key: key);

  @override
  _AddNewMedicineState createState() => _AddNewMedicineState();
}

class _AddNewMedicineState extends State<AddNewMedicine> {
  var medicineNameController = TextEditingController();
  var medicineTypeController = TextEditingController();
  var medicineAmountController = TextEditingController();
  bool _validateName = false;
  bool _validatePrice = false;
  bool _validateQuantity = false;
  var medicineService = MedicineService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(statusBarHeight, context),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add Medicine',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              TextField(
                  controller: medicineNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Medicine Name',
                    labelText: 'Name',
                    errorText:
                        _validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: medicineTypeController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Medicine Type',
                    labelText: 'Type',
                    errorText: _validateQuantity
                        ? 'Medicine Type Value Can\'t Be Empty'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: medicineAmountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Medicine Amount',
                    labelText: 'Amount',
                    errorText:
                        _validatePrice ? 'Amount Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.teal,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () async {
                        setState(() {
                          medicineNameController.text.isEmpty
                              ? _validateName = true
                              : _validateName = false;
                          medicineAmountController.text.isEmpty
                              ? _validatePrice = true
                              : _validatePrice = false;
                          medicineTypeController.text.isEmpty
                              ? _validateQuantity = true
                              : _validateQuantity = false;
                        });
                        if (_validateName == false &&
                            _validatePrice == false &&
                            _validateQuantity == false) {
                          // print("Good Data Can Save");
                          var medicine = MedicineModel();
                          // medicine.id=const Uuid().v1();
                          medicine.medicineName = medicineNameController.text;
                          medicine.medicineType = medicineTypeController.text;
                          medicine.medicineAmount =
                              medicineAmountController.text;
                          var result =
                              await medicineService.saveMedicine(medicine);
                          print(medicine.medicineMap());
                          //var result=await medicineService.saveMedicine(medicine);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Save Details')),
                  const SizedBox(
                    width: 10.0,
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize: 15)),
                      onPressed: () {
                        medicineNameController.text = '';
                        medicineAmountController.text = '';
                        medicineTypeController.text = '';
                      },
                      child: const Text('Clear Details'))
                ],
              )
            ],
          ),
        ),
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
          child: Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.arrow_back, color: MyTheme.dark_grey),
              onPressed: () => Navigator.of(context).pop(),
            ),
          )),
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

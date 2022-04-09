import 'package:flutter/material.dart';
import 'package:medi_remainder/Models/medicine-model.dart';
import 'package:medi_remainder/Services/medicine-service.dart';
import 'package:medi_remainder/my_theme.dart';
import 'package:medi_remainder/screen/add-new-medicine.dart';
import 'package:medi_remainder/screen/edit-medicine.dart';
import 'package:medi_remainder/screen/view-medicine.dart';

class ViewAllMedicines extends StatefulWidget {
  ViewAllMedicines({Key? key, this.title, this.showBackButton = false}) : super(key: key);

  final String? title;
  bool showBackButton;

  @override
  State<ViewAllMedicines> createState() => _ViewAllMedicinesState();
}

class _ViewAllMedicinesState extends State<ViewAllMedicines> {
  late List<MedicineModel> medicineList = [];
  final medicineService = MedicineService();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  getAllUserDetails() async {
    var users = await medicineService.readMedicines();
    medicineList = [];
    users.forEach((medicine) {
      setState(() {
        var medicineModel = MedicineModel();
        medicineModel.id = medicine['id'];
        medicineModel.medicineName = medicine['medicineName'];
        medicineModel.medicineAmount = medicine['medicineAmount'];
        medicineModel.medicineType = medicine['medicineType'];
        medicineList.add(medicineModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, medicineId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: () async {
                    var result =
                        await medicineService.deleteMedicine(medicineId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      _showSuccessSnackBar('Medicine Detail Deleted Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      key: _scaffoldKey,
      appBar: buildAppBar(statusBarHeight, context),
      body: ListView.builder(
          itemCount: medicineList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewMedicine(
                                medicine: medicineList[index],
                              )));
                },
                leading: const Icon(Icons.person),
                title: Text(medicineList[index].medicineName ?? ''),
                subtitle: Text(medicineList[index].medicineAmount ?? ''),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EditMedicine(
                                        medicine: medicineList[index],
                                      ))).then((data) {
                            if (data != null) {
                              getAllUserDetails();
                              _showSuccessSnackBar(
                                  'Medicine Detail Updated Success');
                            }
                          });
                        },
                        icon: const Icon(
                          Icons.edit,
                          color: Colors.teal,
                        )),
                    IconButton(
                        onPressed: () {
                          _deleteFormDialog(context, medicineList[index].id);
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ))
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AddNewMedicine())).then((data) {
              if (data != null) {
                getAllUserDetails();
                _showSuccessSnackBar('Medicine Detail Added Success');
              }
            });
          },
          child: const Icon(Icons.add),
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

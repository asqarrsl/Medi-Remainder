import 'package:flutter/material.dart';
import 'package:flutter_project/Models/medicine-model.dart';
import 'package:flutter_project/Services/medicine-service.dart';

class EditMedicine extends StatefulWidget {
  final MedicineModel medicine;
  const EditMedicine({Key? key, required this.medicine}) : super(key: key);

  @override
  State<EditMedicine> createState() => _EditMedicineState();
}

class _EditMedicineState extends State<EditMedicine> {
  var medicineNameController = TextEditingController();
  var medicineAmountController = TextEditingController();
  var medicineTypeController = TextEditingController();
  bool validateName = false;
  bool validatePrice = false;
  bool validateQuantity = false;
  var medicineService = MedicineService();

  @override
  void initState() {
    setState(() {
      medicineNameController.text = widget.medicine.medicineName ?? '';
      medicineAmountController.text = widget.medicine.medicineAmount ?? '';
      medicineTypeController.text = widget.medicine.medicineType ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Medicine Item"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Edit Medicine Item',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.teal,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: medicineNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Medicine Name',
                    labelText: 'Name',
                    errorText:
                        validateName ? 'Name Value Can\'t Be Empty' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: medicineAmountController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Amount',
                    labelText: 'Amount',
                    errorText:
                        validatePrice ? 'Amount Value Can\'t Be Empty' : null,
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
                    errorText: validateQuantity
                        ? 'Medicine Type Value Can\'t Be Empty'
                        : null,
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
                              ? validateName = true
                              : validateName = false;
                          medicineAmountController.text.isEmpty
                              ? validatePrice = true
                              : validatePrice = false;
                          medicineTypeController.text.isEmpty
                              ? validateQuantity = true
                              : validateQuantity = false;
                        });
                        if (validateName == false &&
                            validatePrice == false &&
                            validateQuantity == false) {
                          // print("Good Data Can Save");
                          var medicine = MedicineModel();
                          medicine.id = widget.medicine.id;
                          medicine.medicineName = medicineNameController.text;
                          medicine.medicineAmount =
                              medicineAmountController.text;
                          medicine.medicineType = medicineTypeController.text;
                          var result =
                              await medicineService.updateMedicine(medicine);
                          Navigator.pop(context, result);
                        }
                      },
                      child: const Text('Update Details')),
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
                        medicineTypeController.text = '';
                        medicineAmountController.text = '';
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
}

import 'package:flutter/material.dart';
import 'package:flutter_project/models/health.dart';
import 'package:flutter_project/services/db_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:flutter_project/list_screen.dart';

class AddEditHealthPage extends StatefulWidget {
  const AddEditHealthPage({Key? key, this.model, this.isEditMode = false})
      : super(key: key);
  final HealthModel? model;
  final bool isEditMode;

  @override
  State<AddEditHealthPage> createState() => _AddEditHealthPageState();
}

class _AddEditHealthPageState extends State<AddEditHealthPage> {
  DateTime date = DateTime(2022, 4, 6);
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  late HealthModel model;
  //*  if need list start with here 26:40
  late DBservice dBservice;

  @override
  void initState() {
    super.initState();
    dBservice = DBservice();
    //* check date time while running the app
    model =
        HealthModel(savedate: "0000", weight: 0.00, height: 0.00, bmi: 0.00);
    if (widget.isEditMode) {
      model = this.widget.model!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        automaticallyImplyLeading: true,
        title: Text(widget.isEditMode ? 'Edit health Data' : 'Add Health Data'),
      ),
      body: Form(
        key: globalKey,
        child: _formUI(),
      ),
      bottomNavigationBar: SizedBox(
        height: 110,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ListPage()));
              },
              child: FormHelper.submitButton(
                "save",
                () {
                  if (validateAndSave()) {
                    print(model.toJson());
                    if (widget.isEditMode) {
                      dBservice.updateHealth(model).then(
                        (value) {
                          FormHelper.showSimpleAlertDialog(
                            context,
                            "SQFLITE",
                            "Sucessfully Saved",
                            "OK",
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    } else {
                      dBservice.addHealth(model).then(
                        (value) {
                          FormHelper.showSimpleAlertDialog(
                            context,
                            "SQFLITE",
                            "Sucessfully Added",
                            "OK",
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    }
                  }
                },
                borderRadius: 40,
                btnColor: Color.fromARGB(255, 71, 235, 76),
              ),
            ),
            FormHelper.submitButton("Cancel", () {}),
          ],
        ),
      ),
    );
  }

  _formUI() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "height",
              "Height",
              "Enter your Height",
              (onValidate) {
                if (onValidate.isEmpty) {
                  return "* Required";
                }
              },
              (onSaved) {
                model.height = double.parse(onSaved.trim());
              },
              //initialValue: model.height != null? model.height.toString():"",
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.text_fields),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIconPaddingLeft: 10,
              isNumeric: true,
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: FormHelper.inputFieldWidgetWithLabel(
                    context,
                    "weight",
                    "Weight",
                    "Enter your Weight",
                    (onValidate) {
                      if (onValidate.isEmpty) {
                        return "* Required";
                      }
                    },
                    (onSaved) {
                      model.weight = double.parse(onSaved.trim());
                    },
                    showPrefixIcon: true,
                    prefixIcon: const Icon(Icons.text_fields),
                    borderRadius: 10,
                    contentPadding: 15,
                    fontSize: 14,
                    labelFontSize: 14,
                    paddingLeft: 0,
                    paddingRight: 0,
                    prefixIconPaddingLeft: 10,
                    isNumeric: true,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: FormHelper.inputFieldWidgetWithLabel(
                    context,
                    "bmi",
                    "BMI",
                    "Enter your BMI",
                    (onValidate) {
                      if (onValidate.isEmpty) {
                        return "* Required";
                      }
                    },
                    (onSaved) {
                      //* Not used to string method beeacuse it is in date and time format
                      model.bmi = double.parse(onSaved.trim());
                    },
                    showPrefixIcon: true,
                    prefixIcon: const Icon(Icons.speed),
                    borderRadius: 10,
                    contentPadding: 15,
                    fontSize: 14,
                    labelFontSize: 14,
                    paddingLeft: 0,
                    paddingRight: 0,
                    prefixIconPaddingLeft: 10,
                    isNumeric: true,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Flexible(
                  flex: 1,
                  child: FormHelper.inputFieldWidgetWithLabel(
                    context,
                    "sdate",
                    "Date",
                    "Enter your date",
                    (onValidate) {
                      if (onValidate.isEmpty) {
                        return "* Required";
                      }
                    },
                    (onSaved) {
                      //* Not used to string method beeacuse it is in date and time format

                      model.savedate = onSaved.toString().trim();
                    },
                    showPrefixIcon: true,
                    prefixIcon: const Icon(Icons.calendar_month),
                    borderRadius: 10,
                    contentPadding: 15,
                    fontSize: 14,
                    labelFontSize: 14,
                    paddingLeft: 0,
                    paddingRight: 0,
                    prefixIconPaddingLeft: 10,
                    isNumeric: true,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  bool validateAndSave() {
    final form = globalKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

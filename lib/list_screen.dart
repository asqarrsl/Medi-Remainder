import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medi_remainder/models/health.dart';
import 'package:medi_remainder/services/db_service.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import 'add_edit_health.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  DBservice dBservice = DBservice();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Health Records"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: FormHelper.submitButton(
                "add data",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddEditHealthPage(),
                    ),
                  );
                },
                borderRadius: 10,
                btnColor: Colors.blue,
                borderColor: Colors.lightBlue,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            _fetchData(),
          ],
        ),
      ),
    );
  }

  _fetchData() {
    return FutureBuilder<List<HealthModel>>(
        future: dBservice.getHealth(),
        builder:
            (BuildContext context, AsyncSnapshot<List<HealthModel>> health) {
          if (health.hasData) {
            return _buildDataTable(health.data!);
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  _buildDataTable(List<HealthModel> model) {
    return ListUtils.buildDataTable(
      context,
      ["Date", "Weight", "Height", "BMI"],
      [
        "savedate",
        "weight",
        "height",
        "bmi",
      ],
      false,
      0,
      model,
      (HealthModel data) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AddEditHealthPage(
              isEditMode: true,
              model: data,
            ),
          ),
        );
      },
      (HealthModel data) {
        return showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("SQLITE CRUD"),
                content: const Text("Do you want to delete?"),
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      FormHelper.submitButton("Yes", () {
                        dBservice.deleteHealth(data).then((value) {
                          setState(() {
                            Navigator.of(context).pop();
                          });
                        });
                      },
                          width: 100,
                          borderRadius: 5,
                          btnColor: Colors.green,
                          borderColor: Colors.green),
                      const SizedBox(
                        width: 5,
                      ),
                      FormHelper.submitButton("No", () {
                        Navigator.of(context).pop();
                      },
                          width: 100,
                          borderRadius: 5,
                          btnColor: Colors.red,
                          borderColor: Colors.red)
                    ],
                  )
                ],
              );
            });
      },
      headingRowColor: Colors.greenAccent,
      isScrollable: true,
      columnTextFontSize: 15,
      columnTextBold: false,
      columnSpacing: 50,
      onSort: (columnIndex, columName, asc) {},
    );
  }
}

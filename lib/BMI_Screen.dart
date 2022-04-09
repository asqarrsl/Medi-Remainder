import 'package:flutter/material.dart';
import 'package:medi_remainder/add_edit_health.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({Key? key}) : super(key: key);

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  // Declaring variables
  final TextEditingController _heightControlller = TextEditingController();
  final TextEditingController _weightControlller = TextEditingController();

  //other variable declaration
  double _bmiResult = 0;
  String txtRes = '';
  String _imgRes = '';

  bool colortype = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      //make the color
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
            stops: const [
              0.2,
              0.32,
              0.6,
              0.75,
              0.85,
              0.92,
            ],
            colors: (colortype == false)
                ? [
                    Colors.white,
                    Colors.red.shade50,
                    Colors.red.shade300,
                    Colors.red.shade400,
                    Colors.red.shade600,
                    Colors.red.shade800,
                  ]
                : [
                    Colors.white,
                    Colors.blue.shade50,
                    Colors.blue.shade300,
                    Colors.blue.shade400,
                    Colors.blue.shade600,
                    Colors.blue.shade800,
                  ]
                  ),
      ),

      //color: Color.fromARGB(255, 240, 130, 255),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            'BMI Calculator',
            style: TextStyle(
                fontSize: 26, fontWeight: FontWeight.w600, color: Colors.black),
            textAlign: TextAlign.center,
          ),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            physics:
                BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //* height
                  Container(
                    width: 145,
                    child: TextField(
                      controller: _heightControlller,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueGrey.shade800),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Height(m)",
                          hintStyle: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )
                          ),
                    ),
                  ),
                  //*weight
                  Container(
                    width: 150,
                    child: TextField(
                      controller: _weightControlller,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                          color: Colors.blueGrey.shade800),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          hintText: "Weight(kg)",
                          hintStyle: TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          )),
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  double _height = double.parse(_heightControlller.text);
                  double _weight = double.parse(_weightControlller.text);

                  setState(() {
                    // Logic for BMI calculation
                    _bmiResult = _weight / (_height * _height);

                    if (_bmiResult > 30) {
                      txtRes =
                          "Your weight is very much higher than the normal.\n Risk at diseases like diabetes and heart diseases.\nBring down it with more exercises,";
                      _imgRes = 'assets/obey.png';
                      colortype = false;
                    } else if (_bmiResult >= 25 && _bmiResult <= 29.9) {
                      txtRes =
                          "Your weight is more than the normal.Do some exercises and keep correct dietary practices";
                      _imgRes = 'assets/overweight.png';
                      colortype = true;
                    } else if (_bmiResult >= 23 && _bmiResult <= 24.9) {
                      txtRes =
                          "Your weight is  normal but Do some exercises and keep correct dietary practices";
                      _imgRes = 'assets/RiskOverweight.png';
                      colortype = true;
                    } else if (_bmiResult >= 18.5 && _bmiResult <= 22.9) {
                      txtRes =
                          "Your weight is normal . Maintain your weight with adequate exercises.";
                      _imgRes = 'assets/Normal.png';
                      colortype = true;
                    } else {
                      txtRes =
                          "your body is less than the normal recommended weight. you need to eat more nutritious food with adequate exercises";
                      _imgRes = 'assets/underweight.png';
                      colortype = false;
                    }
                  });
                },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Calculate',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
              GestureDetector(
                      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => AddEditHealthPage()));
      },
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Save',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.white),
                  ),
                ),
              ),
              // Display rhe results

              Text(
                _bmiResult.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 70,
                  color: Colors.grey.shade900,
                ),
              ),

              Visibility(
                visible: txtRes.isNotEmpty,
                child: Text(
                  txtRes,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade800,
                    fontStyle: FontStyle.italic,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Visibility(
                visible: _imgRes.isNotEmpty,
                child: Image(
                  image: AssetImage(_imgRes)),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

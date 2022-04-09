import 'package:flutter/material.dart';
import 'BMI_Screen.dart';

class WidgetCard extends StatelessWidget {
  const WidgetCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Health Tracker')),
      ),
      bottomNavigationBar: BottomNavigationBar(items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "A"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "B"),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: "C")
      ]),
      body: GestureDetector(
        onTap: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BMIScreen()));
        },
        child: Stack(alignment: Alignment.topRight, children: [
          Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment(
                        0.9, 0.0), // 10% of the width, so there are ten blinds.
                    colors: <Color>[
                      Color.fromARGB(255, 27, 156, 196),
                      Color.fromARGB(255, 16, 108, 214)
                    ], // red to yellow
                    tileMode:
                        TileMode.clamp, // repeats the gradient over the canvas
                  ),
                  borderRadius: BorderRadius.circular(48.0),
                  boxShadow: [
                    BoxShadow(
                        color:
                            Color.fromARGB(255, 27, 156, 196).withOpacity(0.3),
                        offset: Offset(0, 20),
                        blurRadius: 30.0),
                    BoxShadow(
                        color:
                            Color.fromARGB(255, 27, 156, 196).withOpacity(0.3),
                        offset: Offset(0, 20),
                        blurRadius: 30.0)
                  ]),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      top: 32.0,
                      left: 32.0,
                      right: 32.0,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Lets check the BMI",
                            style: TextStyle(color: Colors.white),
                            //need styles
                          ),
                          SizedBox(
                            height: 6.0,
                          ),
                          Text(
                            'BMI calcualtor',
                            style: TextStyle(color: Colors.white),
                          ),
                        ]),
                  ),
                  Expanded(
                      child: Image.asset(
                    'assets/bmi.png',
                    fit: BoxFit.cover,
                  ))
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 0.0),
            child: Container(
              child: Image.asset('assets/bmilogo2.png'),
              width: 60.0,
              height: 60.0,
              decoration: BoxDecoration(
                color: Color.fromARGB(0, 255, 255, 255),
                borderRadius: BorderRadius.circular(18.0),
                boxShadow: [
                  BoxShadow(
                      color: Color.fromARGB(155, 238, 235, 235),
                      offset: Offset(1, 0.1),
                      blurRadius: 20.0)
                ],
              ),
              padding: EdgeInsets.all(12.0),
            ),
          )
        ]),
      ),
    );
  }
}

@override
Widget build(BuildContext context) {
  return Stack(alignment: Alignment.topRight, children: [
    Padding(
      padding: EdgeInsets.only(top: 20.0),
      child: Container(
        width: 200,
        height: 200,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment(
                  0.9, 0.0), // 10% of the width, so there are ten blinds.
              colors: <Color>[
                Color.fromARGB(255, 27, 156, 196),
                Color.fromARGB(255, 16, 108, 214)
              ], // red to yellow
              tileMode: TileMode.clamp, // repeats the gradient over the canvas
            ),
            borderRadius: BorderRadius.circular(48.0),
            boxShadow: [
              BoxShadow(
                  color: Color.fromARGB(255, 27, 156, 196).withOpacity(0.3),
                  offset: Offset(0, 20),
                  blurRadius: 30.0),
              BoxShadow(
                  color: Color.fromARGB(255, 27, 156, 196).withOpacity(0.3),
                  offset: Offset(0, 20),
                  blurRadius: 30.0)
            ]),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 32.0,
                left: 32.0,
                right: 32.0,
              ),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "this is the text",
                      style: TextStyle(color: Colors.white),
                      //need styles
                    ),
                    SizedBox(
                      height: 6.0,
                    ),
                    Text(
                      'this is text 2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ]),
            ),
            Expanded(
                child: Image.asset(
              'assets/bmi.png',
              fit: BoxFit.cover,
            ))
          ],
        ),
      ),
    ),
    Padding(
      padding: EdgeInsets.only(right: 0.0),
      child: Container(
        child: Image.asset('assets/bmilogo2.png'),
        width: 60.0,
        height: 60.0,
        decoration: BoxDecoration(
          color: Color.fromARGB(0, 255, 255, 255),
          borderRadius: BorderRadius.circular(18.0),
          boxShadow: [
            BoxShadow(
                color: Color.fromARGB(155, 238, 235, 235),
                offset: Offset(1, 0.1),
                blurRadius: 20.0)
          ],
        ),
        padding: EdgeInsets.all(12.0),
      ),
    )
  ]);
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medi_remainder/models/appointment.dart';
import 'package:google_fonts/google_fonts.dart';

class AppointmentTile extends StatelessWidget {
  final Appointment? appointment;
  AppointmentTile(this.appointment);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: 
      EdgeInsets.symmetric(horizontal: 20),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 12),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color:_getBGClr(appointment?.color??0),

        ),
        child: Row(children: [
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                appointment?.title??"",
                style: GoogleFonts.lato(
                  textStyle:TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                  )
                ),
                SizedBox(
                  height: 12,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Colors.grey[200],
                      size:18,
                    ),
                    SizedBox(
                      width: 4,
                    ),
                    Text(
                      "${appointment!.startTime}-${appointment!.endTime}",
                      style: GoogleFonts.lato(
                        textStyle: 
                          TextStyle(
                            fontSize: 13,
                            color: Colors.grey[100]
                          ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  appointment?.name??"",
                  style: GoogleFonts.lato(
                    textStyle: TextStyle(
                      fontSize:15,
                      color: Colors.grey[200]
                    )
                  ),
                )
            ]
            ,)
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              height:60,
              width:0.5,
              color: Colors.grey[200]!.withOpacity(0.7),
            ),
            RotatedBox(
              quarterTurns: 3,
              child: Text(
                appointment!.isCompleted==1?"COMPLETED" : "TODO",
                style: GoogleFonts.lato(
                  textStyle: TextStyle(
                    fontSize:10,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
              ),
            ),
        ]),
      ),
    );
  }
}
_getBGClr(int num){
  switch(num){
    case 0:
      return Color.fromARGB(255, 11, 89, 223);
    case 1:
      return Colors.pink;
    case 2:
      return Colors.yellowAccent;
    default:
      return Color.fromARGB(255, 11, 89, 223); 
  }
}

import 'package:flutter_project/db/dbHelper.dart';
import 'package:get/get.dart';

import '../models/appointment.dart';

class AppointmentController extends GetxController{
  @override
  void onReady(){
    getAppointments();
    super.onReady();

  }  
  var appointmentList = <Appointment>[].obs;
  Future<int> addAppointment({Appointment? appointment}) async{
    return await Dbhelper.insert(appointment);
  }

  void getAppointments() async{
    List<Map<String, dynamic>> appointments = await Dbhelper.query();
    appointmentList.assignAll(appointments.map((data)=> new Appointment.fromJson(data)).toList());
  }

  void delete(Appointment appointment){
    Dbhelper.delete(appointment);
    
  }

  void markAppointmentCompleted(int id) async{
    await Dbhelper.update(id);
  }
}
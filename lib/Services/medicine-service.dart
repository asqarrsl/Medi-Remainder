

import 'package:flutter_project/Models/medicine-model.dart';

import '../Database/repository.dart';

class MedicineService
{
  late Repository _repository;
  MedicineService(){
    _repository = Repository();
  }
  //Save Medicine
  saveMedicine(MedicineModel medicineModel) async{
    return await _repository.insertData('mediciness', medicineModel.medicineMap());
  }
  //Read All Medicine
  readMedicines() async{
    return await _repository.readData('mediciness');
  }
  //Edit Medicine
  updateMedicine(MedicineModel medicineModel) async{
    return await _repository.updateData('mediciness', medicineModel.medicineMap());
  }

  //Delete medicine
  deleteMedicine(medicineId) async {
    return await _repository.deleteDataById('mediciness', medicineId);
  }

}
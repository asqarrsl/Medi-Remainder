class MedicineModel {
  String? medicineAmount;
  String? medicineName;
  int? id;
  String? medicineType;

  MedicineModel(
      {this.id, this.medicineType, this.medicineName, this.medicineAmount});

  medicineMap() {
    var mapping = <String, dynamic>{};
    mapping['id'] = id;
    mapping['medicineName'] = medicineName ?? '';
    mapping['medicineAmount'] = medicineAmount ?? '';
    mapping['medicineType'] = medicineType??'';
    return mapping;
  }
}

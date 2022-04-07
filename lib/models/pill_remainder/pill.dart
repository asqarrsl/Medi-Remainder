class Pill {
  int? id;
  String? name;
  String? amount;
  String? type;
  int? noOfWeeks;
  String? medicineType;
  int? time;
  int? notifyId;

  Pill(
      {this.id,
      this.noOfWeeks,
      this.time,
      this.amount,
      this.medicineType,
      this.name,
      this.type,
      this.notifyId});

  Map<String, dynamic> pillToMap() {
    Map<String, dynamic> map = {};
    map['id'] = id;
    map['amount'] = amount;
    map['noOfWeeks'] = noOfWeeks;
    map['type'] = type;
    map['name'] = name;
    map['notifyId'] = notifyId;
    map['medicineType'] = medicineType;
    map['time'] = time;
    return map;
  }

  Pill pillMapToObject(Map<String, dynamic> pillMap) {
    return Pill(
        id: pillMap['id'],
        time: pillMap['time'],
        type: pillMap['type'],
        amount: pillMap['amount'],
        medicineType: pillMap['medicineType'],
        noOfWeeks: pillMap['noOfWeeks'],
        name: pillMap['name'],
        notifyId: pillMap['notifyId']);
  }

  String get image{
    switch(medicineType){
      case "Syrup": return "assets/images/syrup.png"; break;
      case "Pill":return "assets/images/pills.png"; break;
      case "Capsule":return "assets/images/capsule.png"; break;
      case "Cream":return "assets/images/cream.png"; break;
      case "Drops":return "assets/images/drops.png"; break;
      case "Syringe":return "assets/images/syringe.png"; break;
      default : return "assets/images/pills.png"; break;
    }
  }
}

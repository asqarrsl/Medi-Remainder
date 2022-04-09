import 'package:medi_remainder/models/model.dart';

class HealthModel extends Model {
  static String table = "health_tbl";

  int? id;
  String? savedate;
  double? weight;
  double? height;
  double? bmi;

  HealthModel({this.id, this.savedate, this.weight, this.height, this.bmi});

  static HealthModel fromMap(Map<String, dynamic> json) {
    return HealthModel(
        id: json['id'],
        savedate: json['savedate'].toString(),
        weight: json['weight'],
        height: json['height'],
        bmi: json['bmi']);
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'id': id,
      'savedate': savedate,
      'weight': weight,
      'height': height,
      'bmi': bmi
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}

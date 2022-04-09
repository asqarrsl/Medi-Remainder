class Appointment{
  int? id;
  String? title;
  String? name;
  int? isCompleted;
  String? date;
  String? startTime;
  String? endTime;
  int? color;
  int? remind;

  Appointment({
    this.id,
    this.title,
    this.name,
    this.isCompleted,
    this.date,
    this.startTime,
    this.endTime,
    this.color,
    this.remind,

  });

  Appointment.fromJson(Map<String, dynamic> json){
      id = json['id'];
      title = json['title'];
      name = json['name'];
      isCompleted = json['isCompleted'];
      date = json['date'];
      startTime = json['startTime'];
      endTime = json['endTime'];
      color = json['color'];
      remind = json['remind'];
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['name'] = this.name;
    data['isCompleted'] = this.isCompleted;
    data['date'] = this.date;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['remind'] = this.remind;
    return data;
  }

}
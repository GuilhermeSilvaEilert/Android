import 'dart:ffi';

class Todo{

  Todo({required this.dateTime, required this.title,
    required this.preco, required this.total});

  Todo.fromJson(Map<String, dynamic> json)
    :title = json['title'],
     preco = json['preco'],
     total = json['total'],
     dateTime = DateTime.parse(json['datetime'],);

  String title;
  DateTime dateTime;
  String preco;
  String total;

  Map<String, dynamic> toJson(){
    return {
      'title':title,
      'datetime': dateTime.toIso8601String(),
      'preco':preco,
      'total':total,
    };
  }
}

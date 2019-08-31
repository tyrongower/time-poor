import 'dart:convert';

import 'package:time_poor_app/db/DbProvider.dart';

Project projectFromJson(String str) {
  final jsonData = json.decode(str);
  return Project.fromJson(jsonData);
}

String projectToJson(Project data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class Project {
  int id;
  String description;
  double hoursSpent;
  bool completed;

  Project({
    this.id,
    this.description,
    this.hoursSpent,
    this.completed,
  });

  factory Project.fromJson(Map<String, dynamic> json) => new Project(
    id: json["id"],
    description: json["description"],
    hoursSpent: json["hours_spent"],
    completed: json["completed"] == 1,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": description,
    "hours_spent": hoursSpent.toString(),
    "completed": completed,
  };



  static newProject(Project newClient) async {

    final db = await DBProvider.db.database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Project");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Project (id,description,hours_spent,completed)"
            " VALUES (?,?,?,?)",
        [id, newClient.description, newClient.hoursSpent, newClient.completed]);
    return raw;
  }


  static getAllProjects() async {
    final db = await DBProvider.db.database;
    var res = await db.query("Project");
    List<Project> list =
    res.isNotEmpty ?  res.map((c) => Project.fromJson(c)).toList() : [];
    return list;
  }

}
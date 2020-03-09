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
  int color;

  Project({
    this.id,
    this.description,
    this.hoursSpent,
    this.completed,
    this.color

  });

  factory Project.fromJson(Map<String, dynamic> json) => new Project(
        id: json["id"],
        description: json["description"],
        hoursSpent: json["hours_spent"],
        completed: json["completed"] == 1,
        color: json["color"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": description,
        "hours_spent": hoursSpent,
        "completed": completed,
        "color" : color
      };

  static newProject(Project newProject) async {
    final db = await DBProvider.db.database;
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Project");
    int id = table.first["id"];
    var raw = await db.rawInsert(
        "INSERT Into Project (id,description,hours_spent,completed,color)"
        " VALUES (?,?,?,?,?)",
        [
          id,
          newProject.description,
          newProject.hoursSpent,
          newProject.completed,
          newProject.color
        ]);
    return raw;
  }

  static deleteProject(Project project) async {
    final db = await DBProvider.db.database;
    await db.delete("Project", where: "id = ?", whereArgs: [project.id]);
  }

  static getAllProjects() async {
    final db = await DBProvider.db.database;
    var res = await db.query("Project");
    List<Project> list =
        res.isNotEmpty ? res.map((c) => Project.fromJson(c)).toList() : [];
    return list;
  }

  static updateProject(Project project) async {
    final db = await DBProvider.db.database;
    var res = await db.update("Project", project.toJson(),
        where: "id = ?", whereArgs: [project.id]);
    return res;
  }

  static void incrementHours(Project project, int i) async{
    final db = await DBProvider.db.database;
    await db.execute('update Project set hours_spent = hours_spent + ? where id =?',[i,project.id]);
  }
}

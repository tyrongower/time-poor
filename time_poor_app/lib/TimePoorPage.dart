import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_poor_app/db/models/ProjectModel.dart';

import 'Persistence.dart';



class TimePoor extends StatefulWidget {
  @override
  _TimePoorState createState() => _TimePoorState();
}

class _TimePoorState extends State<TimePoor> {
  List<Project> _projects = new List<Project>();
  loadProjects() async {
    _projects = await  Project.getAllProjects();
  }

  _TimePoorState(){
    loadProjects();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Log your time"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.alarm_off),
              onPressed: () {
                Project.newProject(new Project(
                  completed: false,
                  description: 'Project ' + _projects.length.toString(),
                  hoursSpent: 0
                ));

                setState(()  {
              loadProjects();
                });
              },
            )
          ],
        ),
        body: ListView.separated(
          itemBuilder: (context, index) {
            return Container(
                width: MediaQuery.of(context).size.width - 20,
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), color: Colors.red),
                child: Column(children: <Widget>[
                  Text(
                    _projects[index].description,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _projects[index].hoursSpent += 1;
                              debugPrint("Hello Up " +
                                  _projects[index].hoursSpent.toString());
                            });
                          },
                          child: Icon(
                            Icons.add,
                            size: 36,
                          )),
                      Text(
                        _projects[index].hoursSpent.toString(),
                        style: TextStyle(fontSize: 36),
                      ),
                      FlatButton(
                          padding: EdgeInsets.all(8.0),
                          onPressed: () {
                            setState(() {
                              _projects[index].hoursSpent -= 1;
                              debugPrint("Hello Down " +
                                  _projects[index].hoursSpent.toString());
                            });
                          },
                          child: Icon(
                            Icons.remove,
                            size: 36,
                          )),
                    ],
                  )
                ]));
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: _projects.length,
        ));
  }
}

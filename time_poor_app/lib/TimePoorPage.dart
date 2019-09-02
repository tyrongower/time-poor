import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:time_poor_app/screens/NewProjectScreen.dart';
import 'db/entities/Project.dart';

class TimePoor extends StatefulWidget {
  @override
  _TimePoorState createState() => _TimePoorState();
}

class _TimePoorState extends State<TimePoor> {
  List<Project> _projects = new List<Project>();

  loadProjects() async {
    List<Project>  p = await Project.getAllProjects();
    setState(()  {
      _projects = p;
    });

  }

  _TimePoorState() {
    loadProjects();
  }

  @override
  Widget build(BuildContext context) {
    bool _newProjectPressed = false;
    return Scaffold(
        appBar: AppBar(
          title: Text("Log your time"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.assignment_ind),
              onPressed: _newProjectPressed
                  ? null
                  : () async {
                     await  Navigator.push(context, MaterialPageRoute(
                        builder: (context) => NewProject()
                      ));

                      loadProjects();
                    },
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, index) {
            final project = _projects[index];
            return RefreshIndicator(
                onRefresh: _refreshProjects,
                child: Dismissible(
                    key: Key(project.id.toString()),
                    onDismissed: (e) => projectDismissed(e, context, project),
                    child: Center(
                      child: Container(
                          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black12),
                          child: Column(children: <Widget>[
                            Container(
                              height: 25,
                              padding: EdgeInsets.fromLTRB(10, 2, 2, 2),
                              alignment: Alignment.topLeft,
                              decoration: BoxDecoration(
                                  color: new Color(project.color),
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                      bottomRight: Radius.circular(0),
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15))),
                              child: Text(
                                project.description,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 2, 2, 2),
                              height: 100,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(

                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        project.hoursSpent.toString(),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 36,
                                        ),
                                        textAlign: TextAlign.left,
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      FlatButton(
                                        child: Icon(Icons.add,size: 36,),
                                          onPressed: () async {
                                            if(project.hoursSpent >= 3600)
                                              return;

                                            Project.incrementHours(project,1);
                                            setState(() {
                                              _projects[index].hoursSpent += 1;
                                            });
                                          }
                                      )
                                      ,
                                      FlatButton(

                                        child: Icon(Icons.remove,size: 36,),
                                        onPressed: () async {
                                          if(project.hoursSpent > 0){
                                            Project.incrementHours(project,-1);
                                          setState(() {
                                            _projects[index].hoursSpent += -1;
                                          });
                                          }
                                        },
                                      )],
                                  )
                                ],
                              ),
                            )
                          ])),
                    )));
          },
          itemCount: _projects.length,
        ));
  }

  projectDismissed(DismissDirection e, BuildContext context, Project project) {
    setState(() {
      _projects.removeWhere((p) => p.id == project.id);
    });

    Project.deleteProject(project);
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(project.description + " dismissed",
      ),
      backgroundColor: Colors.lightGreen,
      elevation: 50,
      duration:  Duration(milliseconds: 750),
      behavior: SnackBarBehavior.floating,

      shape: RoundedRectangleBorder(
        borderRadius:BorderRadius.circular(10),
        side: BorderSide(

        )
      ) ,
    ));
  }

  Future<void> _refreshProjects() {
    loadProjects();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:time_poor_app/db/entities/Project.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';

class NewProject extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _NewProject();
}

class _NewProject extends State {
  final projectController = new TextEditingController();
  final hoursController = new TextEditingController();
  final colorontroller = new TextEditingController();

  final _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('First Route'),
        ),
        body: Container(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
            child: Builder(
                builder: (context) => SingleChildScrollView(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextField(
                          controller: projectController,
                          decoration: InputDecoration(
                              labelText: 'Project description',
                              icon: Icon(Icons.description)),
                          textCapitalization: TextCapitalization.sentences,
                          keyboardType: TextInputType.text,
                        ),
                        TextField(
                          decoration: InputDecoration(
                            labelText: 'Hours spent',
                            icon: Icon(Icons.timeline),
                          ),
                          keyboardType: TextInputType.numberWithOptions(
                              decimal: true, signed: true),
                          controller: hoursController,
                        ),
                        MaterialColorPicker(
                          selectedColor: new Color(
                              int.tryParse(colorontroller.text) ??
                                  Colors.accents.first.value),
                          allowShades: false,
                          shrinkWrap: true,
                          colors: Colors.accents,
                          onMainColorChange: (v) {
                            debugPrint("One");
                            return colorontroller.text = v.value.toString();
                          },
                          onColorChange: (v) {
                            debugPrint("two");
                            return colorontroller.text = v.value.toString();
                          },
                          onBack: () {
                            debugPrint("three");
                          },
                        ),
                        MaterialButton(
                          onPressed: () async {
                            await Project.newProject(new Project(
                                color: int.tryParse(colorontroller.text) ??
                                    Colors.blue.value,
                                hoursSpent:
                                    double.tryParse(hoursController.text) ?? 0,
                                description: projectController.text,
                                completed: false));
                            Navigator.pop(context);
                          },
                          child: Text("Save"),
                        ),
                      ],
                    )
                )
            )
        )
    );
  }
}

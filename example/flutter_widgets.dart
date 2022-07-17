import 'dart:convert';
import 'package:code_generator/code_generator.dart';
import 'package:code_generator/src/interpreter/other/parameter_item.dart';


void main() {
  var context = EditorContext(enableDartFormatter: true);
  var dartHelper = DartHelper.instance;
  Map map = jsonDecode(json);

  var homePage = Class('HomePage',
    baseClass: 'StatelessWidget',
    methods: [
      Annotation('override'),
      Method(
        name: 'build',
        returnType: 'Widget',
        param: Parameter([
          ParameterItem('BuildContext context'),
        ]),
        statements: [ Return(dartHelper.getCodeFromMap(map)) ]
      )
    ]
  );

  print(context.build([
    Import('package:flutter/material.dart'),
    homePage
  ]));
}

String json = ''' 
{
  "as": "Scaffold",
  "appBar": {
    "as": "AppBar",
    "title": {
      "as": "Text",
      "params": [
        "'Ahmet'"
      ]
    },
    "centerTitle": "false"
  },
  "body": {
    "as": "Center",
    "child": {
      "as": "Row",
      "children": [
        {
          "as": "Icon",
          "params": ["Icons.add"],
          "color": "Colors.red"
        },
        {
          "as": "Text",
          "params": ["'Ahmet'"],
          "textAlign": "TextAlign.center"
        }
      ]
    }
  }
}
''';

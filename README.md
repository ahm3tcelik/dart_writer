# DartWriter

`DartWriter` provides API to generate Dart source code. It can make your job easier while developing flutter/dart tools. You can also generate Flutter UI code.

### Hello World Example

```dart
var context = EditorContext(enableDartFormatter: true);
var code = Method(
  name: 'main',
  returnType: 'void',
  statements: [
    Call('print',
      argument: Argument([
        ArgumentItem("'Hello World!'")
      ])
    ),
    Return('0')
  ]
);
print(context.build([code]));
```
Generated as below:
```dart
void main() {
  print('Hello World!');
  return 0;
}
```

### Flutter Stateless Widget Example
Input
```json
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
```
Code:
```dart
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
```
Generated ui code:
```dart
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Ahmet'), centerTitle: false),
        body: Center(
            child: Row(children: [
          Icon(Icons.add, color: Colors.red),
          Text('Ahmet', textAlign: TextAlign.center)
        ])));
  }
}
```

## API Documentation

- [Documentation Guideline](#documentation-guideline)
  - [Conditions](#conditions)
    - [If](#if)
    - [Else If](#else-if)
    - [Else](#else) 
  - [Loops](#loops)
    - [For](#for)
    - [Foreach](#foreach)
    - [While](#while)
  - [Statements](#statements)
    - [Assignment](#assignment)
    - [Call](#call)
    - [Return](#return)
  - [OOP Concepts]
    - [Class](#class)
      - [Attributes](#attributes)
      - [Constructors](#constructors)
      - [Methods](#methods)
        - [Method](#method) 
        - [Getter](#getter)
        - [Setter](#setter)
    - [Interface]
  - Other
    - [Annotations](#annotations)
    - [Import](#import)
    - [Enum](#enum)
    - [Argument](#argument)
    - [Parameter](#parameter)
  

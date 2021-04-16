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
    - [If](#conditions)
    - [Else If](#conditions)
    - [Else](#conditions) 
  - [Loops](#loops)
    - [For](#loops)
    - [Foreach](#loops)
    - [While](#loops)
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
  
### Conditions
```dart
Method(
  name: 'getMin',
  returnType: 'int',
  statements: [
    Assign('var num1', '5'),
    Assign('var num2', '10'),
    If(condition: 'num1 < num2', statements: [Return('num1')]),
    ElseIf(condition: 'num1 == num2', statements: [Return('num1')]),
    Else(statements: [Return('num2')])
  ]  
)
```
Generated code:
```dart
int getMin() {
  var num1 = 5;
  var num2 = 10;
  if (num1 < num2) {
    return num1;
  } else if (num1 == num2) {
    return num1;
  } else {
    return num2;
  }
}
```

### Loops
```dart
Method(
  name: 'loops',
  returnType: 'void',
  statements: [
    For('i = 0', 'i < 5', 'i++',
      statements: [RawCode('print(i);')]
    ),
    ForEach('item', 'userList',
      statements: [
        Return('UserCard(item)')
      ]
    ),
    While('i < 5',
      statements: [ RawCode('print(i);'), Assign('i', 'i + 1')]
    )
  ]  
)
```
Generated code:
```dart
void loops() {
  for (var i = 0; i < 5; i++) {
    print(i);
  }
  for (var item in userList) { 
    return UserCard(item);     
  }
  while (i < 5) {
    print(i);
    i = i + 1;
  }
}
```
```dart

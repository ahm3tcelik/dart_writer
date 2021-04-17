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
  - [OOP Concepts](#oop-concepts)
    - [Class](#class)
      - [Attributes](#attributes)
      - [Constructors](#constructors)
      - [Methods](#methods)
        - [Method](#method) 
        - [Getter](#getter)
        - [Setter](#setter)
    - [Interface](#interface)
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
### Statements
```dart
Method(name: 'do', returnType: 'int',
  statements: [
    Assign('var i', '5'),
    Assign('var name', Call('getName')),
    Return('i')
  ] 
)
```
Generated code:
```dart
int do() {
  var i = 5;
  var name = getName();
  return i;
}
```

### OOP Concepts

#### Class
| Parameter      | Description | Output |
| ----------- | ----------- | ----------- |
| String className      | Class Name | `class Bird` |
| bool isAbstract?      | Generating abstract class if value is true | `abstract class Animal` or `class Animal` |
| List\<Constructors\>?   | more than one constructor can be defined | `Singleton._init()` , `Singleton({this.a}) : super(a)` |
| String? baseClass     | extends to base class | `class Bird extends Animal` |
| List\<String\>? mixins  | indicates the use of mixins | `class Bird with Feather, Walk` |
| List\<String\>? interfaces  | implements interface | `class Bird implements Flyable, Crowable` |
| List\<Attribute\>? attributes;  | attributes of class | `final String name;` |
| List\<IExpression\>? methods;  | all methods of class such as Method, Getters, Settters | `final String name;` |

#### Constructor
| Parameter      | Description | Output |
| ----------- | ----------- | ----------- |
| String className      | Class Name | `class Singleton` |
| String consturctorName? | if value is null Default constructor. if not value, named constructor.  | `Singleton._init()` , `Singleton({this.a})` |
| Parameter? param  | Constructor parameters | `Singleton({required this.a})`, `Singleton(this.a, {this.b})` |
| String? superArgument     | call constructor of base class | `Singleton(this.a) : super(a)` |
| String? modifier     | modifier of constructor such as `factory` | `factory Singleton()` |

#### Attribute
| Parameter      | Description | Output |
| ----------- | ----------- | ----------- |
| String name | Attribute Name | `name` |
| String type | Attribute type  | `String name` |
| String? modifiers | Attribute modifiers | `final String name` |
| String? value     | initialize value to attribute | `final String name = 'Ahmet'` |

### Methods

#### Method
| Parameter      | Description | Output |
| ----------- | ----------- | ----------- |
| String name      | Method Name | `walk` |
| String returnType? | Return type  | `void walk` |
| Parameter? param  | Method parameters | `void walk({required int step})` |
| bool? isAsync  | is async method? | `void walk({required int step}) async {}` |
| String? modifier  | Modifier of method such as `static` | `static void walk` |
| List\<IExpression\>? statements     | body of method. | `Code here...` |

#### Getter
| Parameter      | Description | Output |
| ----------- | ----------- | ----------- |
| String name      | Getter Name | `get walk` |
| String returnType? | Return type  | `void get walk` |
| String? modifier  | Modifier of method such as `static` | `static void get name` |
| List\<IExpression\>? statements     | body of method. | `Code here...` |

#### Setter
| Parameter      | Description | Output |
| ----------- | ----------- | ----------- |
| String name      | Getter Name | `set name` |
| String param? | Return type  | `set name(String name)` |
| List\<IExpression\>? statements     | body of method. | `Code here...` |

Example Class Code:

```dart
Class(
  'Bird',
  baseClass: 'Animal',
  interfaces: ['Flyable', 'Crowable'],
  mixins: ['Feather', 'Walk'],
  attributes: <Attribute> [
    Attribute(modifiers: 'final', type: 'String', name: 'name'),
  ],
  constructors: <Constructor> [
    Constructor(
      className: 'Bird',
      constructorName: 'fromName',
      param: Parameter([ParameterItem('this.name', isRequired: true, isNamed: true)]),
        superArgument: Argument([ArgumentItem('name')])
    ),
  ],
  methods: [
    Method(
      name: 'onFly',
      returnType: 'double',
      param: Parameter([ParameterItem('double height')]),
      statements: [Return('height * 2')]
    ),
  ]
);
```
Generated code:
```dart
class Bird extends Animal with Feather, Walk implements Flyable, Crowable {   
  final String name;

  Bird.fromName({required this.name}) : super(name);

  double onFly(double height) {        
    return height * 2;
  }
}
```

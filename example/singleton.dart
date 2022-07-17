import 'package:code_generator/code_generator.dart';

/// [ Output ]
/*
class Singleton {
  static Singleton? _instance;      

  Singleton._init();

  static Singleton get instance {   
    if (_instance == null) {        
      _instance = Singleton._init();
    }
    return _instance!;
  }

}
*/

void main() {
  var editor = EditorContext();
  var singletonCode = editor.build([
    Class('Singleton', 
    baseClass: 'Base',
    attributes: [
      Attribute(name: '_instance', type: 'Singleton?', modifiers: 'static'),
      Attribute(name: 'list', type: 'List', modifiers: 'final'),
    ], methods: [
      Getter(
          name: 'instance',
          returnType: 'Singleton',
          modifier: 'static',
          statements: [
            If(
                condition: '_instance == null',
                statements: [Assign('_instance', 'Singleton._init()')]),
            Return('_instance!')
          ])
    ], constructors: [
      Constructor(
          className: 'Singleton',
          constructorName: '_init'
      )
    ]),
  ]);

  print(singletonCode);
}

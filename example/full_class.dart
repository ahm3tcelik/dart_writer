import 'package:code_generator/code_generator.dart';

/// [Output]:
// class Bird extends Animal with Feather, Walk implements Flyable, Crowable {   
//   final String name;

//   Bird.fromName({required this.name}) : super(name);

//   double onFly(double height) {        
//     return height * 2;
//   }
// }
void main() {
  var context = EditorContext(enableDartFormatter: true);
  var code = Class(
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

  print(context.build([code]));

}
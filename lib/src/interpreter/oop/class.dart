import 'constructor.dart';
import '../IExpression.dart';
import '../editor_context.dart';
import '../scope.dart';
import 'attribute.dart';

class Class implements IExpression {
  final String className;
  final bool? isAbstract;
  final List<Constructor>? constructors;

  /// [extends] $baseClass
  final String? baseClass;

  /// [with] $mixins[i]
  final List<String>? mixins;

  /// [implements] $interfaces[i]
  final List<String>? interfaces;
  final List<Attribute>? attributes;
  final List<IExpression>? methods;

  /// Example
  /// ```dart
  /// Class(
  ///  'Bird',
  ///  baseClass: 'Animal',
  ///  interfaces: ['Flyable', 'Crowable'],
  ///  mixins: ['Feather', 'Walk'],
  ///  attributes: <Attribute> [
  ///    Attribute(modifiers: 'final', type: 'String', name: 'name'),
  ///  ],
  ///  constructors: <Constructor> [
  ///    Constructor(
  ///      className: 'Bird',
  ///      constructorName: 'fromName',
  ///      param: Parameter([ParameterItem('this.name', isRequired: true, isNamed: true)]),
  ///        superArgument: Argument([ArgumentItem('name')])
  ///    ),
  ///  ],
  ///  methods: [
  ///    Method(
  ///      name: 'onFly',
  ///      returnType: 'double',
  ///      param: Parameter([ParameterItem('double height')]),
  ///      statements: [Return('height * 2')]
  ///    ),
  ///  ]
  ///  );
  /// ```
  ///  [Output]
  //   class Bird extends Animal with Feather, Walk implements Flyable, Crowable {   
  //   final String name;

  //   Bird.fromName({required this.name}) : super(name);

  //   double onFly(double height) {        
  //     return height * 2;
  //   }
  // }
  Class(this.className,
      {this.isAbstract,
      this.constructors,
      this.baseClass,
      this.mixins,
      this.interfaces,
      this.attributes,
      this.methods});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());

    if (isAbstract ?? false) {
      buffer.write('abstract ');
    }

    buffer.write('class $className');

    /// [extends] $baseClass
    if (baseClass != null) {
      buffer.write(' extends $baseClass');
    }

    /// [with] $mixins[0], $mixins[1]
    if (mixins != null) {
      buffer.write(' with ');
      mixins!.forEach((element) {
        buffer.write(element);
        if (element != mixins!.last) {
          buffer.write(', ');
        }
      });
    }

    /// [implements] $interfaces[0], $interfaces[1]
    if (interfaces != null) {
      buffer.write(' implements ');
      interfaces!.forEach((element) {
        buffer.write(element);
        if (element != interfaces!.last) {
          buffer.write(', ');
        }
      });
    }

    buffer.writeln(context.openScope(Scope.CLASS));

    if (attributes != null) {
      attributes!.forEach((element) {
        buffer.write(element.interpret(context));
      });
      buffer.writeln();
    }

    if (constructors != null) {
      constructors!.forEach((element) {
        buffer.write(element.interpret(context));
      });
      buffer.writeln();
    }

    if (methods != null) {
      methods!.forEach((element) {
        buffer.write(element.interpret(context));
      });
    }

    buffer.write(context.closeScope());

    return buffer.toString();
  }
}

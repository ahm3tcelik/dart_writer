import '../IExpression.dart';
import '../editor_context.dart';
import '../scope.dart';

class Interface implements IExpression {
  final String name;

  /// [extends] $baseClass
  final String? baseClass;
  final List<IExpression>? prototypes;

  /// Example
  /// ```dart
  /// Interface('Flyable', baseClass: 'Breathable', prototypes: [
  ///    Method(name: 'doFly', returnType: 'void')
  ///  ]),
  /// ```
  /// [Output]: abstract class Flyable extends Breathable { void doFly(); }
  Interface(this.name, {this.baseClass, this.prototypes});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    buffer.write('abstract class $name');

    /// [extends] $baseClass
    if (baseClass != null) {
      buffer.write(' extends $baseClass');
    }
    buffer.writeln(context.openScope(Scope.INTERFACE));

    if (prototypes != null) {
      prototypes!.forEach((element) {
        buffer.write(element.interpret(context));
      });
    }
    buffer.write(context.closeScope());
    return buffer.toString();
  }
}

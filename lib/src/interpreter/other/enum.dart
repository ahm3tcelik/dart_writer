import '../editor_context.dart';
import '../IExpression.dart';
import '../scope.dart';

class Enum implements IExpression {
  final String name;
  final List<String> enums;

  /// Example
  /// ```dart
  /// Enum('Roles', enums: ['USER', 'ADMIN', 'DEVELOPER'])
  /// ```
  /// [Output]: enum Roles { USER, ADMIN, DEVELOPER }
  Enum(this.name, {required this.enums});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    buffer.write('enum $name');
    buffer.writeln(context.openScope(Scope.ENUM));
    
    enums.forEach((element) {
      buffer.write(context.indent());
      buffer.write(element);
      if (element != enums.last) {
        buffer.writeln(', ');
      } else {
        buffer.writeln();
      }
    });
    
    buffer.write(context.closeScope());
    return buffer.toString();
  }
}
import '../../IExpression.dart';
import '../../editor_context.dart';
import '../../scope.dart';
import '../../../extensions/string_extension.dart';

class Setter implements IExpression {
  final String name;
  final String param;
  final List<IExpression>? statements;

  /// Example Abstract Setter
  ///```dart
  /// Setter(
  ///   name: 'name',
  ///   param: 'String name',
  /// )
  ///```
  /// [Output]: set name(String name);
  
  /// Example
  ///```dart
  /// Setter(
  ///   name: 'name',
  ///   param: 'String name',
  ///   statements: [
  ///     Assign('this.name', 'name')
  ///   ]
  /// )
  ///```
  /// [Output]: set name(String name) { this.name = name; }
  Setter({required this.name, required this.param, this.statements});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());

    buffer.write('set $name($param)');
    
    if (statements != null) {
      buffer.writeln(context.openScope(Scope.SET));
      statements!.forEach((statement) {
        buffer.write(statement.interpret(context));
      });
      buffer.writeln(context.closeScope());
    }
    /// [Abstract setter] ex: set name(String s);
    else {
      buffer.writeln(''.putSemicolon);
    }

    return buffer.toString();
  }
}

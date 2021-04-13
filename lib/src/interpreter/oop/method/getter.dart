import '../../IExpression.dart';
import '../../editor_context.dart';
import '../../scope.dart';
import '../../../extensions/string_extension.dart';

class Getter implements IExpression {
  final String name;
  final String returnType;
  final List<IExpression>? statements;
  final String? modifier;

  /// Example Abstract Getter
  ///```dart
  /// Getter(
  ///   name: 'name',
  ///   returnType: 'String',
  /// )
  ///```
  /// [Output]: String get name;

  /// Example Getter
  ///```dart
  /// Getter(
  ///   name: 'getName',
  ///   returnType: 'String',
  ///   modifier: 'static',
  ///   statements: [
  ///     Return("'name'")
  ///   ]
  /// )
  ///```
  /// [Output]: static String get getName { return 'name'; }
  Getter(
      {required this.name,
      required this.returnType,
      this.modifier,
      this.statements});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());

    // example: static modifier
    if (modifier?.isNotEmpty ?? false) {
      buffer.write('$modifier ');
    }

    if (returnType.isNotEmpty) {
      buffer.write('$returnType ');
    }
    buffer.write('get $name');
    
    if (statements != null) {
      buffer.writeln(context.openScope(Scope.GET));
      statements!.forEach((statement) {
        buffer.write(statement.interpret(context));
      });
      buffer.writeln(context.closeScope());
    }
    /// [Abstract getter] ex: String get name;
    else {
      buffer.writeln(''.putSemicolon);
    }

    return buffer.toString();
  }
}

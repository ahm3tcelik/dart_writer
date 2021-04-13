import '../editor_context.dart';
import '../IExpression.dart';
import '../../extensions/string_extension.dart';

class Import implements IExpression {
  final String path;
  final String? asName;

  /// Example
  /// ```dart
  /// Enum('Roles', enums: ['USER', 'ADMIN', 'DEVELOPER'])
  /// ```
  /// [Output]: enum Roles { USER, ADMIN, DEVELOPER }
  Import(this.path, {this.asName});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write("import '$path'");
    if (asName?.isNotEmpty ?? false) {
      buffer.write(' as $asName');
    }
    buffer.writeln(''.putSemicolon);
    return buffer.toString();
  }
}
import '../editor_context.dart';
import '../IExpression.dart';
import '../../extensions/string_extension.dart';

class Import implements IExpression {
  final String path;
  final String? asName;

  /// Example
  /// ```dart
  /// Import('package:dart_writer/dart_writer.dart', as: 'writer')
  /// ```
  /// [Output]: import 'package:dart_writer/dart_writer.dart as writer;
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
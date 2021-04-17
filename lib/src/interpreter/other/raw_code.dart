import '../IExpression.dart';
import '../editor_context.dart';

class RawCode implements IExpression {
  final String code;

  /// Example
  /// ```dart
  /// RawCode('var name = user?.name ?? "'ahmet'"')
  /// ```
  /// [Output]: var name = user?.name ?? 'ahmet'
  RawCode(this.code);

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    buffer.write(code);
    return buffer.toString();
  }
}

import '../IExpression.dart';
import '../editor_context.dart';

class RawCode implements IExpression {
  final String code;

  /// Example
  /// ```dart
  /// While('item', 'userList', statements: [ Return('UserCard(item')])
  /// ```
  /// [Output]: for (var item in userList) { return UserCard(item); }
  RawCode(this.code);

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    buffer.write(code);
    return buffer.toString();
  }
}

import '../IExpression.dart';
import '../editor_context.dart';
import '../../extensions/string_extension.dart';

class Return implements IExpression {
  final dynamic returnValue;

  /// [returnValue] must be [String] or [IExpression]

  /// Example # 1 
  ///```dart
  /// Return('name')
  ///```
  /// [Output]: return name;
  /// 
  /// Example # 2 
  ///```dart
  /// Return(Call('getName'))
  ///```
  /// [Output]: return getName();
  Return(this.returnValue);

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    String value;
    if (returnValue is IExpression) {
      value = _getStringFromExpression(context, returnValue);
    } else {
      value = returnValue;
    }
    buffer.writeln('return $value'.putSemicolon);
    return buffer.toString();
  }

  String _getStringFromExpression(EditorContext context, IExpression exp) {
    return exp.interpret(context).removeSemicolon;
  }
}
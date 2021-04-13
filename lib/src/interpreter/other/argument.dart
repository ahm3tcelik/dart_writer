import '../IExpression.dart';
import '../editor_context.dart';
import '../../extensions/string_extension.dart';

class Argument implements IExpression {
  final List<MapEntry<String?, dynamic>>? args;
  /// Example
  /// ```dart
  /// Argument([
  ///   MapEntry(null, 'name'),
  ///   MapEntry('surname', "'Star'")
  /// ])
  /// ```
  /// [Output]: name, surname: 'Star'
  Argument(this.args);

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    if (args != null) {
      String value;
      args!.forEach((arg) {
        if (arg.value is IExpression) {
          value = _getStringFromExpression(context, arg.value);
        } else {
          value = arg.value;
        }
        // Positonal Argument ex: (200, 300)
        if (arg.key == null) {
          buffer.write(value);
        }
        // Named Argument ex: (width: 200, height: 300)
        else {
          buffer.write('${arg.key}: $value');
        }

        if (arg != args!.last) {
          buffer.write(', ');
        }
      });
    }
    return buffer.toString();
  }

  String _getStringFromExpression(EditorContext context, IExpression exp) {
    return exp.interpret(context).removeSemicolon;
  }
}
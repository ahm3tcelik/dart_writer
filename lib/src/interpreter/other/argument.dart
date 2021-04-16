import 'argument_item.dart';
import '../IExpression.dart';
import '../editor_context.dart';
import '../../extensions/string_extension.dart';

class Argument implements IExpression {
  final List<ArgumentItem>? args;
  /// Example
  /// ```dart
  /// Argument([
  ///   ArgumentItem('name'),
  ///   ArgumentItem("'Star'", name:'surname')
  /// ])
  /// ```
  /// [Output]: name, surname: 'Star'
  Argument(this.args);

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    if (args?.isNotEmpty ?? false) {
      String value;
      args!.forEach((arg) {
        
        value = _evaluate(context, arg.arg);

        // Positonal Argument ex: (200, 300)
        if (arg.name == null) {
          buffer.write(value);
        }
        // Named Argument ex: (width: 200, height: 300)
        else {
          buffer.write('${arg.name}: $value');
        }

        if (arg != args!.last) {
          buffer.write(', ');
        }
      });
    }
    return buffer.toString();
  }

  String _evaluate(EditorContext context, dynamic value) {
    if (value is IExpression) {
      return _getStringFromExpression(context, value);
    }
    else if (value is List) {
      var result = StringBuffer();
      result.write('[ ');
      value.forEach((element) {
        result.write(_evaluate(context, element));
        if (element != value.last) {
          result.write(', ');
        }
      });
      result.write(' ]');
      return result.toString();
    }
    else {
      return value;
    }
  }

  String _getStringFromExpression(EditorContext context, IExpression exp) {
    return exp.interpret(context).removeSemicolon;
  }
}
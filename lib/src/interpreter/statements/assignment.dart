import '../IExpression.dart';
import '../editor_context.dart';
import '../../extensions/string_extension.dart';

class Assign implements IExpression {
  final String dest;
  final dynamic source;
  final bool isAsync;
  
  /// Example
  /// ```dart
  /// Assign('var i', '5')
  /// ```
  /// [Output]: var i = 5;
  Assign(this.dest, this.source, {this.isAsync = false});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    String sourceValue;
    if (source is IExpression) {
      sourceValue = _getStringFromExpression(context, source);
    } else {
      sourceValue = source;
    }
    buffer.writeln('$dest =${isAsync ? ' await' : ''} $sourceValue'.putSemicolon);
    return buffer.toString();
  }

  String _getStringFromExpression(EditorContext context, IExpression exp) {
    return exp.interpret(context).removeSemicolon;
  }
}

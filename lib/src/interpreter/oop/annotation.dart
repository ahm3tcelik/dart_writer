import '../IExpression.dart';
import '../editor_context.dart';

class Annotation implements IExpression {
  final String name;

  /// Example
  ///```dart
  /// Annotation('override'),
  ///```
  /// [Output]: @override
  Annotation(this.name);

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    buffer.writeln('@$name');
    return buffer.toString();
  }
}

import '../IExpression.dart';
import '../editor_context.dart';
import '../../extensions/string_extension.dart';
import '../other/argument.dart';

class Call implements IExpression {
  final String name;
  final Argument? argument;

  /// Example
  /// ```dart
  /// Call('Card', argument: Argument([MapEntry('name', "'Ahmet'")]))
  /// ```
  /// [Output]: Card(name: 'Ahmet')
  Call(this.name, {this.argument});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    var argsText = '';
    if (argument?.args?.isNotEmpty ?? false) {
      argsText = argument!.interpret(context);
    }
    buffer.write('$name($argsText)'.putSemicolon);
    return buffer.toString();
  }
}
import '../IExpression.dart';
import '../editor_context.dart';
import '../../extensions/string_extension.dart';

class Attribute implements IExpression {
  final String name;
  final String type;
  final String? modifiers;
  final String? value;

  /// Example
  ///```dart
  /// Attribute(modifiers: 'final', type: 'String?', name: 'name'),
  /// Attribute(modifiers: 'final', type: 'String?', name: 'surname', value: "'Star'")
  ///```
  /// [Output]: final String? name;
  /// [Output]: final String? surname = 'Star';
  Attribute({
    required this.name,
    required this.type,
    this.modifiers,
    this.value
  });

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());

    if (modifiers?.isNotEmpty ?? false) {
      buffer.write('$modifiers ');
    }
    // static final int LEN;
    // static final int LEN = 5;
    buffer.write('$type $name');
    if (value?.isNotEmpty ?? false) {
      buffer.write(' = $value');
    }
    buffer.writeln(''.putSemicolon);
    return buffer.toString();
  }
}

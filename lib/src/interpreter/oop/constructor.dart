import '../other/argument.dart';
import '../IExpression.dart';
import '../editor_context.dart';
import '../scope.dart';
import '../../extensions/string_extension.dart';
import '../other/parameter.dart';

class Constructor implements IExpression {
  final String className;
  final String? constructorName;
  final Parameter? param;
  final List<IExpression>? statements;
  final Argument? superArgument;
  final String modifier;

  /// Example
  ///```dart
  /// Constructor(
  ///   className: 'Bird',
  ///   constructorName: 'fromName',
  ///   param: Parameter([MapEntry('this.name', true)]),
  ///   superArgument: Argument([MapEntry(null, 'name')]),
  ///   statements: [
  ///     Call('initialize', argument: Argument([MapEntry(null, '5')]))
  ///   ]
  /// )
  ///```
  /// [Output]: Bird.fromName({required this.name}) : super(name) { initialize(5); }
  Constructor(
      {required this.className,
      this.constructorName,
      this.param,
      this.modifier = '',
      this.statements,
      this.superArgument});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());

    /// example: [factory] modifier
    buffer.write(modifier.isEmpty ? '' : '$modifier ');
    buffer.write(className);
    if (constructorName?.isNotEmpty ?? false) {
      buffer.write('.$constructorName');
    }
    buffer.write('(${param?.interpret(context) ?? ''})');

    if (superArgument != null) {
      buffer.write(' : super(${superArgument!.interpret(context)})');
    }

    if (statements != null) {
      buffer.writeln(context.openScope(Scope.METHOD));
      statements!.forEach((element) {
        buffer.write(element.interpret(context));
      });
      buffer.write(context.closeScope());
    } else {
      buffer.writeln(''.putSemicolon);
    }
    return buffer.toString();
  }
}

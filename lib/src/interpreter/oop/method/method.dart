import '../../IExpression.dart';
import '../../editor_context.dart';
import '../../scope.dart';
import '../../../extensions/string_extension.dart';
import '../../other/parameter.dart';

class Method implements IExpression {
  final String name;
  final String? returnType;
  final bool isAsync;
  final Parameter? param;
  final List<IExpression>? statements;
  final String modifier;

  /// Example Abstract Method
  ///```dart
  /// Method(
  ///   name: 'walk',
  ///   returnType: 'void',
  ///   param: Parameter([
  ///     ParameterItem('int step', isRequired: true, isNamed: true),
  ///   ]),
  /// )
  ///```
  /// [Output]: void walk({required int step});

  /// Example
  ///```dart
  /// Method(
  ///   name: 'changeUser',
  ///   modifier: 'static',
  ///   returnType: 'User',
  ///   isAsync: true,
  ///   param: Parameter([
  ///     ParameterItem('String name', isRequired: true, isNamed: true),
  ///     ParameterItem('String surname', isRequired: true, isNamed: true),
  ///     ParameterItem('int? age', isRequired: false, isNamed: true)
  ///   ]),
  ///   statements: [
  ///     Return('newUser')
  ///   ]
  /// )
  ///```
  /// [Output]: static User changeUser({required String name, required String surname, int? age}) async { return newUser; }
  Method(
      {required this.name,
      this.returnType,
      this.param,
      this.isAsync = false,
      this.modifier = '',
      this.statements});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());

    // example: static modifier
    buffer.write(modifier.isEmpty ? '' : '$modifier ');

    if (returnType != null) {
      buffer.write('$returnType ');
    }

    buffer.write('$name(${param?.interpret(context) ?? ''})');

    if (statements != null) {
      buffer.write(isAsync ? ' async' : '');
      buffer.writeln(context.openScope(Scope.METHOD));
      statements!.forEach((statement) {
        buffer.write(statement.interpret(context));
      });
      buffer.writeln(context.closeScope());
    }
    /// [Abstract method] ex: void change();
    else {
      buffer.writeln(''.putSemicolon);
    }

    return buffer.toString();
  }
}

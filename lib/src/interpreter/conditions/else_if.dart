import '../editor_context.dart';
import '../IExpression.dart';
import '../scope.dart';

class ElseIf implements IExpression {
  final String condition;
  final List<IExpression>? statements;
  ElseIf({required this.condition, this.statements});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    buffer.write('else if ($condition)');
    buffer.writeln(context.openScope(Scope.ELIF));

    if (statements != null) {
      statements!.forEach((statement) {
        buffer.write(statement.interpret(context));
      });
    }

    buffer.write(context.closeScope());
    return buffer.toString();
  }
}

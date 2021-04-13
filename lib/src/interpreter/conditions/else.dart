import '../editor_context.dart';
import '../IExpression.dart';
import '../scope.dart';

class Else implements IExpression {
  final List<IExpression>? statements;
  Else({this.statements});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    buffer.write('else');
    buffer.writeln(context.openScope(Scope.ELSE));

    if (statements != null) {
      statements!.forEach((statement) {
        buffer.write(statement.interpret(context));
      });
    }

    buffer.write(context.closeScope());
    return buffer.toString();
  }
}

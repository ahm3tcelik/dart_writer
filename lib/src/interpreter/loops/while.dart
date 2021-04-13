import '../editor_context.dart';
import '../IExpression.dart';
import '../scope.dart';

class While implements IExpression {
  final String condition;
  final List<IExpression>? statements;
  While(this.condition, {this.statements});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    buffer.write('while ($condition)');
    buffer.writeln(context.openScope(Scope.WHILE));

    if (statements != null) {
      statements!.forEach((statement) {
        buffer.write(statement.interpret(context));
      });
    }

    buffer.write(context.closeScope());
    return buffer.toString();
  }
}

import '../editor_context.dart';
import '../IExpression.dart';
import '../scope.dart';

class For implements IExpression {
  final String init;
  final String condition;
  final String action;
  final List<IExpression>? statements;
  For(this.init, this.condition, this.action, {this.statements});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    buffer.write('for (var $init; $condition; $action)');
    buffer.writeln(context.openScope(Scope.FOR));

    if (statements != null) {
      statements!.forEach((statement) {
        buffer.write(statement.interpret(context));
      });
    }

    buffer.write(context.closeScope());
    return buffer.toString();
  }
}

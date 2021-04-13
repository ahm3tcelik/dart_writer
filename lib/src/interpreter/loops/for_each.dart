import '../editor_context.dart';
import '../IExpression.dart';
import '../scope.dart';

class ForEach implements IExpression {
  final String iterationVar;
  final String iterable;
  final List<IExpression>? statements;

  ForEach(this.iterationVar, this.iterable, {this.statements});

  @override
  String interpret(EditorContext context) {
    var buffer = StringBuffer();
    buffer.write(context.indent());
    buffer.write('for (var $iterationVar in $iterable)');
    buffer.writeln(context.openScope(Scope.FOR_EACH));

    if (statements != null) {
      statements!.forEach((statement) {
        buffer.write(statement.interpret(context));
      });
    }

    buffer.write(context.closeScope());
    return buffer.toString();
  }
}

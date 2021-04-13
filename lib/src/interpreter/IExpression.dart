import 'editor_context.dart';

abstract class IExpression {
  String interpret(EditorContext context);
}
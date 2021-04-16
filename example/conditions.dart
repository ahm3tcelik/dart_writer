import 'package:dart_writer/dart_writer.dart';

void main() {
  var context = EditorContext(enableDartFormatter: true);
  var code = Method(
    name: 'getMin',
    returnType: 'int',
    statements: [
      Assign('var num1', '5'),
      Assign('var num2', '10'),
      If(condition: 'num1 < num2', statements: [Return('num1')]),
      ElseIf(condition: 'num1 == num2', statements: [Return('num1')]),
      Else(statements: [Return('num2')])
    ]  
  );
  print(context.build([code]));
}
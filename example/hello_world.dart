import 'package:code_generator/code_generator.dart';

void main() {
  var context = EditorContext(enableDartFormatter: true);
  var code = Method(
    name: 'main',
    returnType: 'void',
    statements: [
      Call('print',
        argument: Argument([
          ArgumentItem("'Hello World!'")
        ])
      ),
      Return('0')
    ]
  );
  print(context.build([code]));
}
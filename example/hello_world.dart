import 'package:dart_writer/dart_writer.dart';

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
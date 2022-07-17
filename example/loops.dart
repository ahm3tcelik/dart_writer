import 'package:code_generator/code_generator.dart';

void main() {
  var context = EditorContext(enableDartFormatter: true);
  var code = Method(
    name: 'loops',
    returnType: 'void',
    statements: [
      For('i = 0', 'i < 5', 'i++',
        statements: [RawCode('print(i);')]
      ),
      ForEach('item', 'userList',
        statements: [
          Return('UserCard(item)')
        ]
      ),
      While('i < 5',
        statements: [ RawCode('print(i);'), Assign('i', 'i + 1')]
      )
    ]  
  );
  print(context.build([code]));
}
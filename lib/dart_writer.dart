library dart_writer;

export 'package:dart_style/dart_style.dart';

export './src/helpers/dart_helper.dart';
export './src/interpreter/IExpression.dart';
export './src/interpreter/editor_context.dart';
export './src/extensions/string_extension.dart';

// Statements
export './src/interpreter/statements/assignment.dart';
export './src/interpreter/statements/call.dart';
export './src/interpreter/statements/return.dart';

// Conditions
export './src/interpreter/conditions/if.dart';
export './src/interpreter/conditions/else.dart';
export './src/interpreter/conditions/else_if.dart';

// Loops
export './src/interpreter/loops/for.dart';
export './src/interpreter/loops/for_each.dart';
export './src/interpreter/loops/while.dart';

// Other
export './src/interpreter/other/import.dart';
export './src/interpreter/other/parameter.dart';
export './src/interpreter/other/parameter_item.dart';
export './src/interpreter/other/argument.dart';
export './src/interpreter/other/argument_item.dart';
export './src/interpreter/other/enum.dart';

// OOP
export './src/interpreter/oop/class.dart';
export './src/interpreter/oop/interface.dart';
export './src/interpreter/oop/constructor.dart';
export './src/interpreter/oop/attribute.dart';
export './src/interpreter/oop/annotation.dart';

// OOP / Method
export './src/interpreter/oop/method/method.dart';
export './src/interpreter/oop/method/getter.dart';
export './src/interpreter/oop/method/setter.dart';
import 'package:dart_writer/dart_writer.dart';

void main() {
  var context = EditorContext();

  var code = context.build([
    Import('package:dart_writer/src/writer.dart', asName: 'Writer'),
    Interface('Flyable',
        baseClass: 'Breathable',
        prototypes: [Method(name: 'doFly', returnType: 'void')]),
    Enum('Roles', enums: ['USER', 'ADMIN', 'DEVELOPER']),
    Class('Bird', baseClass: 'Animal', interfaces: [
      'Flyable',
      'Crowable'
    ], mixins: [
      'Feather',
      'Walk'
    ], attributes: <Attribute>[
      Attribute(modifiers: 'final', type: 'String?', name: 'name'),
      Attribute(
          modifiers: 'final', type: 'String?', name: 'surname', value: "'Star'")
    ], constructors: <Constructor>[
      Constructor(
        className: 'Bird',
        constructorName: 'fromName',
        param: Parameter([MapEntry('this.name', true)]),
        superArgument: Argument([MapEntry(null, 'name')]),
      )
    ], methods: [
      Getter(
          name: 'getName',
          returnType: 'String',
          modifier: 'static',
          statements: [Return("'Ahmet'")]),
      Getter(name: 'getName', returnType: 'String'),
      Setter(name: 'name', param: 'String s'),
      Setter(
          name: 'name',
          param: 'String name',
          statements: [Assign('this.name', 'name')]),
      Annotation('override'),
      Method(
          name: 'changeUser',
          modifier: 'static',
          returnType: 'User',
          isAsync: true,
          param: Parameter([
            MapEntry('String name', true),
            MapEntry('String surname', true),
            MapEntry('int? age', false)
          ]),
          statements: [Return('newUser')]),
      Method(
        name: 'changeUser',
        returnType: 'User',
        param: Parameter([
          MapEntry('String name', true),
          MapEntry('String surname', true),
          MapEntry('int? age', false)
        ]),
      )
    ]),
    ForEach('item', 'itemList', statements: [
      Call('Card', argument: Argument([MapEntry(null, 'item')]))
    ]),
    While('i < 5'),
    For('i = 0', 'i < 5', 'i++'),
    If(
        condition: 'i < 5',
        statements: [Assign('i', 'i++'), Assign('i', 'i + 5')]),
    ElseIf(
      condition: 'i == 5',
      statements: [Assign('i', 'i - 1')],
    ),
    Else(statements: [Assign('i', '5'), Return('i')]),
    Call('Text',
        argument: Argument([MapEntry(null, "'Ahmet'"), MapEntry('age', '21')]))
  ]);
  print(code);
}

// Copyright (c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of protoc;

const String SP = ' ';

class MessageGenerator extends ProtobufContainer {
  // List of Dart language reserved words in names which cannot be used in a
  // subclass of GeneratedMessage.
  static final List<String> reservedWords =
      ['assert', 'break', 'case', 'catch', 'class', 'const', 'continue',
       'default', 'do', 'else', 'enum', 'extends', 'false', 'final',
       'finally', 'for', 'if', 'in', 'is', 'new', 'null', 'rethrow', 'return',
       'super', 'switch', 'this', 'throw', 'true', 'try', 'var', 'void',
       'while', 'with'];

  // List of names which cannot be used in a subclass of GeneratedMessage.
  static final List<String> reservedNames =
    ['hashCode', 'noSuchMethod','runtimeType', 'toString',
     'fromBuffer', 'fromJson', 'hasRequiredFields', 'isInitialized',
     'clear', 'getTagNumber', 'check',
     'writeToBuffer', 'writeToCodedBufferWriter',
     'mergeFromCodedBufferReader', 'mergeFromBuffer',
     'writeToJson', 'mergeFromJson',
     'writeToJsonMap', 'mergeFromJsonMap',
     'addExtension', 'getExtension', 'setExtension',
     'hasExtension', 'clearExtension',
     'getField', 'setField', 'hasField', 'clearField',
     'extensionsAreInitialized', 'mergeFromMessage', 'mergeUnknownFields',
     '==', 'info_', 'GeneratedMessage', 'Object'];

  // List of names that can't be used in a subclass that implements Map.
  static final List<String> reservedNamesForMap =
    ['addAll', 'containsKey', 'containsValue', 'forEach', 'putIfAbsent',
     'remove', 'isEmpty', 'isNotEmpty', 'keys', 'length', 'values'];

  // This should match the extension in dart_options.proto.
  static const int implementMapOption = 95333044;

  // Returns true if the implement_map option is turned on for the message.
  static bool _shouldImplementMap(DescriptorProto desc, bool defaultValue) {
    if (!desc.hasOptions()) return defaultValue;

    var val = desc.options.unknownFields.getField(implementMapOption);
    if (val == null || val.length != 1) return defaultValue;

    return val.values[0] == 1;
  }

  final String classname;
  final String fqname;
  final bool implementsMap;

  final ProtobufContainer _parent;
  final GenerationContext _context;
  final DescriptorProto _descriptor;
  final List<EnumGenerator> _enumGenerators = <EnumGenerator>[];
  final List<ProtobufField> _fieldList = <ProtobufField>[];
  final List<MessageGenerator> _messageGenerators = <MessageGenerator>[];
  final List<ExtensionGenerator> _extensionGenerators = <ExtensionGenerator>[];
  final Set<String> _methodNames = new Set<String>();

  MessageGenerator(
      DescriptorProto descriptor, ProtobufContainer parent, this._context,
      bool implementMapByDefault)
      : _descriptor = descriptor,
        _parent = parent,
        classname = (parent.classname == '') ?
            descriptor.name : '${parent.classname}_${descriptor.name}',
        fqname = (parent == null || parent.fqname == null) ? descriptor.name :
            (parent.fqname == '.' ?
                '.${descriptor.name}' : '${parent.fqname}.${descriptor.name}'),
        implementsMap = _shouldImplementMap(descriptor, implementMapByDefault) {
    _context.register(this);

    for (EnumDescriptorProto e in _descriptor.enumType) {
      _enumGenerators.add(new EnumGenerator(e, this, _context));
    }

    for (DescriptorProto n in _descriptor.nestedType) {
      _messageGenerators.add(
          new MessageGenerator(n, this, _context, implementMapByDefault));
    }

    for (FieldDescriptorProto x in _descriptor.extension) {
      _extensionGenerators.add(new ExtensionGenerator(x, this, _context));
    }
  }

  String get package => _parent.package;

  bool get needsMapMixinImport {
    if (implementsMap) return true;

    for (var m in _messageGenerators) {
      if (m.implementsMap) return true;
    }

    return false;
  }

  void initializeFields() {
    _fieldList.clear();
    for (FieldDescriptorProto field in _descriptor.field) {
      _fieldList.add(new ProtobufField(field, this, _context));
    }
    for (MessageGenerator m in _messageGenerators) {
      m.initializeFields();
    }
  }

  void generate(IndentingWriter out) {
    _methodNames.clear();
    _methodNames.addAll(reservedWords);
    _methodNames.addAll(reservedNames);

    if (implementsMap) {
      _methodNames.addAll(reservedNamesForMap);
    }

    for (EnumGenerator e in _enumGenerators) {
      e.generate(out);
    }

    for (MessageGenerator m in _messageGenerators) {
      m.generate(out);
    }

    var implClause = "";
    if (implementsMap) {
      implClause = " with MapMixin";
    }

    out.addBlock('class ${classname} extends GeneratedMessage${implClause} {',
        '}', ()
      {
      out.addBlock(
          'static final BuilderInfo _i = new BuilderInfo(\'${classname}\')',
          ';', () {
        for (ProtobufField field in _fieldList) {
          String type = field.shortTypeName;
          String fieldType = field.baseTypeForPackage(package);

          String makeDefault = null;
          if (field.hasInitialization) {
            makeDefault = field.initializationForPackage(package);
          }
          String subBuilder = null;
          String subBuilderRepeated = null;
          if (field.message || field.group) {
            subBuilder = '${fieldType}.create';
            subBuilderRepeated = '${fieldType}.createRepeated';
          }
          String valueOf = null;
          if (field.enm) {
            valueOf = '(var v)${SP}=>${SP}${fieldType}.valueOf(v)';
          }
          if ('PM' == type) {
            // Repeated message: default is an empty list
            out.println('..m(${field.number},${SP}'
                '\'${field.externalFieldName}\',${SP}$subBuilder,'
                '${SP}$subBuilderRepeated)');
          } else if (type[0] == 'P' && type != 'PG' && type != 'PE') {
            // Repeated, not a message or enum: default is an empty list,
            // subBuilder is null, valueOf is null.
            out.println('..p(${field.number},${SP}'
                '\'${field.externalFieldName}\',${SP}GeneratedMessage.$type)');
          } else if (type == 'OE' || type == 'QE') {
            out.println('..e(${field.number},${SP}'
                '\'${field.externalFieldName}\',${SP}GeneratedMessage.$type,'
                '${SP}$makeDefault,${SP}$valueOf)');
          } else {
            if (makeDefault == null && subBuilder == null && valueOf == null) {
              out.println('..a(${field.number},${SP}'
                  '\'${field.externalFieldName}\',${SP}GeneratedMessage.$type)');
            } else if (subBuilder == null && valueOf == null) {
              out.println('..a(${field.number},${SP}'
                  '\'${field.externalFieldName}\',${SP}GeneratedMessage.$type,'
                  '${SP}$makeDefault)');
            } else if (valueOf == null) {
              out.println('..a(${field.number},${SP}'
                  '\'${field.externalFieldName}\',${SP}GeneratedMessage.$type,'
                  '${SP}$makeDefault,${SP}$subBuilder)');
            } else {
              out.println('..a(${field.number},${SP}'
                  '\'${field.externalFieldName}\',${SP}GeneratedMessage.$type,'
                  '${SP}$makeDefault,${SP}$subBuilder,${SP}$valueOf)');
            }
          }
        }

        if (_descriptor.extensionRange.length > 0) {
          out.println('..hasExtensions${SP}=${SP}true');
        }
        if (!_hasRequiredFields(this, new Set())) {
          out.println('..hasRequiredFields${SP}=${SP}false');
        }
      });

      for (ExtensionGenerator x in _extensionGenerators) {
        x.generate(out);
      }

      out.println();

      out.println('${classname}()${SP}:${SP}super();');
      out.println('${classname}.fromBuffer(List<int> i,'
          '${SP}[ExtensionRegistry r = ExtensionRegistry.EMPTY])'
          '${SP}:${SP}super.fromBuffer(i,${SP}r);');
      out.println('${classname}.fromJson(String i,'
          '${SP}[ExtensionRegistry r = ExtensionRegistry.EMPTY])'
          '${SP}:${SP}super.fromJson(i,${SP}r);');
      out.println('${classname} clone()${SP}=>'
          '${SP}new ${classname}()..mergeFromMessage(this);');

      out.println('BuilderInfo get info_${SP}=>${SP}_i;');

      // Factory functions which can be used as default value closures.
      out.println('static ${classname}${SP}create()${SP}=>'
          '${SP}new ${classname}();');
      out.println('static PbList<${classname}>${SP}createRepeated()${SP}=>'
          '${SP}new PbList<${classname}>();');


      if (implementsMap) {
        // clear() is inherited from GeneratedMessage.
        // Other map operations are implemented by MapMixin.
        out.println('''
@override
operator [] (key) {
  if (key is !String) return null;
  if (!key.contains(".")) {
    var tag = getTagNumber(key);
    if (tag == null) return null;
    return getField(tag);
  }

  var keys = key.split('.');
  var item = this;
  for (var key in keys) {
    if (item is !GeneratedMessage) return null;
    var tag = item.getTagNumber(key);
    if (tag == null) return null;
    item = item.getField(tag);
  }

  return item;
}

@override
operator []= (String key, val) {
  if (!key.contains(".")) {
    var tag = _mustGetTagNumber(this, key);
    setField(tag, val);
    return;
  }

  var keys = key.split('.');
  var lastKey = keys.removeLast();
  var item = this;
  for (var key in keys) {
    var tag = _mustGetTagNumber(item, key);
    item = item.getField(tag);
    if (item is !GeneratedMessage) {
      throw new ArgumentError(
          "field '\${key}' in \${info._messageName} isn't a GeneratedMessage:");
    }
  }
  var tag = _mustGetTagNumber(item, lastKey);
  item.setField(tag, val);
}

_mustGetTagNumber(GeneratedMessage msg, String key) {
  var tag = msg.getTagNumber(key);
  if (tag == null) {
    throw new ArgumentError(
        "field '\${key}' not found in \${msg.info_.messageName}");
  }
  return tag;
}

@override
get keys => info_.byName.keys;

@override
get length => info_.byName.length;

remove(key) {
  throw new UnsupportedError("remove() not supported by \${info_.messageName}");
}
''');
      }

      generateFieldsAccessorsMutators(out);
    });
    out.println();
  }

  // Returns true if the message type has any required fields.  If it doesn't,
  // we can optimize out calls to its isInitialized()/_findInvalidFields()
  // methods.
  //
  // already_seen is used to avoid checking the same type multiple times
  // (and also to protect against unbounded recursion).
  bool _hasRequiredFields(MessageGenerator type, Set alreadySeen) {
    if (alreadySeen.contains(type.fqname)) {
      // The type is already in cache.  This means that either:
      // a. The type has no required fields.
      // b. We are in the midst of checking if the type has required fields,
      //    somewhere up the stack.  In this case, we know that if the type
      //    has any required fields, they'll be found when we return to it,
      //    and the whole call to HasRequiredFields() will return true.
      //    Therefore, we don't have to check if this type has required fields
      //    here.
      return false;
    }
    alreadySeen.add(type.fqname);
    // If the type has extensions, an extension with message type could contain
    // required fields, so we have to be conservative and assume such an
    // extension exists.
    if (type._descriptor.extensionRange.length > 0) {
      return true;
    }

    for (ProtobufField field in type._fieldList) {
      if (field.required) {
        return true;
      }
      if (field.message) {
        ProtobufContainer messageType = _context[field.typeName];
        if (messageType != null && messageType is MessageGenerator) {
          if (_hasRequiredFields(messageType, alreadySeen)) {
            return true;
          }
        }
      }
    }
    return false;
  }

  void generateFieldsAccessorsMutators(IndentingWriter out) {
    for (ProtobufField field in _fieldList) {
      out.println();
      String identifier = field.externalFieldName;
      String hasIdentifier = "has" + field.titlecaseFieldName;
      String clearIdentifier = "clear" + field.titlecaseFieldName;
      if (field.single) {
        while (_methodNames.contains(identifier) ||
               _methodNames.contains(hasIdentifier) ||
               _methodNames.contains(clearIdentifier)) {
          identifier += '_' + field.number.toString();
          hasIdentifier += '_' + field.number.toString();
          clearIdentifier += '_' + field.number.toString();
        }
        _methodNames.add(identifier);
        _methodNames.add(hasIdentifier);
        _methodNames.add(clearIdentifier);
      } else {
        while (_methodNames.contains(identifier)) {
          identifier += '_' + field.number.toString();
        }
        _methodNames.add(identifier);
      }
      var fieldTypeString = field.typeStringForPackage(package);
      out.println('${fieldTypeString} get ${identifier}'
          '${SP}=>${SP}getField(${field.number});');
      if (field.single) {
        out.println('void set ${identifier}'
            '(${fieldTypeString} v)${SP}'
            '{${SP}setField(${field.number},${SP}v);${SP}}');
        out.println('bool $hasIdentifier()${SP}=>'
            '${SP}hasField(${field.number});');
        out.println('void $clearIdentifier()${SP}=>'
            '${SP}clearField(${field.number});');
      }
    }
  }
}

// Copyright(c) 2013, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library test_util;

import 'package:fixnum/fixnum.dart';
import 'package:protobuf/protobuf.dart';
import 'package:unittest/unittest.dart';

import '../out/protos/google/protobuf/unittest_import.pb.dart';
import '../out/protos/google/protobuf/test_pkg.pb.dart';

Int64 make64(lo, [hi = null]) {
  if (hi == null) hi = lo < 0 ? -1 : 0;
  return new Int64.fromInts(hi, lo);
}

expect64(lo, [hi = null]) {
  final Int64 expected = make64(lo, hi);
  return predicate((Int64 actual) => actual == expected);
}

void assertAllExtensionsSet(TestAllExtensions message) {
  // TODO(antonm): introduce hasExtension matcher and other domain
  // specific ones.
  expect(message.hasExtension(Test_pkg.optionalInt32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalInt64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalUint32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalUint64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalSint32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalSint64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalFixed32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalFixed64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalSfixed32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalSfixed64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalFloatExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalDoubleExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalBoolExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalStringExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalBytesExtension), isTrue);

  expect(message.hasExtension(Test_pkg.optionalGroupExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalNestedMessageExtension), isTrue);
  expect(
      message.hasExtension(Test_pkg.optionalForeignMessageExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalImportMessageExtension), isTrue);

  expect(message.getExtension(Test_pkg.optionalGroupExtension).hasA(), isTrue);
  expect(message.getExtension(Test_pkg.optionalNestedMessageExtension).hasBb(),
      isTrue);
  expect(message.getExtension(Test_pkg.optionalForeignMessageExtension).hasC(),
      isTrue);
  expect(message.getExtension(Test_pkg.optionalImportMessageExtension).hasD(),
      isTrue);

  expect(message.hasExtension(Test_pkg.optionalNestedEnumExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalForeignEnumExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalImportEnumExtension), isTrue);

  expect(message.hasExtension(Test_pkg.optionalStringPieceExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalCordExtension), isTrue);

  expect(message.getExtension(Test_pkg.optionalInt32Extension), 101);
  expect(message.getExtension(Test_pkg.optionalInt64Extension), expect64(102));
  expect(message.getExtension(Test_pkg.optionalUint32Extension), 103);
  expect(message.getExtension(Test_pkg.optionalUint64Extension), expect64(104));
  expect(message.getExtension(Test_pkg.optionalSint32Extension), 105);
  expect(message.getExtension(Test_pkg.optionalSint64Extension), expect64(106));
  expect(message.getExtension(Test_pkg.optionalFixed32Extension), 107);
  expect(
      message.getExtension(Test_pkg.optionalFixed64Extension), expect64(108));
  expect(message.getExtension(Test_pkg.optionalSfixed32Extension), 109);
  expect(
      message.getExtension(Test_pkg.optionalSfixed64Extension), expect64(110));
  expect(message.getExtension(Test_pkg.optionalFloatExtension), 111.0);
  expect(message.getExtension(Test_pkg.optionalDoubleExtension), 112.0);
  expect(message.getExtension(Test_pkg.optionalBoolExtension), true);
  expect(message.getExtension(Test_pkg.optionalStringExtension), '115');
  expect(
      message.getExtension(Test_pkg.optionalBytesExtension), '116'.codeUnits);

  expect(message.getExtension(Test_pkg.optionalGroupExtension).a, 117);
  expect(message.getExtension(Test_pkg.optionalNestedMessageExtension).bb, 118);
  expect(message.getExtension(Test_pkg.optionalForeignMessageExtension).c, 119);
  expect(message.getExtension(Test_pkg.optionalImportMessageExtension).d, 120);

  expect(message.getExtension(Test_pkg.optionalNestedEnumExtension),
      TestAllTypes_NestedEnum.BAZ);
  expect(message.getExtension(Test_pkg.optionalForeignEnumExtension),
      ForeignEnum.FOREIGN_BAZ);
  expect(message.getExtension(Test_pkg.optionalImportEnumExtension),
      ImportEnum.IMPORT_BAZ);

  expect(message.getExtension(Test_pkg.optionalStringPieceExtension), '124');
  expect(message.getExtension(Test_pkg.optionalCordExtension), '125');

  // -----------------------------------------------------------------

  expect(message.getExtension(Test_pkg.repeatedInt32Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedInt64Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedUint32Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedUint64Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedSint32Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedSint64Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedFixed32Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedFixed64Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedSfixed32Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedSfixed64Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedFloatExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedDoubleExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedBoolExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedStringExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedBytesExtension).length, 2);

  expect(message.getExtension(Test_pkg.repeatedGroupExtension).length, 2);
  expect(
      message.getExtension(Test_pkg.repeatedNestedMessageExtension).length, 2);
  expect(
      message.getExtension(Test_pkg.repeatedForeignMessageExtension).length, 2);
  expect(
      message.getExtension(Test_pkg.repeatedImportMessageExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedNestedEnumExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedForeignEnumExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedImportEnumExtension).length, 2);

  expect(message.getExtension(Test_pkg.repeatedStringPieceExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedCordExtension).length, 2);

  expect(message.getExtension(Test_pkg.repeatedInt32Extension)[0], 201);
  expect(
      message.getExtension(Test_pkg.repeatedInt64Extension)[0], expect64(202));
  expect(message.getExtension(Test_pkg.repeatedUint32Extension)[0], 203);
  expect(
      message.getExtension(Test_pkg.repeatedUint64Extension)[0], expect64(204));
  expect(message.getExtension(Test_pkg.repeatedSint32Extension)[0], 205);
  expect(
      message.getExtension(Test_pkg.repeatedSint64Extension)[0], expect64(206));
  expect(message.getExtension(Test_pkg.repeatedFixed32Extension)[0], 207);
  expect(message.getExtension(Test_pkg.repeatedFixed64Extension)[0],
      expect64(208));
  expect(message.getExtension(Test_pkg.repeatedSfixed32Extension)[0], 209);
  expect(message.getExtension(Test_pkg.repeatedSfixed64Extension)[0],
      expect64(210));
  expect(message.getExtension(Test_pkg.repeatedFloatExtension)[0], 211.0);
  expect(message.getExtension(Test_pkg.repeatedDoubleExtension)[0], 212.0);
  expect(message.getExtension(Test_pkg.repeatedBoolExtension)[0], true);
  expect(message.getExtension(Test_pkg.repeatedStringExtension)[0], '215');
  expect(message.getExtension(Test_pkg.repeatedBytesExtension)[0],
      '216'.codeUnits);

  expect(message.getExtension(Test_pkg.repeatedGroupExtension)[0].a, 217);
  expect(
      message.getExtension(Test_pkg.repeatedNestedMessageExtension)[0].bb, 218);
  expect(
      message.getExtension(Test_pkg.repeatedForeignMessageExtension)[0].c, 219);
  expect(
      message.getExtension(Test_pkg.repeatedImportMessageExtension)[0].d, 220);

  expect(message.getExtension(Test_pkg.repeatedNestedEnumExtension)[0],
      TestAllTypes_NestedEnum.BAR);
  expect(message.getExtension(Test_pkg.repeatedForeignEnumExtension)[0],
      ForeignEnum.FOREIGN_BAR);
  expect(message.getExtension(Test_pkg.repeatedImportEnumExtension)[0],
      ImportEnum.IMPORT_BAR);

  expect(message.getExtension(Test_pkg.repeatedStringPieceExtension)[0], '224');
  expect(message.getExtension(Test_pkg.repeatedCordExtension)[0], '225');

  expect(message.getExtension(Test_pkg.repeatedInt32Extension)[1], 301);
  expect(
      message.getExtension(Test_pkg.repeatedInt64Extension)[1], expect64(302));
  expect(message.getExtension(Test_pkg.repeatedUint32Extension)[1], 303);
  expect(
      message.getExtension(Test_pkg.repeatedUint64Extension)[1], expect64(304));
  expect(message.getExtension(Test_pkg.repeatedSint32Extension)[1], 305);
  expect(
      message.getExtension(Test_pkg.repeatedSint64Extension)[1], expect64(306));
  expect(message.getExtension(Test_pkg.repeatedFixed32Extension)[1], 307);
  expect(message.getExtension(Test_pkg.repeatedFixed64Extension)[1],
      expect64(308));
  expect(message.getExtension(Test_pkg.repeatedSfixed32Extension)[1], 309);
  expect(message.getExtension(Test_pkg.repeatedSfixed64Extension)[1],
      expect64(310));
  expect(message.getExtension(Test_pkg.repeatedFloatExtension)[1], 311.0);
  expect(message.getExtension(Test_pkg.repeatedDoubleExtension)[1], 312.0);
  expect(message.getExtension(Test_pkg.repeatedBoolExtension)[1], false);
  expect(message.getExtension(Test_pkg.repeatedStringExtension)[1], '315');
  expect(message.getExtension(Test_pkg.repeatedBytesExtension)[1],
      '316'.codeUnits);

  expect(message.getExtension(Test_pkg.repeatedGroupExtension)[1].a, 317);
  expect(
      message.getExtension(Test_pkg.repeatedNestedMessageExtension)[1].bb, 318);
  expect(
      message.getExtension(Test_pkg.repeatedForeignMessageExtension)[1].c, 319);
  expect(
      message.getExtension(Test_pkg.repeatedImportMessageExtension)[1].d, 320);

  expect(message.getExtension(Test_pkg.repeatedNestedEnumExtension)[1],
      TestAllTypes_NestedEnum.BAZ);
  expect(message.getExtension(Test_pkg.repeatedForeignEnumExtension)[1],
      ForeignEnum.FOREIGN_BAZ);
  expect(message.getExtension(Test_pkg.repeatedImportEnumExtension)[1],
      ImportEnum.IMPORT_BAZ);

  expect(message.getExtension(Test_pkg.repeatedStringPieceExtension)[1], '324');
  expect(message.getExtension(Test_pkg.repeatedCordExtension)[1], '325');

  // -----------------------------------------------------------------

  expect(message.hasExtension(Test_pkg.defaultInt32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultInt64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultUint32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultUint64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultSint32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultSint64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultFixed32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultFixed64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultSfixed32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultSfixed64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultFloatExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultDoubleExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultBoolExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultStringExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultBytesExtension), isTrue);

  expect(message.hasExtension(Test_pkg.defaultNestedEnumExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultForeignEnumExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultImportEnumExtension), isTrue);

  expect(message.hasExtension(Test_pkg.defaultStringPieceExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultCordExtension), isTrue);
  expect(message.getExtension(Test_pkg.defaultInt32Extension), 401);
  expect(message.getExtension(Test_pkg.defaultInt64Extension), expect64(402));
  expect(message.getExtension(Test_pkg.defaultUint32Extension), 403);
  expect(message.getExtension(Test_pkg.defaultUint64Extension), expect64(404));
  expect(message.getExtension(Test_pkg.defaultSint32Extension), 405);
  expect(message.getExtension(Test_pkg.defaultSint64Extension), expect64(406));
  expect(message.getExtension(Test_pkg.defaultFixed32Extension), 407);
  expect(message.getExtension(Test_pkg.defaultFixed64Extension), expect64(408));
  expect(message.getExtension(Test_pkg.defaultSfixed32Extension), 409);
  expect(
      message.getExtension(Test_pkg.defaultSfixed64Extension), expect64(410));
  expect(message.getExtension(Test_pkg.defaultFloatExtension), 411.0);
  expect(message.getExtension(Test_pkg.defaultDoubleExtension), 412.0);
  expect(message.getExtension(Test_pkg.defaultBoolExtension), false);
  expect(message.getExtension(Test_pkg.defaultStringExtension), '415');
  expect(message.getExtension(Test_pkg.defaultBytesExtension), '416'.codeUnits);

  expect(message.getExtension(Test_pkg.defaultNestedEnumExtension),
      TestAllTypes_NestedEnum.FOO);
  expect(message.getExtension(Test_pkg.defaultForeignEnumExtension),
      ForeignEnum.FOREIGN_FOO);
  expect(message.getExtension(Test_pkg.defaultImportEnumExtension),
      ImportEnum.IMPORT_FOO);

  expect(message.getExtension(Test_pkg.defaultStringPieceExtension), '424');
  expect(message.getExtension(Test_pkg.defaultCordExtension), '425');
}

void assertAllFieldsSet(TestAllTypes message) {
  expect(message.hasOptionalInt32(), isTrue);
  expect(message.hasOptionalInt64(), isTrue);
  expect(message.hasOptionalUint32(), isTrue);
  expect(message.hasOptionalUint64(), isTrue);
  expect(message.hasOptionalSint32(), isTrue);
  expect(message.hasOptionalSint64(), isTrue);
  expect(message.hasOptionalFixed32(), isTrue);
  expect(message.hasOptionalFixed64(), isTrue);
  expect(message.hasOptionalSfixed32(), isTrue);
  expect(message.hasOptionalSfixed64(), isTrue);
  expect(message.hasOptionalFloat(), isTrue);
  expect(message.hasOptionalDouble(), isTrue);
  expect(message.hasOptionalBool(), isTrue);
  expect(message.hasOptionalString(), isTrue);
  expect(message.hasOptionalBytes(), isTrue);

  expect(message.hasOptionalGroup(), isTrue);
  expect(message.hasOptionalNestedMessage(), isTrue);
  expect(message.hasOptionalForeignMessage(), isTrue);
  expect(message.hasOptionalImportMessage(), isTrue);

  expect(message.optionalGroup.hasA(), isTrue);
  expect(message.optionalNestedMessage.hasBb(), isTrue);
  expect(message.optionalForeignMessage.hasC(), isTrue);
  expect(message.optionalImportMessage.hasD(), isTrue);

  expect(message.hasOptionalNestedEnum(), isTrue);
  expect(message.hasOptionalForeignEnum(), isTrue);
  expect(message.hasOptionalImportEnum(), isTrue);

  expect(message.hasOptionalStringPiece(), isTrue);
  expect(message.hasOptionalCord(), isTrue);

  expect(message.optionalInt32, 101);
  expect(message.optionalInt64, expect64(102));
  expect(message.optionalUint32, 103);
  expect(message.optionalUint64, expect64(104));
  expect(message.optionalSint32, 105);
  expect(message.optionalSint64, expect64(106));
  expect(message.optionalFixed32, 107);
  expect(message.optionalFixed64, expect64(108));
  expect(message.optionalSfixed32, 109);
  expect(message.optionalSfixed64, expect64(110));
  expect(message.optionalFloat, 111.0);
  expect(message.optionalDouble, 112.0);
  expect(message.optionalBool, true);
  expect(message.optionalString, '115');
  expect(message.optionalBytes, '116'.codeUnits);

  expect(message.optionalGroup.a, 117);
  expect(message.optionalNestedMessage.bb, 118);
  expect(message.optionalForeignMessage.c, 119);
  expect(message.optionalImportMessage.d, 120);

  expect(message.optionalNestedEnum, TestAllTypes_NestedEnum.BAZ);
  expect(message.optionalForeignEnum, ForeignEnum.FOREIGN_BAZ);
  expect(message.optionalImportEnum, ImportEnum.IMPORT_BAZ);

  expect(message.optionalStringPiece, '124');
  expect(message.optionalCord, '125');

  // -----------------------------------------------------------------

  expect(message.repeatedInt32.length, 2);
  expect(message.repeatedInt64.length, 2);
  expect(message.repeatedUint32.length, 2);
  expect(message.repeatedUint64.length, 2);
  expect(message.repeatedSint32.length, 2);
  expect(message.repeatedSint64.length, 2);
  expect(message.repeatedFixed32.length, 2);
  expect(message.repeatedFixed64.length, 2);
  expect(message.repeatedSfixed32.length, 2);
  expect(message.repeatedSfixed64.length, 2);
  expect(message.repeatedFloat.length, 2);
  expect(message.repeatedDouble.length, 2);
  expect(message.repeatedBool.length, 2);
  expect(message.repeatedString.length, 2);
  expect(message.repeatedBytes.length, 2);

  expect(message.repeatedGroup.length, 2);
  expect(message.repeatedNestedMessage.length, 2);
  expect(message.repeatedForeignMessage.length, 2);
  expect(message.repeatedImportMessage.length, 2);
  expect(message.repeatedNestedEnum.length, 2);
  expect(message.repeatedForeignEnum.length, 2);
  expect(message.repeatedImportEnum.length, 2);

  expect(message.repeatedStringPiece.length, 2);
  expect(message.repeatedCord.length, 2);

  expect(message.repeatedInt32[0], 201);
  expect(message.repeatedInt64[0], expect64(202));
  expect(message.repeatedUint32[0], 203);
  expect(message.repeatedUint64[0], expect64(204));
  expect(message.repeatedSint32[0], 205);
  expect(message.repeatedSint64[0], expect64(206));
  expect(message.repeatedFixed32[0], 207);
  expect(message.repeatedFixed64[0], expect64(208));
  expect(message.repeatedSfixed32[0], 209);
  expect(message.repeatedSfixed64[0], expect64(210));
  expect(message.repeatedFloat[0], 211.0);
  expect(message.repeatedDouble[0], 212.0);
  expect(message.repeatedBool[0], true);
  expect(message.repeatedString[0], '215');
  expect(message.repeatedBytes[0], '216'.codeUnits);

  expect(message.repeatedGroup[0].a, 217);
  expect(message.repeatedNestedMessage[0].bb, 218);
  expect(message.repeatedForeignMessage[0].c, 219);
  expect(message.repeatedImportMessage[0].d, 220);

  expect(message.repeatedNestedEnum[0], TestAllTypes_NestedEnum.BAR);
  expect(message.repeatedForeignEnum[0], ForeignEnum.FOREIGN_BAR);
  expect(message.repeatedImportEnum[0], ImportEnum.IMPORT_BAR);

  expect(message.repeatedStringPiece[0], '224');
  expect(message.repeatedCord[0], '225');

  expect(message.repeatedInt32[1], 301);
  expect(message.repeatedInt64[1], expect64(302));
  expect(message.repeatedUint32[1], 303);
  expect(message.repeatedUint64[1], expect64(304));
  expect(message.repeatedSint32[1], 305);
  expect(message.repeatedSint64[1], expect64(306));
  expect(message.repeatedFixed32[1], 307);
  expect(message.repeatedFixed64[1], expect64(308));
  expect(message.repeatedSfixed32[1], 309);
  expect(message.repeatedSfixed64[1], expect64(310));
  expect(message.repeatedFloat[1], 311.0);
  expect(message.repeatedDouble[1], 312.0);
  expect(message.repeatedBool[1], false);
  expect(message.repeatedString[1], '315');
  expect(message.repeatedBytes[1], '316'.codeUnits);

  expect(message.repeatedGroup[1].a, 317);
  expect(message.repeatedNestedMessage[1].bb, 318);
  expect(message.repeatedForeignMessage[1].c, 319);
  expect(message.repeatedImportMessage[1].d, 320);

  expect(message.repeatedNestedEnum[1], TestAllTypes_NestedEnum.BAZ);
  expect(message.repeatedForeignEnum[1], ForeignEnum.FOREIGN_BAZ);
  expect(message.repeatedImportEnum[1], ImportEnum.IMPORT_BAZ);

  expect(message.repeatedStringPiece[1], '324');
  expect(message.repeatedCord[1], '325');

  // -----------------------------------------------------------------

  expect(message.hasDefaultInt32(), isTrue);
  expect(message.hasDefaultInt64(), isTrue);
  expect(message.hasDefaultUint32(), isTrue);
  expect(message.hasDefaultUint64(), isTrue);
  expect(message.hasDefaultSint32(), isTrue);
  expect(message.hasDefaultSint64(), isTrue);
  expect(message.hasDefaultFixed32(), isTrue);
  expect(message.hasDefaultFixed64(), isTrue);
  expect(message.hasDefaultSfixed32(), isTrue);
  expect(message.hasDefaultSfixed64(), isTrue);
  expect(message.hasDefaultFloat(), isTrue);
  expect(message.hasDefaultDouble(), isTrue);
  expect(message.hasDefaultBool(), isTrue);
  expect(message.hasDefaultString(), isTrue);
  expect(message.hasDefaultBytes(), isTrue);

  expect(message.hasDefaultNestedEnum(), isTrue);
  expect(message.hasDefaultForeignEnum(), isTrue);
  expect(message.hasDefaultImportEnum(), isTrue);

  expect(message.hasDefaultStringPiece(), isTrue);
  expect(message.hasDefaultCord(), isTrue);

  expect(message.defaultInt32, 401);
  expect(message.defaultInt64, expect64(402));
  expect(message.defaultUint32, 403);
  expect(message.defaultUint64, expect64(404));
  expect(message.defaultSint32, 405);
  expect(message.defaultSint64, expect64(406));
  expect(message.defaultFixed32, 407);
  expect(message.defaultFixed64, expect64(408));
  expect(message.defaultSfixed32, 409);
  expect(message.defaultSfixed64, expect64(410));
  expect(message.defaultFloat, 411.0);
  expect(message.defaultDouble, 412.0);
  expect(message.defaultBool, false);
  expect(message.defaultString, '415');
  expect(message.defaultBytes, '416'.codeUnits);

  expect(message.defaultNestedEnum, TestAllTypes_NestedEnum.FOO);
  expect(message.defaultForeignEnum, ForeignEnum.FOREIGN_FOO);
  expect(message.defaultImportEnum, ImportEnum.IMPORT_FOO);

  expect(message.defaultStringPiece, '424');
  expect(message.defaultCord, '425');
}

void assertClear(TestAllTypes message) {
  // hasBlah() should initially be false for all optional fields.
  expect(message.hasOptionalInt32(), isFalse);
  expect(message.hasOptionalInt64(), isFalse);
  expect(message.hasOptionalUint32(), isFalse);
  expect(message.hasOptionalUint64(), isFalse);
  expect(message.hasOptionalSint32(), isFalse);
  expect(message.hasOptionalSint64(), isFalse);
  expect(message.hasOptionalFixed32(), isFalse);
  expect(message.hasOptionalFixed64(), isFalse);
  expect(message.hasOptionalSfixed32(), isFalse);
  expect(message.hasOptionalSfixed64(), isFalse);
  expect(message.hasOptionalFloat(), isFalse);
  expect(message.hasOptionalDouble(), isFalse);
  expect(message.hasOptionalBool(), isFalse);
  expect(message.hasOptionalString(), isFalse);
  expect(message.hasOptionalBytes(), isFalse);

  expect(message.hasOptionalGroup(), isFalse);
  expect(message.hasOptionalNestedMessage(), isFalse);
  expect(message.hasOptionalForeignMessage(), isFalse);
  expect(message.hasOptionalImportMessage(), isFalse);

  expect(message.hasOptionalNestedEnum(), isFalse);
  expect(message.hasOptionalForeignEnum(), isFalse);
  expect(message.hasOptionalImportEnum(), isFalse);

  expect(message.hasOptionalStringPiece(), isFalse);
  expect(message.hasOptionalCord(), isFalse);

  // Optional fields without defaults are set to zero or something like it.
  expect(message.optionalInt32, 0);
  expect(message.optionalInt64, expect64(0));
  expect(message.optionalUint32, 0);
  expect(message.optionalUint64, expect64(0));
  expect(message.optionalSint32, 0);
  expect(message.optionalSint64, expect64(0));
  expect(message.optionalFixed32, 0);
  expect(message.optionalFixed64, expect64(0));
  expect(message.optionalSfixed32, 0);
  expect(message.optionalSfixed64, expect64(0));
  expect(message.optionalFloat, 0);
  expect(message.optionalDouble, 0);
  expect(message.optionalBool, false);
  expect(message.optionalString, '');
  expect(message.optionalBytes, <int>[]);

  // Embedded messages should also be clear.
  expect(message.optionalGroup.hasA(), isFalse);
  expect(message.optionalNestedMessage.hasBb(), isFalse);
  expect(message.optionalForeignMessage.hasC(), isFalse);
  expect(message.optionalImportMessage.hasD(), isFalse);

  expect(message.optionalGroup.a, 0);
  expect(message.optionalNestedMessage.bb, 0);
  expect(message.optionalForeignMessage.c, 0);
  expect(message.optionalImportMessage.d, 0);

  // Enums without defaults are set to the first value in the enum.
  expect(message.optionalNestedEnum, TestAllTypes_NestedEnum.FOO);
  expect(message.optionalForeignEnum, ForeignEnum.FOREIGN_FOO);
  expect(message.optionalImportEnum, ImportEnum.IMPORT_FOO);

  expect(message.optionalStringPiece, '');
  expect(message.optionalCord, '');

  // Repeated fields are empty.
  expect(message.repeatedInt32.length, 0);
  expect(message.repeatedInt64.length, 0);
  expect(message.repeatedUint32.length, 0);
  expect(message.repeatedUint64.length, 0);
  expect(message.repeatedSint32.length, 0);
  expect(message.repeatedSint64.length, 0);
  expect(message.repeatedFixed32.length, 0);
  expect(message.repeatedFixed64.length, 0);
  expect(message.repeatedSfixed32.length, 0);
  expect(message.repeatedSfixed64.length, 0);
  expect(message.repeatedFloat.length, 0);
  expect(message.repeatedDouble.length, 0);
  expect(message.repeatedBool.length, 0);
  expect(message.repeatedString.length, 0);
  expect(message.repeatedBytes.length, 0);

  expect(message.repeatedGroup.length, 0);
  expect(message.repeatedNestedMessage.length, 0);
  expect(message.repeatedForeignMessage.length, 0);
  expect(message.repeatedImportMessage.length, 0);
  expect(message.repeatedNestedEnum.length, 0);
  expect(message.repeatedForeignEnum.length, 0);
  expect(message.repeatedImportEnum.length, 0);

  expect(message.repeatedStringPiece.length, 0);
  expect(message.repeatedCord.length, 0);

  // hasBlah() should also be false for all default fields.
  expect(message.hasDefaultInt32(), isFalse);
  expect(message.hasDefaultInt64(), isFalse);
  expect(message.hasDefaultUint32(), isFalse);
  expect(message.hasDefaultUint64(), isFalse);
  expect(message.hasDefaultSint32(), isFalse);
  expect(message.hasDefaultSint64(), isFalse);
  expect(message.hasDefaultFixed32(), isFalse);
  expect(message.hasDefaultFixed64(), isFalse);
  expect(message.hasDefaultSfixed32(), isFalse);
  expect(message.hasDefaultSfixed64(), isFalse);
  expect(message.hasDefaultFloat(), isFalse);
  expect(message.hasDefaultDouble(), isFalse);
  expect(message.hasDefaultBool(), isFalse);
  expect(message.hasDefaultString(), isFalse);
  expect(message.hasDefaultBytes(), isFalse);

  expect(message.hasDefaultNestedEnum(), isFalse);
  expect(message.hasDefaultForeignEnum(), isFalse);
  expect(message.hasDefaultImportEnum(), isFalse);

  expect(message.hasDefaultStringPiece(), isFalse);
  expect(message.hasDefaultCord(), isFalse);

  // Fields with defaults have their default values(duh).
  expect(message.defaultInt32, 41);
  expect(message.defaultInt64, expect64(42));
  expect(message.defaultUint32, 43);
  expect(message.defaultUint64, expect64(44));
  expect(message.defaultSint32, -45);
  expect(message.defaultSint64, expect64(46));
  expect(message.defaultFixed32, 47);
  expect(message.defaultFixed64, expect64(48));
  expect(message.defaultSfixed32, 49);
  expect(message.defaultSfixed64, expect64(-50));
  expect(message.defaultFloat, 51.5);
  expect(message.defaultDouble, 52e3);
  expect(message.defaultBool, isTrue);
  expect(message.defaultString, 'hello');
  expect(message.defaultBytes, 'world'.codeUnits);

  expect(message.defaultNestedEnum, TestAllTypes_NestedEnum.BAR);
  expect(message.defaultForeignEnum, ForeignEnum.FOREIGN_BAR);
  expect(message.defaultImportEnum, ImportEnum.IMPORT_BAR);

  expect(message.defaultStringPiece, 'abc');
  expect(message.defaultCord, '123');
}

void assertExtensionsClear(TestAllExtensions message) {
  // hasBlah() should initially be false for all optional fields.
  expect(message.hasExtension(Test_pkg.optionalInt32Extension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalInt64Extension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalUint32Extension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalUint64Extension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalSint32Extension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalSint64Extension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalFixed32Extension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalFixed64Extension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalSfixed32Extension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalSfixed64Extension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalFloatExtension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalDoubleExtension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalBoolExtension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalStringExtension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalBytesExtension), isFalse);

  expect(message.hasExtension(Test_pkg.optionalGroupExtension), isFalse);
  expect(
      message.hasExtension(Test_pkg.optionalNestedMessageExtension), isFalse);
  expect(
      message.hasExtension(Test_pkg.optionalForeignMessageExtension), isFalse);
  expect(
      message.hasExtension(Test_pkg.optionalImportMessageExtension), isFalse);

  expect(message.hasExtension(Test_pkg.optionalNestedEnumExtension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalForeignEnumExtension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalImportEnumExtension), isFalse);

  expect(message.hasExtension(Test_pkg.optionalStringPieceExtension), isFalse);
  expect(message.hasExtension(Test_pkg.optionalCordExtension), isFalse);

  // Optional fields without defaults are set to zero or something like it.
  expect(message.getExtension(Test_pkg.optionalInt32Extension), 0);
  expect(message.getExtension(Test_pkg.optionalInt64Extension), expect64(0));
  expect(message.getExtension(Test_pkg.optionalUint32Extension), 0);
  expect(message.getExtension(Test_pkg.optionalUint64Extension), expect64(0));
  expect(message.getExtension(Test_pkg.optionalSint32Extension), 0);
  expect(message.getExtension(Test_pkg.optionalSint64Extension), expect64(0));
  expect(message.getExtension(Test_pkg.optionalFixed32Extension), 0);
  expect(message.getExtension(Test_pkg.optionalFixed64Extension), expect64(0));
  expect(message.getExtension(Test_pkg.optionalSfixed32Extension), 0);
  expect(message.getExtension(Test_pkg.optionalSfixed64Extension), expect64(0));
  expect(message.getExtension(Test_pkg.optionalFloatExtension), 0.0);
  expect(message.getExtension(Test_pkg.optionalDoubleExtension), 0.0);
  expect(message.getExtension(Test_pkg.optionalBoolExtension), false);
  expect(message.getExtension(Test_pkg.optionalStringExtension), '');
  expect(message.getExtension(Test_pkg.optionalBytesExtension), <int>[]);

  // Embedded messages should also be clear.
  expect(message.getExtension(Test_pkg.optionalGroupExtension).hasA(), isFalse);
  expect(message.getExtension(Test_pkg.optionalNestedMessageExtension).hasBb(),
      isFalse);
  expect(message.getExtension(Test_pkg.optionalForeignMessageExtension).hasC(),
      isFalse);
  expect(message.getExtension(Test_pkg.optionalImportMessageExtension).hasD(),
      isFalse);

  expect(message.getExtension(Test_pkg.optionalGroupExtension).a, 0);
  expect(message.getExtension(Test_pkg.optionalNestedMessageExtension).bb, 0);
  expect(message.getExtension(Test_pkg.optionalForeignMessageExtension).c, 0);
  expect(message.getExtension(Test_pkg.optionalImportMessageExtension).d, 0);

  // Enums without defaults are set to the first value in the enum.
  expect(message.getExtension(Test_pkg.optionalNestedEnumExtension),
      TestAllTypes_NestedEnum.FOO);
  expect(message.getExtension(Test_pkg.optionalForeignEnumExtension),
      ForeignEnum.FOREIGN_FOO);
  expect(message.getExtension(Test_pkg.optionalImportEnumExtension),
      ImportEnum.IMPORT_FOO);

  expect(message.getExtension(Test_pkg.optionalStringPieceExtension), '');
  expect(message.getExtension(Test_pkg.optionalCordExtension), '');

  // Repeated fields are empty.
  expect(message.getExtension(Test_pkg.repeatedInt32Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedInt64Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedUint32Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedUint64Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedSint32Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedSint64Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedFixed32Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedFixed64Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedSfixed32Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedSfixed64Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedFloatExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedDoubleExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedBoolExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedStringExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedBytesExtension).length, 0);

  expect(message.getExtension(Test_pkg.repeatedGroupExtension).length, 0);
  expect(
      message.getExtension(Test_pkg.repeatedNestedMessageExtension).length, 0);
  expect(
      message.getExtension(Test_pkg.repeatedForeignMessageExtension).length, 0);
  expect(
      message.getExtension(Test_pkg.repeatedImportMessageExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedNestedEnumExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedForeignEnumExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedImportEnumExtension).length, 0);

  expect(message.getExtension(Test_pkg.repeatedStringPieceExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedCordExtension).length, 0);

  // Repeated fields are empty via getExtension().length.
  expect(message.getExtension(Test_pkg.repeatedInt32Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedInt64Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedUint32Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedUint64Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedSint32Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedSint64Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedFixed32Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedFixed64Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedSfixed32Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedSfixed64Extension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedFloatExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedDoubleExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedBoolExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedStringExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedBytesExtension).length, 0);

  expect(message.getExtension(Test_pkg.repeatedGroupExtension).length, 0);
  expect(
      message.getExtension(Test_pkg.repeatedNestedMessageExtension).length, 0);
  expect(
      message.getExtension(Test_pkg.repeatedForeignMessageExtension).length, 0);
  expect(
      message.getExtension(Test_pkg.repeatedImportMessageExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedNestedEnumExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedForeignEnumExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedImportEnumExtension).length, 0);

  expect(message.getExtension(Test_pkg.repeatedStringPieceExtension).length, 0);
  expect(message.getExtension(Test_pkg.repeatedCordExtension).length, 0);

  // hasBlah() should also be false for all default fields.
  expect(message.hasExtension(Test_pkg.defaultInt32Extension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultInt64Extension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultUint32Extension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultUint64Extension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultSint32Extension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultSint64Extension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultFixed32Extension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultFixed64Extension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultSfixed32Extension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultSfixed64Extension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultFloatExtension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultDoubleExtension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultBoolExtension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultStringExtension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultBytesExtension), isFalse);

  expect(message.hasExtension(Test_pkg.defaultNestedEnumExtension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultForeignEnumExtension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultImportEnumExtension), isFalse);

  expect(message.hasExtension(Test_pkg.defaultStringPieceExtension), isFalse);
  expect(message.hasExtension(Test_pkg.defaultCordExtension), isFalse);

  // Fields with defaults have their default values (duh).
  expect(message.getExtension(Test_pkg.defaultInt32Extension), 41);
  expect(message.getExtension(Test_pkg.defaultInt64Extension), expect64(42));
  expect(message.getExtension(Test_pkg.defaultUint32Extension), 43);
  expect(message.getExtension(Test_pkg.defaultUint64Extension), expect64(44));
  expect(message.getExtension(Test_pkg.defaultSint32Extension), -45);
  expect(message.getExtension(Test_pkg.defaultSint64Extension), expect64(46));
  expect(message.getExtension(Test_pkg.defaultFixed32Extension), 47);
  expect(message.getExtension(Test_pkg.defaultFixed64Extension), expect64(48));
  expect(message.getExtension(Test_pkg.defaultSfixed32Extension), 49);
  expect(
      message.getExtension(Test_pkg.defaultSfixed64Extension), expect64(-50));
  expect(message.getExtension(Test_pkg.defaultFloatExtension), 51.5);
  expect(message.getExtension(Test_pkg.defaultDoubleExtension), 52e3);
  expect(message.getExtension(Test_pkg.defaultBoolExtension), true);
  expect(message.getExtension(Test_pkg.defaultStringExtension), 'hello');
  expect(
      message.getExtension(Test_pkg.defaultBytesExtension), 'world'.codeUnits);

  expect(message.getExtension(Test_pkg.defaultNestedEnumExtension),
      TestAllTypes_NestedEnum.BAR);
  expect(message.getExtension(Test_pkg.defaultForeignEnumExtension),
      ForeignEnum.FOREIGN_BAR);
  expect(message.getExtension(Test_pkg.defaultImportEnumExtension),
      ImportEnum.IMPORT_BAR);

  expect(message.getExtension(Test_pkg.defaultStringPieceExtension), 'abc');
  expect(message.getExtension(Test_pkg.defaultCordExtension), '123');
}

void assertPackedExtensionsSet(TestPackedExtensions message) {
  expect(message.getExtension(Test_pkg.packedInt32Extension).length, 2);
  expect(message.getExtension(Test_pkg.packedInt64Extension).length, 2);
  expect(message.getExtension(Test_pkg.packedUint32Extension).length, 2);
  expect(message.getExtension(Test_pkg.packedUint64Extension).length, 2);
  expect(message.getExtension(Test_pkg.packedSint32Extension).length, 2);
  expect(message.getExtension(Test_pkg.packedSint64Extension).length, 2);
  expect(message.getExtension(Test_pkg.packedFixed32Extension).length, 2);
  expect(message.getExtension(Test_pkg.packedFixed64Extension).length, 2);
  expect(message.getExtension(Test_pkg.packedSfixed32Extension).length, 2);
  expect(message.getExtension(Test_pkg.packedSfixed64Extension).length, 2);
  expect(message.getExtension(Test_pkg.packedFloatExtension).length, 2);
  expect(message.getExtension(Test_pkg.packedDoubleExtension).length, 2);
  expect(message.getExtension(Test_pkg.packedBoolExtension).length, 2);
  expect(message.getExtension(Test_pkg.packedEnumExtension).length, 2);
  expect(message.getExtension(Test_pkg.packedInt32Extension)[0], 601);
  expect(message.getExtension(Test_pkg.packedInt64Extension)[0], expect64(602));
  expect(message.getExtension(Test_pkg.packedUint32Extension)[0], 603);
  expect(
      message.getExtension(Test_pkg.packedUint64Extension)[0], expect64(604));
  expect(message.getExtension(Test_pkg.packedSint32Extension)[0], 605);
  expect(
      message.getExtension(Test_pkg.packedSint64Extension)[0], expect64(606));
  expect(message.getExtension(Test_pkg.packedFixed32Extension)[0], 607);
  expect(
      message.getExtension(Test_pkg.packedFixed64Extension)[0], expect64(608));
  expect(message.getExtension(Test_pkg.packedSfixed32Extension)[0], 609);
  expect(
      message.getExtension(Test_pkg.packedSfixed64Extension)[0], expect64(610));
  expect(message.getExtension(Test_pkg.packedFloatExtension)[0], 611.0);
  expect(message.getExtension(Test_pkg.packedDoubleExtension)[0], 612.0);
  expect(message.getExtension(Test_pkg.packedBoolExtension)[0], true);
  expect(message.getExtension(Test_pkg.packedEnumExtension)[0],
      ForeignEnum.FOREIGN_BAR);
  expect(message.getExtension(Test_pkg.packedInt32Extension)[1], 701);
  expect(message.getExtension(Test_pkg.packedInt64Extension)[1], expect64(702));
  expect(message.getExtension(Test_pkg.packedUint32Extension)[1], 703);
  expect(
      message.getExtension(Test_pkg.packedUint64Extension)[1], expect64(704));
  expect(message.getExtension(Test_pkg.packedSint32Extension)[1], 705);
  expect(
      message.getExtension(Test_pkg.packedSint64Extension)[1], expect64(706));
  expect(message.getExtension(Test_pkg.packedFixed32Extension)[1], 707);
  expect(
      message.getExtension(Test_pkg.packedFixed64Extension)[1], expect64(708));
  expect(message.getExtension(Test_pkg.packedSfixed32Extension)[1], 709);
  expect(
      message.getExtension(Test_pkg.packedSfixed64Extension)[1], expect64(710));
  expect(message.getExtension(Test_pkg.packedFloatExtension)[1], 711.0);
  expect(message.getExtension(Test_pkg.packedDoubleExtension)[1], 712.0);
  expect(message.getExtension(Test_pkg.packedBoolExtension)[1], false);
  expect(message.getExtension(Test_pkg.packedEnumExtension)[1],
      ForeignEnum.FOREIGN_BAZ);
}

/**
 * Assert (using expect} that all fields of [message] are set to the values
 * assigned by [setPackedFields].
 */
void assertPackedFieldsSet(TestPackedTypes message) {
  expect(message.packedInt32.length, 2);
  expect(message.packedInt64.length, 2);
  expect(message.packedUint32.length, 2);
  expect(message.packedUint64.length, 2);
  expect(message.packedSint32.length, 2);
  expect(message.packedSint64.length, 2);
  expect(message.packedFixed32.length, 2);
  expect(message.packedFixed64.length, 2);
  expect(message.packedSfixed32.length, 2);
  expect(message.packedSfixed64.length, 2);
  expect(message.packedFloat.length, 2);
  expect(message.packedDouble.length, 2);
  expect(message.packedBool.length, 2);
  expect(message.packedEnum.length, 2);
  expect(message.packedInt32[0], 601);
  expect(message.packedInt64[0], expect64(602));
  expect(message.packedUint32[0], 603);
  expect(message.packedUint64[0], expect64(604));
  expect(message.packedSint32[0], 605);
  expect(message.packedSint64[0], expect64(606));
  expect(message.packedFixed32[0], 607);
  expect(message.packedFixed64[0], expect64(608));
  expect(message.packedSfixed32[0], 609);
  expect(message.packedSfixed64[0], expect64(610));
  expect(message.packedFloat[0], 611.0);
  expect(message.packedDouble[0], 612.0);
  expect(message.packedBool[0], true);
  expect(message.packedEnum[0], ForeignEnum.FOREIGN_BAR);
  expect(message.packedInt32[1], 701);
  expect(message.packedInt64[1], expect64(702));
  expect(message.packedUint32[1], 703);
  expect(message.packedUint64[1], expect64(704));
  expect(message.packedSint32[1], 705);
  expect(message.packedSint64[1], expect64(706));
  expect(message.packedFixed32[1], 707);
  expect(message.packedFixed64[1], expect64(708));
  expect(message.packedSfixed32[1], 709);
  expect(message.packedSfixed64[1], expect64(710));
  expect(message.packedFloat[1], 711.0);
  expect(message.packedDouble[1], 712.0);
  expect(message.packedBool[1], false);
  expect(message.packedEnum[1], ForeignEnum.FOREIGN_BAZ);
}

void assertRepeatedExtensionsModified(TestAllExtensions message) {
  expect(message.hasExtension(Test_pkg.optionalInt32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalInt64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalUint32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalUint64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalSint32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalSint64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalFixed32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalFixed64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalSfixed32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalSfixed64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalFloatExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalDoubleExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalBoolExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalStringExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalBytesExtension), isTrue);

  expect(message.hasExtension(Test_pkg.optionalGroupExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalNestedMessageExtension), isTrue);
  expect(
      message.hasExtension(Test_pkg.optionalForeignMessageExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalImportMessageExtension), isTrue);

  expect(message.getExtension(Test_pkg.optionalGroupExtension).hasA(), isTrue);
  expect(message.getExtension(Test_pkg.optionalNestedMessageExtension).hasBb(),
      isTrue);
  expect(message.getExtension(Test_pkg.optionalForeignMessageExtension).hasC(),
      isTrue);
  expect(message.getExtension(Test_pkg.optionalImportMessageExtension).hasD(),
      isTrue);

  expect(message.hasExtension(Test_pkg.optionalNestedEnumExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalForeignEnumExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalImportEnumExtension), isTrue);

  expect(message.hasExtension(Test_pkg.optionalStringPieceExtension), isTrue);
  expect(message.hasExtension(Test_pkg.optionalCordExtension), isTrue);

  expect(message.getExtension(Test_pkg.optionalInt32Extension), 101);
  expect(message.getExtension(Test_pkg.optionalInt64Extension), expect64(102));
  expect(message.getExtension(Test_pkg.optionalUint32Extension), 103);
  expect(message.getExtension(Test_pkg.optionalUint64Extension), expect64(104));
  expect(message.getExtension(Test_pkg.optionalSint32Extension), 105);
  expect(message.getExtension(Test_pkg.optionalSint64Extension), expect64(106));
  expect(message.getExtension(Test_pkg.optionalFixed32Extension), 107);
  expect(
      message.getExtension(Test_pkg.optionalFixed64Extension), expect64(108));
  expect(message.getExtension(Test_pkg.optionalSfixed32Extension), 109);
  expect(
      message.getExtension(Test_pkg.optionalSfixed64Extension), expect64(110));
  expect(message.getExtension(Test_pkg.optionalFloatExtension), 111.0);
  expect(message.getExtension(Test_pkg.optionalDoubleExtension), 112.0);
  expect(message.getExtension(Test_pkg.optionalBoolExtension), true);
  expect(message.getExtension(Test_pkg.optionalStringExtension), '115');
  expect(
      message.getExtension(Test_pkg.optionalBytesExtension), '116'.codeUnits);

  expect(message.getExtension(Test_pkg.optionalGroupExtension).a, 117);
  expect(message.getExtension(Test_pkg.optionalNestedMessageExtension).bb, 118);
  expect(message.getExtension(Test_pkg.optionalForeignMessageExtension).c, 119);
  expect(message.getExtension(Test_pkg.optionalImportMessageExtension).d, 120);

  expect(message.getExtension(Test_pkg.optionalNestedEnumExtension),
      TestAllTypes_NestedEnum.BAZ);
  expect(message.getExtension(Test_pkg.optionalForeignEnumExtension),
      ForeignEnum.FOREIGN_BAZ);
  expect(message.getExtension(Test_pkg.optionalImportEnumExtension),
      ImportEnum.IMPORT_BAZ);

  expect(message.getExtension(Test_pkg.optionalStringPieceExtension), '124');
  expect(message.getExtension(Test_pkg.optionalCordExtension), '125');

  // -----------------------------------------------------------------

  expect(message.getExtension(Test_pkg.repeatedInt32Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedInt64Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedUint32Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedUint64Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedSint32Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedSint64Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedFixed32Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedFixed64Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedSfixed32Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedSfixed64Extension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedFloatExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedDoubleExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedBoolExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedStringExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedBytesExtension).length, 2);

  expect(message.getExtension(Test_pkg.repeatedGroupExtension).length, 2);
  expect(
      message.getExtension(Test_pkg.repeatedNestedMessageExtension).length, 2);
  expect(
      message.getExtension(Test_pkg.repeatedForeignMessageExtension).length, 2);
  expect(
      message.getExtension(Test_pkg.repeatedImportMessageExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedNestedEnumExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedForeignEnumExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedImportEnumExtension).length, 2);

  expect(message.getExtension(Test_pkg.repeatedStringPieceExtension).length, 2);
  expect(message.getExtension(Test_pkg.repeatedCordExtension).length, 2);

  expect(message.getExtension(Test_pkg.repeatedInt32Extension)[0], 201);
  expect(
      message.getExtension(Test_pkg.repeatedInt64Extension)[0], expect64(202));
  expect(message.getExtension(Test_pkg.repeatedUint32Extension)[0], 203);
  expect(
      message.getExtension(Test_pkg.repeatedUint64Extension)[0], expect64(204));
  expect(message.getExtension(Test_pkg.repeatedSint32Extension)[0], 205);
  expect(
      message.getExtension(Test_pkg.repeatedSint64Extension)[0], expect64(206));
  expect(message.getExtension(Test_pkg.repeatedFixed32Extension)[0], 207);
  expect(message.getExtension(Test_pkg.repeatedFixed64Extension)[0],
      expect64(208));
  expect(message.getExtension(Test_pkg.repeatedSfixed32Extension)[0], 209);
  expect(message.getExtension(Test_pkg.repeatedSfixed64Extension)[0],
      expect64(210));
  expect(message.getExtension(Test_pkg.repeatedFloatExtension)[0], 211.0);
  expect(message.getExtension(Test_pkg.repeatedDoubleExtension)[0], 212.0);
  expect(message.getExtension(Test_pkg.repeatedBoolExtension)[0], true);
  expect(message.getExtension(Test_pkg.repeatedStringExtension)[0], '215');
  expect(message.getExtension(Test_pkg.repeatedBytesExtension)[0],
      '216'.codeUnits);

  expect(message.getExtension(Test_pkg.repeatedGroupExtension)[0].a, 217);
  expect(
      message.getExtension(Test_pkg.repeatedNestedMessageExtension)[0].bb, 218);
  expect(
      message.getExtension(Test_pkg.repeatedForeignMessageExtension)[0].c, 219);
  expect(
      message.getExtension(Test_pkg.repeatedImportMessageExtension)[0].d, 220);

  expect(message.getExtension(Test_pkg.repeatedNestedEnumExtension)[0],
      TestAllTypes_NestedEnum.BAR);
  expect(message.getExtension(Test_pkg.repeatedForeignEnumExtension)[0],
      ForeignEnum.FOREIGN_BAR);
  expect(message.getExtension(Test_pkg.repeatedImportEnumExtension)[0],
      ImportEnum.IMPORT_BAR);

  expect(message.getExtension(Test_pkg.repeatedStringPieceExtension)[0], '224');
  expect(message.getExtension(Test_pkg.repeatedCordExtension)[0], '225');

  expect(message.getExtension(Test_pkg.repeatedInt32Extension)[1], 501);
  expect(
      message.getExtension(Test_pkg.repeatedInt64Extension)[1], expect64(502));
  expect(message.getExtension(Test_pkg.repeatedUint32Extension)[1], 503);
  expect(
      message.getExtension(Test_pkg.repeatedUint64Extension)[1], expect64(504));
  expect(message.getExtension(Test_pkg.repeatedSint32Extension)[1], 505);
  expect(
      message.getExtension(Test_pkg.repeatedSint64Extension)[1], expect64(506));
  expect(message.getExtension(Test_pkg.repeatedFixed32Extension)[1], 507);
  expect(message.getExtension(Test_pkg.repeatedFixed64Extension)[1],
      expect64(508));
  expect(message.getExtension(Test_pkg.repeatedSfixed32Extension)[1], 509);
  expect(message.getExtension(Test_pkg.repeatedSfixed64Extension)[1],
      expect64(510));
  expect(message.getExtension(Test_pkg.repeatedFloatExtension)[1], 511.0);
  expect(message.getExtension(Test_pkg.repeatedDoubleExtension)[1], 512.0);
  expect(message.getExtension(Test_pkg.repeatedBoolExtension)[1], true);
  expect(message.getExtension(Test_pkg.repeatedStringExtension)[1], '515');
  expect(message.getExtension(Test_pkg.repeatedBytesExtension)[1],
      '516'.codeUnits);

  expect(message.getExtension(Test_pkg.repeatedGroupExtension)[1].a, 517);
  expect(
      message.getExtension(Test_pkg.repeatedNestedMessageExtension)[1].bb, 518);
  expect(
      message.getExtension(Test_pkg.repeatedForeignMessageExtension)[1].c, 519);
  expect(
      message.getExtension(Test_pkg.repeatedImportMessageExtension)[1].d, 520);

  expect(message.getExtension(Test_pkg.repeatedNestedEnumExtension)[1],
      TestAllTypes_NestedEnum.FOO);
  expect(message.getExtension(Test_pkg.repeatedForeignEnumExtension)[1],
      ForeignEnum.FOREIGN_FOO);
  expect(message.getExtension(Test_pkg.repeatedImportEnumExtension)[1],
      ImportEnum.IMPORT_FOO);

  expect(message.getExtension(Test_pkg.repeatedStringPieceExtension)[1], '524');
  expect(message.getExtension(Test_pkg.repeatedCordExtension)[1], '525');

  // -----------------------------------------------------------------

  expect(message.hasExtension(Test_pkg.defaultInt32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultInt64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultUint32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultUint64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultSint32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultSint64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultFixed32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultFixed64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultSfixed32Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultSfixed64Extension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultFloatExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultDoubleExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultBoolExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultStringExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultBytesExtension), isTrue);

  expect(message.hasExtension(Test_pkg.defaultNestedEnumExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultForeignEnumExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultImportEnumExtension), isTrue);

  expect(message.hasExtension(Test_pkg.defaultStringPieceExtension), isTrue);
  expect(message.hasExtension(Test_pkg.defaultCordExtension), isTrue);

  expect(message.getExtension(Test_pkg.defaultInt32Extension), 401);
  expect(message.getExtension(Test_pkg.defaultInt64Extension), expect64(402));
  expect(message.getExtension(Test_pkg.defaultUint32Extension), 403);
  expect(message.getExtension(Test_pkg.defaultUint64Extension), expect64(404));
  expect(message.getExtension(Test_pkg.defaultSint32Extension), 405);
  expect(message.getExtension(Test_pkg.defaultSint64Extension), expect64(406));
  expect(message.getExtension(Test_pkg.defaultFixed32Extension), 407);
  expect(message.getExtension(Test_pkg.defaultFixed64Extension), expect64(408));
  expect(message.getExtension(Test_pkg.defaultSfixed32Extension), 409);
  expect(
      message.getExtension(Test_pkg.defaultSfixed64Extension), expect64(410));
  expect(message.getExtension(Test_pkg.defaultFloatExtension), 411.0);
  expect(message.getExtension(Test_pkg.defaultDoubleExtension), 412.0);
  expect(message.getExtension(Test_pkg.defaultBoolExtension), false);
  expect(message.getExtension(Test_pkg.defaultStringExtension), '415');
  expect(message.getExtension(Test_pkg.defaultBytesExtension), '416'.codeUnits);

  expect(message.getExtension(Test_pkg.defaultNestedEnumExtension),
      TestAllTypes_NestedEnum.FOO);
  expect(message.getExtension(Test_pkg.defaultForeignEnumExtension),
      ForeignEnum.FOREIGN_FOO);
  expect(message.getExtension(Test_pkg.defaultImportEnumExtension),
      ImportEnum.IMPORT_FOO);

  expect(message.getExtension(Test_pkg.defaultStringPieceExtension), '424');
  expect(message.getExtension(Test_pkg.defaultCordExtension), '425');
}

void assertRepeatedFieldsModified(TestAllTypes message) {
  // ModifyRepeatedFields only sets the second repeated element of each
  // field.  In addition to verifying this, we also verify that the first
  // element and size were *not* modified.
  expect(message.repeatedInt32.length, 2);
  expect(message.repeatedInt64.length, 2);
  expect(message.repeatedUint32.length, 2);
  expect(message.repeatedUint64.length, 2);
  expect(message.repeatedSint32.length, 2);
  expect(message.repeatedSint64.length, 2);
  expect(message.repeatedFixed32.length, 2);
  expect(message.repeatedFixed64.length, 2);
  expect(message.repeatedSfixed32.length, 2);
  expect(message.repeatedSfixed64.length, 2);
  expect(message.repeatedFloat.length, 2);
  expect(message.repeatedDouble.length, 2);
  expect(message.repeatedBool.length, 2);
  expect(message.repeatedString.length, 2);
  expect(message.repeatedBytes.length, 2);

  expect(message.repeatedGroup.length, 2);
  expect(message.repeatedNestedMessage.length, 2);
  expect(message.repeatedForeignMessage.length, 2);
  expect(message.repeatedImportMessage.length, 2);
  expect(message.repeatedNestedEnum.length, 2);
  expect(message.repeatedForeignEnum.length, 2);
  expect(message.repeatedImportEnum.length, 2);

  expect(message.repeatedStringPiece.length, 2);
  expect(message.repeatedCord.length, 2);

  expect(message.repeatedInt32[0], 201);
  expect(message.repeatedInt64[0], expect64(202));
  expect(message.repeatedUint32[0], 203);
  expect(message.repeatedUint64[0], expect64(204));
  expect(message.repeatedSint32[0], 205);
  expect(message.repeatedSint64[0], expect64(206));
  expect(message.repeatedFixed32[0], 207);
  expect(message.repeatedFixed64[0], expect64(208));
  expect(message.repeatedSfixed32[0], 209);
  expect(message.repeatedSfixed64[0], expect64(210));
  expect(message.repeatedFloat[0], 211.0);
  expect(message.repeatedDouble[0], 212.0);
  expect(message.repeatedBool[0], true);
  expect(message.repeatedString[0], '215');
  expect(message.repeatedBytes[0], '216'.codeUnits);

  expect(message.repeatedGroup[0].a, 217);
  expect(message.repeatedNestedMessage[0].bb, 218);
  expect(message.repeatedForeignMessage[0].c, 219);
  expect(message.repeatedImportMessage[0].d, 220);

  expect(message.repeatedNestedEnum[0], TestAllTypes_NestedEnum.BAR);
  expect(message.repeatedForeignEnum[0], ForeignEnum.FOREIGN_BAR);
  expect(message.repeatedImportEnum[0], ImportEnum.IMPORT_BAR);

  expect(message.repeatedStringPiece[0], '224');
  expect(message.repeatedCord[0], '225');

  // Actually verify the second(modified) elements now.
  expect(message.repeatedInt32[1], 501);
  expect(message.repeatedInt64[1], expect64(502));
  expect(message.repeatedUint32[1], 503);
  expect(message.repeatedUint64[1], expect64(504));
  expect(message.repeatedSint32[1], 505);
  expect(message.repeatedSint64[1], expect64(506));
  expect(message.repeatedFixed32[1], 507);
  expect(message.repeatedFixed64[1], expect64(508));
  expect(message.repeatedSfixed32[1], 509);
  expect(message.repeatedSfixed64[1], expect64(510));
  expect(message.repeatedFloat[1], 511.0);
  expect(message.repeatedDouble[1], 512.0);
  expect(message.repeatedBool[1], true);
  expect(message.repeatedString[1], '515');
  expect(message.repeatedBytes[1], '516'.codeUnits);

  expect(message.repeatedGroup[1].a, 517);
  expect(message.repeatedNestedMessage[1].bb, 518);
  expect(message.repeatedForeignMessage[1].c, 519);
  expect(message.repeatedImportMessage[1].d, 520);

  expect(message.repeatedNestedEnum[1], TestAllTypes_NestedEnum.BAR);
  expect(message.repeatedForeignEnum[1], ForeignEnum.FOREIGN_BAR);
  expect(message.repeatedImportEnum[1], ImportEnum.IMPORT_BAR);

  expect(message.repeatedStringPiece[1], '524');
  expect(message.repeatedCord[1], '525');
}

/**
 * Assert (using expect} that all fields of [message] are set to the values
 * assigned by [setUnpackedFields].
 */
void assertUnpackedFieldsSet(TestUnpackedTypes message) {
  expect(message.unpackedInt32.length, 2);
  expect(message.unpackedInt64.length, 2);
  expect(message.unpackedUint32.length, 2);
  expect(message.unpackedUint64.length, 2);
  expect(message.unpackedSint32.length, 2);
  expect(message.unpackedSint64.length, 2);
  expect(message.unpackedFixed32.length, 2);
  expect(message.unpackedFixed64.length, 2);
  expect(message.unpackedSfixed32.length, 2);
  expect(message.unpackedSfixed64.length, 2);
  expect(message.unpackedFloat.length, 2);
  expect(message.unpackedDouble.length, 2);
  expect(message.unpackedBool.length, 2);
  expect(message.unpackedEnum.length, 2);
  expect(message.unpackedInt32[0], 601);
  expect(message.unpackedInt64[0], expect64(602));
  expect(message.unpackedUint32[0], 603);
  expect(message.unpackedUint64[0], expect64(604));
  expect(message.unpackedSint32[0], 605);
  expect(message.unpackedSint64[0], expect64(606));
  expect(message.unpackedFixed32[0], 607);
  expect(message.unpackedFixed64[0], expect64(608));
  expect(message.unpackedSfixed32[0], 609);
  expect(message.unpackedSfixed64[0], expect64(610));
  expect(message.unpackedFloat[0], 611.0);
  expect(message.unpackedDouble[0], 612.0);
  expect(message.unpackedBool[0], true);
  expect(message.unpackedEnum[0], ForeignEnum.FOREIGN_BAR);
  expect(message.unpackedInt32[1], 701);
  expect(message.unpackedInt64[1], expect64(702));
  expect(message.unpackedUint32[1], 703);
  expect(message.unpackedUint64[1], expect64(704));
  expect(message.unpackedSint32[1], 705);
  expect(message.unpackedSint64[1], expect64(706));
  expect(message.unpackedFixed32[1], 707);
  expect(message.unpackedFixed64[1], expect64(708));
  expect(message.unpackedSfixed32[1], 709);
  expect(message.unpackedSfixed64[1], expect64(710));
  expect(message.unpackedFloat[1], 711.0);
  expect(message.unpackedDouble[1], 712.0);
  expect(message.unpackedBool[1], false);
  expect(message.unpackedEnum[1], ForeignEnum.FOREIGN_BAZ);
}

TestAllExtensions getAllExtensionsSet() {
  TestAllExtensions message = new TestAllExtensions();
  setAllExtensions(message);
  return message;
}

/**
 * Get a [TestAllTypes] with all fields set as they would
 * be by [setAllFields(TestAllTypes)].
 */
TestAllTypes getAllSet() {
  TestAllTypes message = new TestAllTypes();
  setAllFields(message);
  return message;
}

ExtensionRegistry getExtensionRegistry() {
  ExtensionRegistry registry = new ExtensionRegistry();
  registerAllExtensions(registry);
  return registry /*.getUnmodifiable()*/;
}

TestPackedExtensions getPackedExtensionsSet() {
  TestPackedExtensions message = new TestPackedExtensions();
  setPackedExtensions(message);
  return message;
}

TestPackedTypes getPackedSet() {
  TestPackedTypes message = new TestPackedTypes();
  setPackedFields(message);
  return message;
}

TestUnpackedTypes getUnpackedSet() {
  TestUnpackedTypes message = new TestUnpackedTypes();
  setUnpackedFields(message);
  return message;
}

void modifyRepeatedExtensions(TestAllExtensions message) {
  message.getExtension(Test_pkg.repeatedInt32Extension)[1] = 501;
  message.getExtension(Test_pkg.repeatedInt64Extension)[1] = make64(502);
  message.getExtension(Test_pkg.repeatedUint32Extension)[1] = 503;
  message.getExtension(Test_pkg.repeatedUint64Extension)[1] = make64(504);
  message.getExtension(Test_pkg.repeatedSint32Extension)[1] = 505;
  message.getExtension(Test_pkg.repeatedSint64Extension)[1] = make64(506);
  message.getExtension(Test_pkg.repeatedFixed32Extension)[1] = 507;
  message.getExtension(Test_pkg.repeatedFixed64Extension)[1] = make64(508);
  message.getExtension(Test_pkg.repeatedSfixed32Extension)[1] = 509;
  message.getExtension(Test_pkg.repeatedSfixed64Extension)[1] = make64(510);
  message.getExtension(Test_pkg.repeatedFloatExtension)[1] = 511.0;
  message.getExtension(Test_pkg.repeatedDoubleExtension)[1] = 512.0;
  message.getExtension(Test_pkg.repeatedBoolExtension)[1] = true;
  message.getExtension(Test_pkg.repeatedStringExtension)[1] = '515';
  message.getExtension(Test_pkg.repeatedBytesExtension)[1] = '516'.codeUnits;

  var msg;

  msg = new RepeatedGroup_extension();
  msg.a = 517;
  message.getExtension(Test_pkg.repeatedGroupExtension)[1] = msg;

  msg = new TestAllTypes_NestedMessage();
  msg.bb = 518;
  message.getExtension(Test_pkg.repeatedNestedMessageExtension)[1] = msg;

  msg = new ForeignMessage();
  msg.c = 519;
  message.getExtension(Test_pkg.repeatedForeignMessageExtension)[1] = msg;

  msg = new ImportMessage();
  msg.d = 520;
  message.getExtension(Test_pkg.repeatedImportMessageExtension)[1] = msg;

  message.getExtension(Test_pkg.repeatedNestedEnumExtension)[1] =
      TestAllTypes_NestedEnum.FOO;
  message.getExtension(Test_pkg.repeatedForeignEnumExtension)[1] =
      ForeignEnum.FOREIGN_FOO;
  message.getExtension(Test_pkg.repeatedImportEnumExtension)[1] =
      ImportEnum.IMPORT_FOO;

  message.getExtension(Test_pkg.repeatedStringPieceExtension)[1] = '524';
  message.getExtension(Test_pkg.repeatedCordExtension)[1] = '525';
}

/**
 * Modify the repeated fields of {@code message} to contain the values
 * expected by {@code assertRepeatedFieldsModified()}.
 */
void modifyRepeatedFields(TestAllTypes message) {
  message.repeatedInt32[1] = 501;
  message.repeatedInt64[1] = make64(502);
  message.repeatedUint32[1] = 503;
  message.repeatedUint64[1] = make64(504);
  message.repeatedSint32[1] = 505;
  message.repeatedSint64[1] = make64(506);
  message.repeatedFixed32[1] = 507;
  message.repeatedFixed64[1] = make64(508);
  message.repeatedSfixed32[1] = 509;
  message.repeatedSfixed64[1] = make64(510);
  message.repeatedFloat[1] = 511.0;
  message.repeatedDouble[1] = 512.0;
  message.repeatedBool[1] = true;
  message.repeatedString[1] = '515';
  message.repeatedBytes[1] = '516'.codeUnits;

  TestAllTypes_RepeatedGroup repeatedGroup = new TestAllTypes_RepeatedGroup();
  repeatedGroup.a = 517;
  message.repeatedGroup[1] = repeatedGroup;

  TestAllTypes_NestedMessage optionalNestedMessage =
      new TestAllTypes_NestedMessage();
  optionalNestedMessage.bb = 518;
  message.repeatedNestedMessage[1] = optionalNestedMessage;

  ForeignMessage optionalForeignMessage = new ForeignMessage();
  optionalForeignMessage.c = 519;
  message.repeatedForeignMessage[1] = optionalForeignMessage;

  ImportMessage optionalImportMessage = new ImportMessage();
  optionalImportMessage.d = 520;
  message.repeatedImportMessage[1] = optionalImportMessage;

  message.repeatedNestedEnum[1] = TestAllTypes_NestedEnum.BAR;
  message.repeatedForeignEnum[1] = ForeignEnum.FOREIGN_BAR;
  message.repeatedImportEnum[1] = ImportEnum.IMPORT_BAR;

  message.repeatedStringPiece[1] = '524';
  message.repeatedCord[1] = '525';
}

void registerAllExtensions(ExtensionRegistry registry) {
  Test_pkg.registerAllExtensions(registry);
}

void setAllExtensions(TestAllExtensions message) {
  message.setExtension(Test_pkg.optionalInt32Extension, 101);
  message.setExtension(Test_pkg.optionalInt64Extension, make64(102));
  message.setExtension(Test_pkg.optionalUint32Extension, 103);
  message.setExtension(Test_pkg.optionalUint64Extension, make64(104));
  message.setExtension(Test_pkg.optionalSint32Extension, 105);
  message.setExtension(Test_pkg.optionalSint64Extension, make64(106));
  message.setExtension(Test_pkg.optionalFixed32Extension, 107);
  message.setExtension(Test_pkg.optionalFixed64Extension, make64(108));
  message.setExtension(Test_pkg.optionalSfixed32Extension, 109);
  message.setExtension(Test_pkg.optionalSfixed64Extension, make64(110));
  message.setExtension(Test_pkg.optionalFloatExtension, 111.0);
  message.setExtension(Test_pkg.optionalDoubleExtension, 112.0);
  message.setExtension(Test_pkg.optionalBoolExtension, true);
  message.setExtension(Test_pkg.optionalStringExtension, '115');
  message.setExtension(Test_pkg.optionalBytesExtension, '116'.codeUnits);

  var msg;

  msg = new OptionalGroup_extension();
  msg.a = 117;
  message.setExtension(Test_pkg.optionalGroupExtension, msg);

  msg = new TestAllTypes_NestedMessage();
  msg.bb = 118;
  message.setExtension(Test_pkg.optionalNestedMessageExtension, msg);

  msg = new ForeignMessage();
  msg.c = 119;
  message.setExtension(Test_pkg.optionalForeignMessageExtension, msg);

  msg = new ImportMessage();
  msg.d = 120;
  message.setExtension(Test_pkg.optionalImportMessageExtension, msg);

  message.setExtension(
      Test_pkg.optionalNestedEnumExtension, TestAllTypes_NestedEnum.BAZ);
  message.setExtension(
      Test_pkg.optionalForeignEnumExtension, ForeignEnum.FOREIGN_BAZ);
  message.setExtension(
      Test_pkg.optionalImportEnumExtension, ImportEnum.IMPORT_BAZ);

  message.setExtension(Test_pkg.optionalStringPieceExtension, '124');
  message.setExtension(Test_pkg.optionalCordExtension, '125');

  // -----------------------------------------------------------------

  message.addExtension(Test_pkg.repeatedInt32Extension, 201);
  message.addExtension(Test_pkg.repeatedInt64Extension, make64(202));
  message.addExtension(Test_pkg.repeatedUint32Extension, 203);
  message.addExtension(Test_pkg.repeatedUint64Extension, make64(204));
  message.addExtension(Test_pkg.repeatedSint32Extension, 205);
  message.addExtension(Test_pkg.repeatedSint64Extension, make64(206));
  message.addExtension(Test_pkg.repeatedFixed32Extension, 207);
  message.addExtension(Test_pkg.repeatedFixed64Extension, make64(208));
  message.addExtension(Test_pkg.repeatedSfixed32Extension, 209);
  message.addExtension(Test_pkg.repeatedSfixed64Extension, make64(210));
  message.addExtension(Test_pkg.repeatedFloatExtension, 211.0);
  message.addExtension(Test_pkg.repeatedDoubleExtension, 212.0);
  message.addExtension(Test_pkg.repeatedBoolExtension, true);
  message.addExtension(Test_pkg.repeatedStringExtension, '215');
  message.addExtension(Test_pkg.repeatedBytesExtension, '216'.codeUnits);

  msg = new RepeatedGroup_extension();
  msg.a = 217;
  message.addExtension(Test_pkg.repeatedGroupExtension, msg);

  msg = new TestAllTypes_NestedMessage();
  msg.bb = 218;
  message.addExtension(Test_pkg.repeatedNestedMessageExtension, msg);

  msg = new ForeignMessage();
  msg.c = 219;
  message.addExtension(Test_pkg.repeatedForeignMessageExtension, msg);

  msg = new ImportMessage();
  msg.d = 220;
  message.addExtension(Test_pkg.repeatedImportMessageExtension, msg);

  message.addExtension(
      Test_pkg.repeatedNestedEnumExtension, TestAllTypes_NestedEnum.BAR);
  message.addExtension(
      Test_pkg.repeatedForeignEnumExtension, ForeignEnum.FOREIGN_BAR);
  message.addExtension(
      Test_pkg.repeatedImportEnumExtension, ImportEnum.IMPORT_BAR);

  message.addExtension(Test_pkg.repeatedStringPieceExtension, '224');
  message.addExtension(Test_pkg.repeatedCordExtension, '225');

  // Add a second one of each field.
  message.addExtension(Test_pkg.repeatedInt32Extension, 301);
  message.addExtension(Test_pkg.repeatedInt64Extension, make64(302));
  message.addExtension(Test_pkg.repeatedUint32Extension, 303);
  message.addExtension(Test_pkg.repeatedUint64Extension, make64(304));
  message.addExtension(Test_pkg.repeatedSint32Extension, 305);
  message.addExtension(Test_pkg.repeatedSint64Extension, make64(306));
  message.addExtension(Test_pkg.repeatedFixed32Extension, 307);
  message.addExtension(Test_pkg.repeatedFixed64Extension, make64(308));
  message.addExtension(Test_pkg.repeatedSfixed32Extension, 309);
  message.addExtension(Test_pkg.repeatedSfixed64Extension, make64(310));
  message.addExtension(Test_pkg.repeatedFloatExtension, 311.0);
  message.addExtension(Test_pkg.repeatedDoubleExtension, 312.0);
  message.addExtension(Test_pkg.repeatedBoolExtension, false);
  message.addExtension(Test_pkg.repeatedStringExtension, '315');
  message.addExtension(Test_pkg.repeatedBytesExtension, '316'.codeUnits);

  msg = new RepeatedGroup_extension();
  msg.a = 317;
  message.addExtension(Test_pkg.repeatedGroupExtension, msg);

  msg = new TestAllTypes_NestedMessage();
  msg.bb = 318;
  message.addExtension(Test_pkg.repeatedNestedMessageExtension, msg);

  msg = new ForeignMessage();
  msg.c = 319;
  message.addExtension(Test_pkg.repeatedForeignMessageExtension, msg);

  msg = new ImportMessage();
  msg.d = 320;
  message.addExtension(Test_pkg.repeatedImportMessageExtension, msg);

  message.addExtension(
      Test_pkg.repeatedNestedEnumExtension, TestAllTypes_NestedEnum.BAZ);
  message.addExtension(
      Test_pkg.repeatedForeignEnumExtension, ForeignEnum.FOREIGN_BAZ);
  message.addExtension(
      Test_pkg.repeatedImportEnumExtension, ImportEnum.IMPORT_BAZ);

  message.addExtension(Test_pkg.repeatedStringPieceExtension, '324');
  message.addExtension(Test_pkg.repeatedCordExtension, '325');

  // -----------------------------------------------------------------

  message.setExtension(Test_pkg.defaultInt32Extension, 401);
  message.setExtension(Test_pkg.defaultInt64Extension, make64(402));
  message.setExtension(Test_pkg.defaultUint32Extension, 403);
  message.setExtension(Test_pkg.defaultUint64Extension, make64(404));
  message.setExtension(Test_pkg.defaultSint32Extension, 405);
  message.setExtension(Test_pkg.defaultSint64Extension, make64(406));
  message.setExtension(Test_pkg.defaultFixed32Extension, 407);
  message.setExtension(Test_pkg.defaultFixed64Extension, make64(408));
  message.setExtension(Test_pkg.defaultSfixed32Extension, 409);
  message.setExtension(Test_pkg.defaultSfixed64Extension, make64(410));
  message.setExtension(Test_pkg.defaultFloatExtension, 411.0);
  message.setExtension(Test_pkg.defaultDoubleExtension, 412.0);
  message.setExtension(Test_pkg.defaultBoolExtension, false);
  message.setExtension(Test_pkg.defaultStringExtension, '415');
  message.setExtension(Test_pkg.defaultBytesExtension, '416'.codeUnits);

  message.setExtension(
      Test_pkg.defaultNestedEnumExtension, TestAllTypes_NestedEnum.FOO);
  message.setExtension(
      Test_pkg.defaultForeignEnumExtension, ForeignEnum.FOREIGN_FOO);
  message.setExtension(
      Test_pkg.defaultImportEnumExtension, ImportEnum.IMPORT_FOO);

  message.setExtension(Test_pkg.defaultStringPieceExtension, '424');
  message.setExtension(Test_pkg.defaultCordExtension, '425');
}

/**
 * Set every field of {@code message} to the values expected by
 * {@code assertAllFieldsSet()}.
 */
void setAllFields(TestAllTypes message) {
  message.optionalInt32 = 101;
  message.optionalInt64 = make64(102);
  message.optionalUint32 = 103;
  message.optionalUint64 = make64(104);
  message.optionalSint32 = 105;
  message.optionalSint64 = make64(106);
  message.optionalFixed32 = 107;
  message.optionalFixed64 = make64(108);
  message.optionalSfixed32 = 109;
  message.optionalSfixed64 = make64(110);
  message.optionalFloat = 111.0;
  message.optionalDouble = 112.0;
  message.optionalBool = true;
  message.optionalString = '115';
  message.optionalBytes = '116'.codeUnits;

  TestAllTypes_OptionalGroup optionalGroup = new TestAllTypes_OptionalGroup();
  optionalGroup.a = 117;
  message.optionalGroup = optionalGroup;

  TestAllTypes_NestedMessage optionalNestedMessage =
      new TestAllTypes_NestedMessage();
  optionalNestedMessage.bb = 118;
  message.optionalNestedMessage = optionalNestedMessage;

  ForeignMessage optionalForeignMessage = new ForeignMessage();
  optionalForeignMessage.c = 119;
  message.optionalForeignMessage = optionalForeignMessage;

  ImportMessage optionalImportMessage = new ImportMessage();
  optionalImportMessage.d = 120;
  message.optionalImportMessage = optionalImportMessage;

  message.optionalNestedEnum = TestAllTypes_NestedEnum.BAZ;
  message.optionalForeignEnum = ForeignEnum.FOREIGN_BAZ;
  message.optionalImportEnum = ImportEnum.IMPORT_BAZ;

  message.optionalStringPiece = '124';
  message.optionalCord = '125';

  // -----------------------------------------------------------------

  message.repeatedInt32.add(201);
  message.repeatedInt64.add(make64(202));
  message.repeatedUint32.add(203);
  message.repeatedUint64.add(make64(204));
  message.repeatedSint32.add(205);
  message.repeatedSint64.add(make64(206));
  message.repeatedFixed32.add(207);
  message.repeatedFixed64.add(make64(208));
  message.repeatedSfixed32.add(209);
  message.repeatedSfixed64.add(make64(210));
  message.repeatedFloat.add(211.0);
  message.repeatedDouble.add(212.0);
  message.repeatedBool.add(true);
  message.repeatedString.add('215');
  message.repeatedBytes.add('216'.codeUnits);

  TestAllTypes_RepeatedGroup repeatedGroup = new TestAllTypes_RepeatedGroup();
  repeatedGroup.a = 217;
  message.repeatedGroup.add(repeatedGroup);

  TestAllTypes_NestedMessage repeatedNested = new TestAllTypes_NestedMessage();
  repeatedNested.bb = 218;
  message.repeatedNestedMessage.add(repeatedNested);

  ForeignMessage repeatedForeignMessage = new ForeignMessage();
  repeatedForeignMessage.c = 219;
  message.repeatedForeignMessage.add(repeatedForeignMessage);

  ImportMessage repeatedImportMessage = new ImportMessage();
  repeatedImportMessage.d = 220;
  message.repeatedImportMessage.add(repeatedImportMessage);

  message.repeatedNestedEnum.add(TestAllTypes_NestedEnum.BAR);
  message.repeatedForeignEnum.add(ForeignEnum.FOREIGN_BAR);
  message.repeatedImportEnum.add(ImportEnum.IMPORT_BAR);

  message.repeatedStringPiece.add('224');
  message.repeatedCord.add('225');

  // Add a second one of each field.
  message.repeatedInt32.add(301);
  message.repeatedInt64.add(make64(302));
  message.repeatedUint32.add(303);
  message.repeatedUint64.add(make64(304));
  message.repeatedSint32.add(305);
  message.repeatedSint64.add(make64(306));
  message.repeatedFixed32.add(307);
  message.repeatedFixed64.add(make64(308));
  message.repeatedSfixed32.add(309);
  message.repeatedSfixed64.add(make64(310));
  message.repeatedFloat.add(311.0);
  message.repeatedDouble.add(312.0);
  message.repeatedBool.add(false);
  message.repeatedString.add('315');
  message.repeatedBytes.add('316'.codeUnits);

  repeatedGroup = new TestAllTypes_RepeatedGroup();
  repeatedGroup.a = 317;
  message.repeatedGroup.add(repeatedGroup);

  repeatedNested = new TestAllTypes_NestedMessage();
  repeatedNested.bb = 318;
  message.repeatedNestedMessage.add(repeatedNested);

  repeatedForeignMessage = new ForeignMessage();
  repeatedForeignMessage.c = 319;
  message.repeatedForeignMessage.add(repeatedForeignMessage);

  repeatedImportMessage = new ImportMessage();
  repeatedImportMessage.d = 320;
  message.repeatedImportMessage.add(repeatedImportMessage);

  message.repeatedNestedEnum.add(TestAllTypes_NestedEnum.BAZ);
  message.repeatedForeignEnum.add(ForeignEnum.FOREIGN_BAZ);
  message.repeatedImportEnum.add(ImportEnum.IMPORT_BAZ);

  message.repeatedStringPiece.add('324');
  message.repeatedCord.add('325');

  // -----------------------------------------------------------------

  message.defaultInt32 = 401;
  message.defaultInt64 = make64(402);
  message.defaultUint32 = 403;
  message.defaultUint64 = make64(404);
  message.defaultSint32 = 405;
  message.defaultSint64 = make64(406);
  message.defaultFixed32 = 407;
  message.defaultFixed64 = make64(408);
  message.defaultSfixed32 = 409;
  message.defaultSfixed64 = make64(410);
  message.defaultFloat = 411.0;
  message.defaultDouble = 412.0;
  message.defaultBool = false;
  message.defaultString = '415';
  message.defaultBytes = '416'.codeUnits;

  message.defaultNestedEnum = TestAllTypes_NestedEnum.FOO;
  message.defaultForeignEnum = ForeignEnum.FOREIGN_FOO;
  message.defaultImportEnum = ImportEnum.IMPORT_FOO;

  message.defaultStringPiece = '424';
  message.defaultCord = '425';
}

void setPackedExtensions(TestPackedExtensions message) {
  message.addExtension(Test_pkg.packedInt32Extension, 601);
  message.addExtension(Test_pkg.packedInt64Extension, make64(602));
  message.addExtension(Test_pkg.packedUint32Extension, 603);
  message.addExtension(Test_pkg.packedUint64Extension, make64(604));
  message.addExtension(Test_pkg.packedSint32Extension, 605);
  message.addExtension(Test_pkg.packedSint64Extension, make64(606));
  message.addExtension(Test_pkg.packedFixed32Extension, 607);
  message.addExtension(Test_pkg.packedFixed64Extension, make64(608));
  message.addExtension(Test_pkg.packedSfixed32Extension, 609);
  message.addExtension(Test_pkg.packedSfixed64Extension, make64(610));
  message.addExtension(Test_pkg.packedFloatExtension, 611.0);
  message.addExtension(Test_pkg.packedDoubleExtension, 612.0);
  message.addExtension(Test_pkg.packedBoolExtension, true);
  message.addExtension(Test_pkg.packedEnumExtension, ForeignEnum.FOREIGN_BAR);
  // Add a second one of each field.
  message.addExtension(Test_pkg.packedInt32Extension, 701);
  message.addExtension(Test_pkg.packedInt64Extension, make64(702));
  message.addExtension(Test_pkg.packedUint32Extension, 703);
  message.addExtension(Test_pkg.packedUint64Extension, make64(704));
  message.addExtension(Test_pkg.packedSint32Extension, 705);
  message.addExtension(Test_pkg.packedSint64Extension, make64(706));
  message.addExtension(Test_pkg.packedFixed32Extension, 707);
  message.addExtension(Test_pkg.packedFixed64Extension, make64(708));
  message.addExtension(Test_pkg.packedSfixed32Extension, 709);
  message.addExtension(Test_pkg.packedSfixed64Extension, make64(710));
  message.addExtension(Test_pkg.packedFloatExtension, 711.0);
  message.addExtension(Test_pkg.packedDoubleExtension, 712.0);
  message.addExtension(Test_pkg.packedBoolExtension, false);
  message.addExtension(Test_pkg.packedEnumExtension, ForeignEnum.FOREIGN_BAZ);
}

/**
 * Set every field of [message] to a unique value. Must correspond with
 * the values applied by [setUnpackedFields].
 */
void setPackedFields(TestPackedTypes message) {
  message.packedInt32.add(601);
  message.packedInt64.add(make64(602));
  message.packedUint32.add(603);
  message.packedUint64.add(make64(604));
  message.packedSint32.add(605);
  message.packedSint64.add(make64(606));
  message.packedFixed32.add(607);
  message.packedFixed64.add(make64(608));
  message.packedSfixed32.add(609);
  message.packedSfixed64.add(make64(610));
  message.packedFloat.add(611.0);
  message.packedDouble.add(612.0);
  message.packedBool.add(true);
  message.packedEnum.add(ForeignEnum.FOREIGN_BAR);
  // Add a second one of each field.
  message.packedInt32.add(701);
  message.packedInt64.add(make64(702));
  message.packedUint32.add(703);
  message.packedUint64.add(make64(704));
  message.packedSint32.add(705);
  message.packedSint64.add(make64(706));
  message.packedFixed32.add(707);
  message.packedFixed64.add(make64(708));
  message.packedSfixed32.add(709);
  message.packedSfixed64.add(make64(710));
  message.packedFloat.add(711.0);
  message.packedDouble.add(712.0);
  message.packedBool.add(false);
  message.packedEnum.add(ForeignEnum.FOREIGN_BAZ);
}

/**
 * Set every field of [message] to a unique value. Must correspond with
 * the values applied by [setPackedFields].
 */
void setUnpackedFields(TestUnpackedTypes message) {
  message.unpackedInt32.add(601);
  message.unpackedInt64.add(make64(602));
  message.unpackedUint32.add(603);
  message.unpackedUint64.add(make64(604));
  message.unpackedSint32.add(605);
  message.unpackedSint64.add(make64(606));
  message.unpackedFixed32.add(607);
  message.unpackedFixed64.add(make64(608));
  message.unpackedSfixed32.add(609);
  message.unpackedSfixed64.add(make64(610));
  message.unpackedFloat.add(611.0);
  message.unpackedDouble.add(612.0);
  message.unpackedBool.add(true);
  message.unpackedEnum.add(ForeignEnum.FOREIGN_BAR);
  // Add a second one of each field.
  message.unpackedInt32.add(701);
  message.unpackedInt64.add(make64(702));
  message.unpackedUint32.add(703);
  message.unpackedUint64.add(make64(704));
  message.unpackedSint32.add(705);
  message.unpackedSint64.add(make64(706));
  message.unpackedFixed32.add(707);
  message.unpackedFixed64.add(make64(708));
  message.unpackedSfixed32.add(709);
  message.unpackedSfixed64.add(make64(710));
  message.unpackedFloat.add(711.0);
  message.unpackedDouble.add(712.0);
  message.unpackedBool.add(false);
  message.unpackedEnum.add(ForeignEnum.FOREIGN_BAZ);
}

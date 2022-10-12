import 'dart:convert';
import 'dart:typed_data';

class Point {
  String name;
  String type;
  String value;

  Point(this.name, this.type, this.value);

  factory Point.parse(Uint8List list) {
    final nameLength = list[0];
    final typeLength = list[1];
    final valueLength = list[2];
    int cursor = 3;
    final name = utf8.decode(list.sublist(cursor, cursor + nameLength));
    cursor += nameLength;
    final type = utf8.decode(list.sublist(cursor, cursor + typeLength));
    cursor += typeLength;
    final value = utf8.decode(list.sublist(cursor, cursor + valueLength));
    cursor += valueLength;
    if (cursor != list[cursor]) {
      throw StateError(
          "Length check failed. Expected ${list[cursor]}, got $cursor");
    }
    return Point(name, type, value);
  }

  Uint8List serialize() {
    final builder = BytesBuilder();
    builder.addByte(name.length);
    builder.addByte(type.length);
    builder.addByte(value.length);
    builder.add(utf8.encode(name));
    builder.add(utf8.encode(type));
    builder.add(utf8.encode(value));
    builder.addByte(3 + name.length + type.length + value.length);
    return builder.toBytes();
  }
}

import 'dart:typed_data';

import 'package:empatiplatform/db/point.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("Point Serialize", () {
    test("Basic String Serialize, a:a:a", () {
      Point p = Point("a", "a", "a");
      expect(p.serialize(), Uint8List.fromList([1, 1, 1, 97, 97, 97, 6]));
    });
    test("Basic String Deserialize, a:a:a", () {
      Point p = Point.parse(Uint8List.fromList([1, 1, 1, 97, 97, 97, 6]));
      expect(p.name, "a");
      expect(p.type, "a");
      expect(p.value, "a");
    });
  });
}

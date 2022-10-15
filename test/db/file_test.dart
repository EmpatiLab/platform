import 'dart:io';

import 'package:empatiplatform/db/file.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group("Source File", () {
    test("Create Temp File", () async {
      final file = await SourceFile.temp();
      expect(file?.raf.path, startsWith(Directory.systemTemp.path));
      expect(File(file!.raf.path).exists(), true);
    });
    test("Delete Temp File", () async {
      final file = await SourceFile.temp();
      await file?.delete();
      expect(await File(file!.raf.path).exists(), false);
    });
  });
}

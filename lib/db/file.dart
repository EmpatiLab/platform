import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:empatiplatform/db/disk.dart';
import 'package:path_provider/path_provider.dart';

math.Random r = math.Random();
String randomString(int length) =>
    String.fromCharCodes(List.generate(length, (index) => r.nextInt(33) + 89));

Future<Directory> get appDataDir async {
  Directory appDocDir;
  try {
    appDocDir = await getLibraryDirectory();
  } catch (e) {
    appDocDir = await getApplicationSupportDirectory();
  }
  appDocDir = await appDocDir.create(recursive: true);
  return appDocDir;
}

class SourceFile extends Disk {
  static Future<SourceFile?> open({String? path, Uri? uri}) async {
    File file;
    if (path != null) {
      file = File(path);
    } else if (uri != null) {
      file = File.fromUri(uri);
    } else {
      return null;
    }
    return SourceFile(await file.open(mode: FileMode.append));
  }

  static Future<SourceFile?> bind(String name) async {
    return SourceFile.open(uri: (await appDataDir).uri.resolve(name));
  }

  static Future<SourceFile?> temp([String? name]) async {
    name ??= randomString(6);
    return SourceFile.open(uri: Directory.systemTemp.uri.resolve(name));
  }

  final RandomAccessFile raf;
  SourceFile(this.raf);

  @override
  Future<void> close() async {
    await super.close();
    await raf.flush();
    await raf.close();
  }

  Future<void> delete() async {
    await close();
    await File(raf.path).delete();
  }
}

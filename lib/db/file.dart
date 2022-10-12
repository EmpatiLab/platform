import 'dart:io';

import 'package:path_provider/path_provider.dart';

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

class SourceFile {
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

  static bind(String name) async {
    return SourceFile.open(uri: (await appDataDir).uri.resolve(name));
  }

  RandomAccessFile file;
  SourceFile(this.file);
}

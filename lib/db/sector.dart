import 'package:empatiplatform/util/controller.dart';

class Sector extends Controller<SectorInput, SectorOutput> {
  static const size = 1024 * 1024 * 16; // 16MB

  @override
  Future<void> process(SectorInput event) {
    // TODO: implement process
    throw UnimplementedError();
  }
}

class SectorInput {}

class SectorOutput {}

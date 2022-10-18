import 'package:empatiplatform/util/controller.dart';

class BlockInput {}

class BlockOutput {}

class Block extends Controller<BlockInput, BlockOutput> {
  static const size = 1024 * 1024 * 512; // 512 MB

  @override
  Future<void> process(BlockInput event) {
    // TODO: implement process
    throw UnimplementedError();
  }
}

import 'dart:typed_data';
import 'package:empatiplatform/db/storage/block.dart';
import 'package:empatiplatform/util/controller.dart';

class DiskInput {
  String txId;
  DiskInput(this.txId);
}

class DiskOutput {
  String txId;
  DiskOutput(this.txId);
}

class DIWrite extends DiskInput {
  String path;
  Uint8List data;
  DIWrite(super.txId, {required this.path, required this.data});
}

class DIRead extends DiskInput {
  String path;
  DIRead(super.txId, {required this.path});
}

class DIAck extends DiskInput {
  DIAck(super.txId);
}

class DIData extends DiskInput {
  Uint8List data;
  DIData(super.txId, {required this.data});
}

class DOAck extends DiskOutput {
  DOAck(super.txId);
}

class DOData extends DiskOutput {
  Uint8List data;
  DOData(super.txId, {required this.data});
}

class Disk extends Controller<DiskInput, DiskOutput> {
  Disk();
  final List<Block> blocks = List.empty(growable: true);

  @override
  Future<void> process(DiskInput event) async {
    if (event is DIRead) {
      await _read(event);
    } else if (event is DIWrite) {
      await _write(event);
    } else if (event is DIAck) {
      await _ack(event);
    } else if (event is DIData) {
      await _data(event);
    } else {
      exceptions.add(UnknownInput(event, StackTrace.current));
    }
  }

  Future<void> _read(DIRead event) async {} // TODO: DIRead
  Future<void> _write(DIWrite event) async {} // TODO: DIWrite
  Future<void> _ack(DIAck event) async {} // TODO: DIAck
  Future<void> _data(DIData event) async {} // TODO: DIData
}

import 'dart:math';

import 'package:empatiplatform/util/controller.dart';
import 'package:flutter_test/flutter_test.dart';

class EchoInput {
  int rnd;
  EchoInput(this.rnd);
}

class EchoOutput {
  int rnd;
  EchoOutput(this.rnd);
}

class EchoController extends Controller<EchoInput, EchoOutput> {
  @override
  Future<void> process(event) async {
    output.add(EchoOutput(event.rnd));
  }
}

void main() {
  group("Controller Echo", () {
    test("Single in-out", () {
      EchoController ctl = EchoController();
      final input = EchoInput(Random().nextInt(65532));
      final cb = expectAsync1((EchoOutput p0) => expect(p0.rnd, input.rnd));
      ctl.listen(cb);
      ctl.add(input);
    });
    test("Sequence max 128", () {
      EchoController ctl = EchoController();
      final inputs = List.generate(
          Random().nextInt(128), (index) => EchoInput(Random().nextInt(65532)));
      int current = 0;
      final cb = expectAsync1(
          count: inputs.length,
          (EchoOutput p0) => expect(p0.rnd, inputs[current++].rnd));
      ctl.listen(cb);
      inputs.forEach(ctl.add);
    });
  });
  group("Controller basic controls", () {
    test("Start/Stop", () async {
      Controller ctl = EchoController();
      ctl.listen((event) {});
      await ctl.close();
      expect(ctl.isClosed, true);
    });
  });
}

import 'dart:async';
import 'dart:math';

import 'package:flutter_default_state_manager/bloc_pattern/imc_state.dart';

class ImcBlocPatternController {
  //Passando BROADCAST porque a ImcBlocPatternPage possui dois StreamBuilder
  final _imcStremController = StreamController<ImcState>.broadcast()
    ..add(ImcState(imc: 0));
  Stream<ImcState> get imcOut => _imcStremController.stream;


  Future<void> calcularImc(
      {required double peso, required double altura}) async {
    _imcStremController.add(ImcStateLoading());
    await Future.delayed(Duration(seconds: 1));
    final imc = peso / pow(altura, 2);
   
    _imcStremController.add(ImcState(imc: imc));
  }

  void dispose() {
    _imcStremController.close();
  }
}

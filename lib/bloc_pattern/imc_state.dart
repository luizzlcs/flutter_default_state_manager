class ImcState {
  final double? imc;

  ImcState({
    this.imc,
  });
}

class ImcStateLoading extends ImcState {}
// Não precisa passar o construtor porque na classe ImcState
// a passagem de valor para o imc é opcional

class ImcStateErro extends ImcState {
  String message;

  ImcStateErro({
    required this.message,
  });
}

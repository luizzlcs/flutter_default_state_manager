import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/bloc_pattern/imc_bloc_partern_controller.dart';
import 'package:flutter_default_state_manager/bloc_pattern/imc_state.dart';
import 'package:intl/intl.dart';

import '../widgets/imc_gauge.dart';

class ImcBlocPatternPage extends StatefulWidget {
  const ImcBlocPatternPage({Key? key}) : super(key: key);

  @override
  _ImcBlocPatternPageState createState() => _ImcBlocPatternPageState();
}

class _ImcBlocPatternPageState extends State<ImcBlocPatternPage> {
  final controller = ImcBlocPatternController();
  final pesoEc = TextEditingController();
  final alturaEc = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    pesoEc.dispose();
    alturaEc.dispose();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Imc Bloc Patterns'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<ImcState>(
              stream: controller.imcOut,
              builder: (context, snapshot) {
                var imc = snapshot.data?.imc ?? 0;
                return ImcGauge(imc: imc);
              },
            ),
            StreamBuilder<ImcState>(
              stream: controller.imcOut,
              builder: (context, snapshot) {
                final dataValue = snapshot.data;

                if (dataValue is ImcStateLoading) {
                  return Center(child: CircularProgressIndicator());
                }

                if (dataValue is ImcStateErro) {
                  return Text(dataValue.message);
                }

                return SizedBox.shrink();
              },
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.only(left: 6, right: 6),
                child: TextFormField(
                    controller: pesoEc,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'Peso'),
                    inputFormatters: [
                      CurrencyTextInputFormatter(
                        locale: 'pt_BR', // para mudar o ponto para virgula
                        symbol: '',
                        turnOffGrouping:
                            true, //Remove os pontos de separadores, centena milhar...
                        decimalDigits: 2,
                      ),
                    ],
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Você precisa digitar o peso.';
                      }
                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 6),
              child: TextFormField(
                  controller: alturaEc,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Altura'),
                  inputFormatters: [
                    CurrencyTextInputFormatter(
                      locale: 'pt_BR', // para mudar o ponto para virgula
                      symbol: '',
                      turnOffGrouping:
                          true, //Remove os pontos de separadores, centena milhar...
                      decimalDigits: 2,
                    ),
                  ],
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Você precisa digitar a altura.';
                    }
                  }),
            ),
            const SizedBox(
              height: 18,
            ),
            ElevatedButton.icon(
              onPressed: () {
                var formValid = formKey.currentState?.validate() ?? false;

                if (formValid) {
                  // executa somente se o formulário estiver válido.
                  var formatter = NumberFormat.simpleCurrency(
                      locale: 'pt_BR', decimalDigits: 2);

                  double peso = formatter.parse(pesoEc.text) as double;
                  double altura = formatter.parse(alturaEc.text) as double;

                  controller.calcularImc(peso: peso, altura: altura);
                }
              },
              icon: const Icon(Icons.monitor_weight_outlined),
              label: const Text('Calcular IMC🎯!'),
            ),
          ],
        ),
      ),
    );
  }
}

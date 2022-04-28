import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge_range.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcSetstatePage extends StatefulWidget {
  const ImcSetstatePage({Key? key}) : super(key: key);

  @override
  State<ImcSetstatePage> createState() => _ImcSetstatePageState();
}

class _ImcSetstatePageState extends State<ImcSetstatePage> {
  final pesoEc = TextEditingController();
  final alturaEc = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var imc = 0.0;

  void _calcularImc({required double peso, required double altura}) async {
    setState(() {
      imc = 0;
    });

    await Future.delayed(const Duration(seconds: 1));

    setState(() {
      imc = peso / pow(altura, 2);
      // pow da bíblioteca Marth, permitide definir um número e um expoente.
    });
  }

  @override
  void dispose() {
    pesoEc.dispose();
    alturaEc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SetState'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ImcGauge(imc: imc),
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
            SizedBox(
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
                  _calcularImc(peso: peso, altura: altura);
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

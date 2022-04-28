import 'dart:math';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_default_state_manager/change_notifier/imc_change_notifier_controller.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge.dart';
import 'package:flutter_default_state_manager/widgets/imc_gauge_range.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcChangeNotifierPage extends StatefulWidget {
  const ImcChangeNotifierPage({Key? key}) : super(key: key);

  @override
  State<ImcChangeNotifierPage> createState() => _ImcChangeNotifierPageState();
}

class _ImcChangeNotifierPageState extends State<ImcChangeNotifierPage> {
  final controller = ImcChangeNotifierController();
  final pesoEc = TextEditingController();
  final alturaEc = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
        title: const Text('Change Notifier'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Usar o UnamatedBuilder para startar a controller
            AnimatedBuilder(
              animation: controller,
              builder: (context, child) {
                return ImcGauge(imc: controller.imc);
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
            Text(
              controller.imc == 0
                  ? ''
                  : ' IMC ${controller.imc.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 22),
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

                  // /chamando método da classe CangeNotifierController.
                  controller.CalcularImc(peso: peso, altura: altura);
                }
              },
              icon: const Icon(Icons.monitor_weight_outlined),
              label: const Text('Calcular IMC'),
            ),
          ],
        ),
      ),
    );
  }
}

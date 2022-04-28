import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

import 'imc_gauge_range.dart';

class ImcGauge extends StatelessWidget {
  final double imc;

  const ImcGauge({Key? key, required this.imc}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfRadialGauge(
      axes: <RadialAxis>[
        RadialAxis(
          showFirstLabel: false,
          showAxisLine: false,
          showLabels: false,
          showTicks: false,
          minimum: 12.5,
          maximum: 47.9,
          ranges: <GaugeRange>[
            ImcGaugeRanger(
              color: Colors.blue,
              star: 12.5,
              end: 18.5,
              label: 'MAGREZA',
            ),
            ImcGaugeRanger(
              color: Colors.green,
              star: 18.5,
              end: 24.5,
              label: 'NORMAL',
            ),
            ImcGaugeRanger(
              color: Colors.yellow[600]!,
              star: 24.5,
              end: 29.9,
              label: 'SOBREPESO',
            ),
            ImcGaugeRanger(
              color: Colors.red[500]!,
              star: 29.9,
              end: 39.9,
              label: 'OBSIDADE',
            ),
            ImcGaugeRanger(
              color: Colors.red[900]!,
              star: 39.9,
              end: 47.9,
              label: 'OBSIDADE GRAVE',
            ),
          ],
          pointers: <GaugePointer>[
            NeedlePointer(
              value: imc,
              enableAnimation: true,
            ),
          ],
        ),
      ],
    );
  }
}

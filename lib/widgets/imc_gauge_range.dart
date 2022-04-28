import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class ImcGaugeRanger extends GaugeRange {
  ImcGaugeRanger({
    required Color color,
    required double star,
    required double end,
    required String label,
  }) : super(
            startValue: star,
            endValue: end,
            color: color,
            label: label,
            sizeUnit: GaugeSizeUnit.factor,
            labelStyle: GaugeTextStyle(fontFamily: 'Times', fontSize: 12),
            startWidth: 0.65,
            endWidth: 0.65);
}

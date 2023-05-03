import 'package:flutter/material.dart';
import 'package:thermo_animation/screens/widgets/temperature_icon_bar.dart';
import 'package:thermo_animation/screens/widgets/thermo.dart';
import 'package:thermo_animation/screens/widgets/thermo_painter.dart';

import '../../constants/app_constants.dart';

class TemperatureView extends StatelessWidget {
  final ValueNotifier<double> temperature = ValueNotifier(20.0);

  TemperatureView({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
      child: SizedBox(
        width: 400,
        child: ValueListenableBuilder(
          valueListenable: temperature,
          builder: (context, value, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    '  ${temperature.value.toInt()}°',
                    style: textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.grey[350]),
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child: Thermo(temperature: temperature.value)),
                      Positioned.fill(
                        left: 300,
                        child: CustomSlider(
                          value: temperature.value,
                          onValueChanged: (value) => temperature.value = value,
                        ),
                      ),
                    ],
                  ),
                ),
                TemperatureIconBar(
                  value: value / maxTemperature,
                  onTemperatureChanged: (t) => temperature.value = t,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

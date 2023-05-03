import 'package:flutter/material.dart';
import 'package:thermo_animation/screens/widgets/thermo_icon.dart';


class TemperatureIconBar extends StatelessWidget {
  final double value;
  final ValueChanged<double> onTemperatureChanged;

  const TemperatureIconBar({
    super.key,
    required this.value,
    required this.onTemperatureChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ThermoIcon(
            icon: Icons.ac_unit,
            color: Colors.cyan,
            selected: value < 1 / 3,
            onTap: () => onTemperatureChanged(10),
          ),
          ThermoIcon(
            icon: Icons.water_drop,
            color: Colors.amber,
            selected: value >= 1 / 3 && value < 2 / 3,
            onTap: () => onTemperatureChanged(20),
          ),
          ThermoIcon(
            icon: Icons.local_fire_department,
            color: Colors.deepOrange,
            selected: value >= 2 / 3,
            onTap: () => onTemperatureChanged(35),
          ),
        ],
      ),
    );
  }
}

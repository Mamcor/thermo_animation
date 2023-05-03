import 'package:flutter/material.dart';
import 'package:thermo_animation/screens/widgets/temperature_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(child: TemperatureView()),
    );
  }
}
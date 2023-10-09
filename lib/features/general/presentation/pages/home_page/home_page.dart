import 'package:flutter/material.dart';
import 'package:login_app/features/general/presentation/widgets/profile_widget.dart';
import 'package:login_app/features/general/presentation/widgets/service_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const ProfileWidget(),
          SizedBox(height: MediaQuery.sizeOf(context).height * 0.04),
          buildDefaultService(
              image: 'assets/images/png/circuitTheo.png',
              text: 'Mes circuits de contrôle'),
          buildDefaultService(
              image: 'assets/images/png/circuitMap.png',
              text: 'Circuits préstations délégataires'),
          buildDefaultService(
              image: 'assets/images/png/circuit.png',
              text: 'Déclaration d’une anomalie'),
          buildDefaultService(
              image: 'assets/images/png/circuitTreatment.png',
              text: 'Suivi du traitement'),
        ],
      ),
    );
  }
}

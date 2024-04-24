import 'package:contat/style/appcolors.dart';
import 'package:contat/lateralMenu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  String appTitle = "Contat";

  @override
  Widget build(BuildContext context) {
    MediaQueryData screenSize = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        backgroundColor: AppColors.secondColor,
        title: Text(appTitle),
        actions: <Widget>[
          IconButton(onPressed: () {}, icon: const Icon(Icons.person))
        ],
      ),
      body: const Column(
        children: [
          Expanded(child: LateralMenu()),
        ],
      ),
    );
  }
}

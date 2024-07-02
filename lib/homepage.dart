import 'package:contat/style/appcolors.dart';
import 'package:contat/lateralMenu.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});

  String appTitle = "CRS Contact Manager";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.accentColor,
      appBar: AppBar(
        backgroundColor: AppColors.accentColor,
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

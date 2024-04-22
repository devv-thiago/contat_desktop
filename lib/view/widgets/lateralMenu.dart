import 'package:contat/style/appcolors.dart';
import 'package:contat/view/contatos_view.dart';
import 'package:contat/view/dispositivos_view.dart';
import 'package:contat/view/grupos_view.dart';
import 'package:contat/view/usuario_view.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

class LateralMenu extends StatefulWidget {
  const LateralMenu({super.key});

  @override
  State<LateralMenu> createState() => _LateralMenuState();
}

class _LateralMenuState extends State<LateralMenu> {
  int selectedIndex = 0;

  List<Widget> views = const [
    GruposView(),
    ContatosView(),
    UsuariosView(),
    DispositivosView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SideNavigationBar(
          theme: SideNavigationBarTheme(
            itemTheme: SideNavigationBarItemTheme(
                unselectedItemColor: AppColors.secondColor,
                selectedItemColor: AppColors.secondColor,
                unselectedBackgroundColor: AppColors.accentColor,
                selectedBackgroundColor: AppColors.accentColor2),
            togglerTheme: SideNavigationBarTogglerTheme.standard(),
            dividerTheme: SideNavigationBarDividerTheme.standard(),
          ),
          selectedIndex: selectedIndex,
          items: const [
            SideNavigationBarItem(
              icon: Icons.group,
              label: 'Grupos',
            ),
            SideNavigationBarItem(
              icon: Icons.menu_book,
              label: 'Contatos',
            ),
            SideNavigationBarItem(
              icon: Icons.person,
              label: 'Usuários',
            ),
            SideNavigationBarItem(
              icon: Icons.smartphone,
              label: 'Dispositivos',
            ),
          ],
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),

        /// Make it take the rest of the available width
        Expanded(
          child: views.elementAt(selectedIndex),
        )
      ],
    );
  }
}

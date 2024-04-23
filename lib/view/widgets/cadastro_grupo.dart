import 'package:contat/style/appcolors.dart';
import 'package:flutter/material.dart';

class CadastroGruposWidget extends StatelessWidget {
  final TextEditingController nomeGrupoController;
  final VoidCallback onPressed;

  const CadastroGruposWidget({
    super.key,
    required this.nomeGrupoController,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Gerenciamento de grupos",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        Container(
          width: deviceInfo.size.width * 0.25,
          height: deviceInfo.size.height * 0.6,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.secondColor,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Adicionar grupos"),
              SizedBox(
                height: deviceInfo.size.width * 0.01,
              ),
              SizedBox(
                width: deviceInfo.size.width * 0.3,
                child: TextFormField(
                  controller: nomeGrupoController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.secondColor,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 10.0,
                    ),
                    labelText: 'Nome do Grupo',
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: AppColors.accentColor,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(
                        color: AppColors.accentColor,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
              const Divider(
                color: Colors.transparent,
              ),
              SizedBox(
                width: deviceInfo.size.width * 0.3,
                height: deviceInfo.size.height * 0.06,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.accentColor),
                  ),
                  onPressed: onPressed,
                  child: const Text(
                    "Adicionar",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

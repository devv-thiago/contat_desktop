import 'package:flutter/material.dart';
import 'package:contat/style/appcolors.dart';

enum Departamentos {
  TI,
  MANUTENCAO,
  ENGENHARIA,
  QUALIDADE,
  CONTABIL,
  FISCAL,
}

class CadastroContatosWidget extends StatefulWidget {
  final TextEditingController nomeCompletoController;
  final TextEditingController emailController;
  final TextEditingController telefoneController;
  final TextEditingController departamentoController;
  final TextEditingController cargoController;
  final VoidCallback onPressed;

  const CadastroContatosWidget({
    Key? key,
    required this.nomeCompletoController,
    required this.emailController,
    required this.telefoneController,
    required this.departamentoController,
    required this.cargoController,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CadastroContatosWidget> createState() => _CadastroContatosWidgetState();
}

class _CadastroContatosWidgetState extends State<CadastroContatosWidget> {
  Departamentos? _selectedDepartamento;

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const Text(
          "Gerenciamento de contatos",
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
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Adicionar contato"),
                SizedBox(
                  height: deviceInfo.size.width * 0.01,
                ),
                SizedBox(
                  width: deviceInfo.size.width * 0.3,
                  child: TextFormField(
                    controller: widget.nomeCompletoController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.secondColor,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      labelText: 'Nome Completo',
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
                  child: TextFormField(
                    controller: widget.emailController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.secondColor,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      labelText: 'E-mail',
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
                  child: TextFormField(
                    controller: widget.telefoneController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.secondColor,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      labelText: 'Número telefone',
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
                  child: DropdownButtonFormField<Departamentos>(
                    value: _selectedDepartamento,
                    hint: Text(
                      "Departamento",
                      style: TextStyle(color: AppColors.accentColor),
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.secondColor,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: AppColors.accentColor,
                          width: 2.0,
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
                    onChanged: (value) {
                      setState(() {
                        _selectedDepartamento = value;
                        widget.departamentoController.text =
                            value.toString().split('.').last;
                      });
                    },
                    items:
                        Departamentos.values.map((Departamentos departamento) {
                      return DropdownMenuItem<Departamentos>(
                        value: departamento,
                        child: Text(departamento.toString().split('.').last),
                      );
                    }).toList(),
                  ),
                ),
                const Divider(
                  color: Colors.transparent,
                ),
                SizedBox(
                  width: deviceInfo.size.width * 0.3,
                  child: TextFormField(
                    controller: widget.cargoController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.secondColor,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 10.0,
                      ),
                      labelText: 'Cargo',
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
                    onPressed: widget.onPressed,
                    child: const Text(
                      "Adicionar",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

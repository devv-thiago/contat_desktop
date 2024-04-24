import 'package:contat/contatos/widget/cadastro_contato.dart';
import 'package:contat/db_controller.dart';
import 'package:contat/style/appcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContatosView extends StatefulWidget {
  const ContatosView({super.key});

  @override
  State<ContatosView> createState() => _ContatosViewState();
}

class _ContatosViewState extends State<ContatosView> {
  final DatabaseController databaseController = DatabaseController();
  late TextEditingController nomeCompletoController;
  late TextEditingController emailController;
  late TextEditingController telefoneController;
  late TextEditingController departamentoController;
  late TextEditingController cargoController;

  @override
  void initState() {
    super.initState();
    nomeCompletoController = TextEditingController();
    emailController = TextEditingController();
    telefoneController = TextEditingController();
    departamentoController = TextEditingController();
    cargoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Container(
        padding: const EdgeInsets.all(16.0),
        height: deviceInfo.size.height,
        width: deviceInfo.size.width,
        decoration: BoxDecoration(color: AppColors.background),
        child: Container(
            width: deviceInfo.size.width * 0.8,
            height: deviceInfo.size.height * 0.8,
            decoration: BoxDecoration(
                color: AppColors.secondColor,
                borderRadius: BorderRadius.circular(30)),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              CadastroContatosWidget(
                  nomeCompletoController: nomeCompletoController,
                  cargoController: cargoController,
                  departamentoController: departamentoController,
                  emailController: emailController,
                  telefoneController: telefoneController,
                  onPressed: () {}),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: deviceInfo.size.width * 0.5,
                  height: deviceInfo.size.height,
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                      color: AppColors.accentColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: Column(
                    children: [
                      FutureBuilder<List<Map<String, dynamic>>>(
                        future: databaseController
                            .getAllRecords("Contatos"), // async work
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(8),
                                        child: const Text("ID",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        child: const Text("Nome",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        child: const Text("Número telefone",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        child: const Text("Departamento",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        padding: const EdgeInsets.all(8),
                                        child: const Text("Cargo",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold)),
                                      ),
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  scrollDirection: Axis.vertical,
                                  shrinkWrap: true,
                                  itemCount: snapshot.data!.length,
                                  itemBuilder: (context, index) => Row(
                                    children: [
                                      Container(
                                        alignment: Alignment.center,
                                        width: deviceInfo.size.width * 0.03,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                            "${snapshot.data![index]['idGrupo']}"),
                                      ),
                                      const SizedBox(width: 16),
                                      Container(
                                        width: deviceInfo.size.width * 0.4,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                          color: AppColors.secondColor,
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 15),
                                          child: Text(
                                              "${snapshot.data![index]['nomeGrupo']}"),
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            int idGrupo = snapshot.data![index]
                                                ['idGrupo'];
                                            databaseController
                                                .deleteGroup(idGrupo);
                                            setState(() {
                                              databaseController
                                                  .getAllRecords("Contatos");
                                            });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: AppColors.secondColor,
                                          )),
                                      SizedBox(
                                        height: deviceInfo.size.height * 0.05,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const SizedBox.shrink();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ))
            ])));
  }
}

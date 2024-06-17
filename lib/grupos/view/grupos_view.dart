import 'package:contat/db_controller.dart';
import 'package:contat/style/appcolors.dart';
import 'package:contat/grupos/widget/cadastro_grupo.dart';

import 'package:flutter/material.dart';

class GruposView extends StatefulWidget {
  const GruposView({Key? key}) : super(key: key);

  @override
  State<GruposView> createState() => _GruposViewState();
}

class _GruposViewState extends State<GruposView> {
  final DatabaseController databaseController = DatabaseController();
  late TextEditingController nomeGrupoController;

  @override
  void initState() {
    super.initState();
    nomeGrupoController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Scaffold(
      body: Container(
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CadastroGruposWidget(
                    nomeGrupoController: nomeGrupoController,
                    onPressed: () {
                      databaseController
                          .insertNewGroup(
                            nomeGrupoController.text,
                          )
                          .whenComplete(() => nomeGrupoController.clear());
                      setState(() {
                        // Chamada para buscar os dados novamente no banco de dados
                        databaseController.getAllRecords("Grupos");
                      });
                    }),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                          color: AppColors.accentColor,
                          borderRadius: BorderRadius.circular(30)),
                      child: Column(
                        children: [
                          FutureBuilder<List<Map<String, dynamic>>>(
                            future: databaseController
                                .getAllRecords("Grupos"), // async work
                            builder: (BuildContext context,
                                AsyncSnapshot<List<Map<String, dynamic>>>
                                    snapshot) {
                              if (snapshot.hasData) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: deviceInfo.size.width * 0.4,
                                          padding: const EdgeInsets.all(8),
                                          child: const Text("Nome Grupo",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ),
                                    ListView.builder(
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) => Row(
                                        children: [
                                          Container(
                                            width: deviceInfo.size.width * 0.3,
                                            padding: const EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                              color: AppColors.secondColor,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 15),
                                              child: Text(
                                                  "${snapshot.data![index]['nomeGrupo']}"),
                                            ),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                int idGrupo = snapshot
                                                    .data![index]['idGrupo'];
                                                databaseController
                                                    .deleteGroup(idGrupo);
                                                setState(() {
                                                  databaseController
                                                      .getAllRecords("Grupos");
                                                });
                                              },
                                              icon: Icon(
                                                Icons.delete,
                                                color: AppColors.secondColor,
                                              )),
                                          SizedBox(
                                            height:
                                                deviceInfo.size.height * 0.05,
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
                  ),
                )
              ],
            )),
      ),
    );
  }
}

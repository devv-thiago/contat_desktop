import 'package:flutter/material.dart';
import 'package:contat/contatos/widget/cadastro_contato.dart';
import 'package:contat/db_controller.dart';
import 'package:contat/style/appcolors.dart';

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
    final deviceInfo = MediaQuery.of(context);
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        height: deviceInfo.size.height,
        width: deviceInfo.size.width,
        decoration: BoxDecoration(color: AppColors.background),
        child: Center(
          child: Container(
            width: deviceInfo.size.width * 0.8,
            height: deviceInfo.size.height * 0.8,
            decoration: BoxDecoration(
              color: AppColors.secondColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CadastroContatosWidget(
                  nomeCompletoController: nomeCompletoController,
                  cargoController: cargoController,
                  departamentoController: departamentoController,
                  emailController: emailController,
                  telefoneController: telefoneController,
                  onPressed: _addContact,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: AppColors.accentColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: _buildContactsList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addContact() {
    databaseController
        .insertNewContact(
      nomeCompletoController.text,
      departamentoController.text,
      cargoController.text,
    )
        .whenComplete(() {
      _clearControllers();
      setState(() {
        databaseController.getAllRecords("Contatos");
      });
    });
  }

  void _clearControllers() {
    nomeCompletoController.clear();
    emailController.clear();
    telefoneController.clear();
    departamentoController.clear();
    cargoController.clear();
  }

  Widget _buildContactsList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: databaseController.getAllRecords("Contatos"),
      builder: (BuildContext context,
          AsyncSnapshot<List<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeaderRow(),
              Expanded(
                child: SingleChildScrollView(
                  child: Table(
                    columnWidths: const {
                      0: FlexColumnWidth(0.5),
                      1: FlexColumnWidth(0.5),
                      2: FixedColumnWidth(60),
                    },
                    children: snapshot.data!
                        .map((contact) => _buildContactRow(contact))
                        .toList(),
                  ),
                ),
              ),
            ],
          );
        } else {
          return const Center(
              child: Text(
            'Nenhum contato cadastrado',
            style: TextStyle(fontWeight: FontWeight.bold),
          ));
        }
      },
    );
  }

  Widget _buildHeaderRow() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(0.5),
        1: FlexColumnWidth(0.5),
        2: FixedColumnWidth(60),
      },
      children: [
        TableRow(
          children: [
            _buildHeaderCell('Nome'),
            _buildHeaderCell('Número telefone'),
            Container(), // Empty cell for alignment
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String title) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  TableRow _buildContactRow(Map<String, dynamic> contact) {
    return TableRow(
      children: [
        _buildContactCell(contact['displayName']),
        _buildContactCell(contact['phones'] ?? 'Número não disponível'),
        IconButton(
          onPressed: () {
            _deleteContact(contact['idContato']);
          },
          icon: Icon(
            Icons.delete,
            color: AppColors.secondColor,
          ),
        ),
      ],
    );
  }

  Widget _buildContactCell(String content) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.secondColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(content),
    );
  }

  void _deleteContact(int idContato) {
    databaseController.deleteContact(idContato);
    setState(() {
      databaseController.getAllRecords("Contatos");
    });
  }
}

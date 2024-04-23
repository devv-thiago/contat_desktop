import 'package:flutter/material.dart';
import 'package:contat/style/appcolors.dart';

class GruposListView extends StatelessWidget {
  final List<Map<String, dynamic>> gruposData;

  const GruposListView({
    Key? key,
    required this.gruposData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: deviceInfo.size.width * 0.03,
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8),
              child: const Text(
                "ID",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(width: 16),
            Container(
              width: deviceInfo.size.width * 0.4,
              padding: const EdgeInsets.all(8),
              child: const Text(
                "Nome",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: gruposData.length,
          itemBuilder: (context, index) => Row(
            children: [
              Container(
                alignment: Alignment.center,
                width: deviceInfo.size.width * 0.03,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text("${gruposData[index]['idGrupo']}"),
              ),
              const SizedBox(width: 16),
              Container(
                width: deviceInfo.size.width * 0.4,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.secondColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text("${gruposData[index]['nomeGrupo']}"),
                ),
              ),
              SizedBox(height: deviceInfo.size.height * 0.05),
            ],
          ),
        ),
      ],
    );
  }
}

import 'package:dam_1c_2023/cells/modals.dart';
import 'package:flutter/material.dart';
import 'package:dam_1c_2023/molecules/buttons.dart';
import 'package:dam_1c_2023/atoms/icons/arrow_back.dart';

class SelectedCardPage extends StatelessWidget {
  final String imageName;
  final String title;
  final String description;

  const SelectedCardPage(
      {Key? key,
      required this.imageName,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              SizedBox(
                height: 243, // set the height here
                width: double.infinity,
                child: Image.asset(
                  imageName,
                  fit: BoxFit.cover,
                ),
              ),
              const Positioned(
                top: 28,
                left: 28,
                child: ArrowBackIcon(),
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 24)),
                  Text(
                    description,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 56),
                child: CtaButton(
                    text: "Postularme",
                    enabledState: true,
                    handlePress: () {
                      _showCustomDialog(context);
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<void> _showCustomDialog(BuildContext context) async {
  await showDialog<void>(
    context: context,
    builder: (_) {
      return ApplyDialog(
        title: 'Un techo para mi país',
        description: 'Días sábados de 9.00 a 17.00 horas',
        location: 'Caballito',
        cancelButtonText: 'Cancelar',
        confirmButtonText: 'Confirmar',
        onCancelPressed: () => Navigator.of(context).pop(),
        onConfirmPressed: () => Navigator.of(context).pop(),
      );
    },
  );
}

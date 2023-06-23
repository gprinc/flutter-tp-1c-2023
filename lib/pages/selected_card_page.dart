import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_1c_2023/atoms/logos.dart';
import 'package:dam_1c_2023/cells/modals.dart';
import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';
import 'package:dam_1c_2023/models/user.dart';
import 'package:dam_1c_2023/models/volunteering.dart';
import 'package:dam_1c_2023/models/volunteering_list.dart';
import 'package:dam_1c_2023/molecules/components.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';
import 'package:dam_1c_2023/molecules/buttons.dart';
import 'package:dam_1c_2023/atoms/icons/arrow_back.dart';
import 'package:provider/provider.dart';

class SelectedCardPage extends StatelessWidget {
  final Volunteering info;

  const SelectedCardPage({Key? key, required this.info}) : super(key: key);

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
                  info.imageName,
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
                  const Text('Acción social', style: overline),
                  Text(info.title, style: headLine01),
                  const Padding(padding: EdgeInsets.only(bottom: 24)),
                  Text(
                    info.description,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 24)),
                  const Text('Sobre la actividad', style: headLine02),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  const Text('Descripción de la actividad', style: body01),
                  const Padding(padding: EdgeInsets.only(bottom: 24)),
                  const Text('Participar del voluntariado', style: headLine02),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  const Text('Requisitos', style: subtitle01),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  Column(
                    children: [
                      for (var req in info.requisites)
                        Row(
                          children: [
                            const Text("\u2022", style: body01),
                            const SizedBox(width: 10),
                            Expanded(child: Text(req, style: body01)),
                          ],
                        ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  const Text('Disponibilidad', style: subtitle01),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  Column(
                    children: [
                      for (var req in info.availability)
                        Row(
                          children: [
                            const Text("\u2022", style: body01),
                            const SizedBox(width: 10),
                            Expanded(child: Text(req, style: body01)),
                          ],
                        ),
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  Vacancies(counter: 10),
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
                      _showCustomDialog(context, info);
                    }),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<void> _showCustomDialog(
    BuildContext context, Volunteering vol) async {
  await showDialog<void>(
    context: context,
    builder: (_) {
      return ApplyDialog(
        title: vol.title,
        cancelButtonText: 'Cancelar',
        confirmButtonText: 'Confirmar',
        onCancelPressed: () => Navigator.of(context).pop(),
        onConfirmPressed: () => addAsParticipant(context, vol),
      );
    },
  );
}

Future<void> addAsParticipant(BuildContext context, Volunteering vol) async {
  final volunteerings = Provider.of<VolunteeringList>(context).volunteering;
  List<Map<String, dynamic>> updatedList = [];
  volunteerings.forEach((element) {
    if (element.id == vol.id) {
      element.participants.add(User(email: 'guido@princ.com', name: 'Guido', lastName: 'Princ'));
    }
    updatedList.add(Volunteering.toJson(element));
  });
  await FirebaseFirestore.instance
    .collection('ser_manos_data')
    .doc('test')
    .update({ 'values': FieldValue.arrayUnion(updatedList)})
    .then((value) => Navigator.of(context).pop());
}

Future<void> removeAsParticipant(BuildContext context, Volunteering vol) async {
  final volunteerings = Provider.of<VolunteeringList>(context).volunteering;
  List<Map<String, dynamic>> updatedList = [];
  volunteerings.forEach((element) {
    if (element.id == vol.id) {
      element.participants.removeWhere((element) => element.email == 'guido@princ.com');
    }
    updatedList.add(Volunteering.toJson(element));
  });
  await FirebaseFirestore.instance
    .collection('ser_manos_data')
    .doc('test')
    .update({ 'values': FieldValue.arrayUnion(updatedList)})
    .then((value) => Navigator.of(context).pop());
}

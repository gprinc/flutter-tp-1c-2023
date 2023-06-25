import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dam_1c_2023/cells/modals.dart';
import 'package:dam_1c_2023/firebase/firebase_cloudstore.dart';
import 'package:dam_1c_2023/models/userService.dart';
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
    int? userVolunteeringId = Provider.of<UserService>(context, listen: false).user?.volunteeringId;
    Volunteering currentUserVolunteering = info;
    if(userVolunteeringId != null && userVolunteeringId != info.id){
      currentUserVolunteering = Provider.of<VolunteeringList>(context, listen: false).volunteering[userVolunteeringId];
    }
    return Scaffold(
      body: SingleChildScrollView(
        child:       Column(
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
                    Vacancies(counter: 10 - info.participantsEmail.length),
                  ],
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 56),
                  child:
                      userVolunteeringId != null && userVolunteeringId != info.id ?
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: Padding(padding: EdgeInsets.only(bottom: 8),
                                  child: Text("Ya estas participando en otro voluntariado, debes abandonarlo primero para postularte a este.",
                                    textAlign: TextAlign.center,)
                              ),
                            ),
                            CtaButton(text: "Abandonar voluntariado actual", handlePress: () { _removeDialog(context, currentUserVolunteering); }, enabledState: true)
                          ],
                        ),
                      ) :
                        info.participantsEmail.contains(Provider.of<UserService>(context, listen: false).user?.email) ?
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const Align(
                                  alignment: Alignment.center,
                                  child: Padding(padding: EdgeInsets.only(bottom: 8),
                                      child: Text("Estas participando", style: headLine02))
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Padding(padding: EdgeInsets.only(bottom: 8),
                                    child: Text("La organización ya confirmó que ya estas participando del voluntariado",
                                      textAlign: TextAlign.center,)
                                ),
                              ),
                              CtaButton(text: "Abandonar voluntariado", handlePress: () { _removeDialog(context, info); }, enabledState: true)
                            ],
                          ),
                        ) :
                        info.appliersEmail.contains(Provider.of<UserService>(context, listen: false).user?.email) ?
                        Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Padding(padding: EdgeInsets.only(bottom: 8),
                                child: Text("Te has postulado", style: headLine02))
                              ),
                              const Align(
                                alignment: Alignment.center,
                                child: Padding(padding: EdgeInsets.only(bottom: 8),
                                child: Text("Pronto la organización se pondrá en contacto contigo y te inscribirá como participante",
                                textAlign: TextAlign.center,)
                                ),
                              ),
                              CtaButton(text: "Retirar postulación", handlePress: () { _removeDialog(context, info); }, enabledState: true)
                            ],
                          ),
                        ) :
                        CtaButton(
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
      )
    );
  }
}

Future<void> _showCustomDialog(
    BuildContext context, Volunteering vol) async {
  await showDialog<void>(
    context: context,
    builder: (_) {
      return ApplyDialog(
        header: 'Te estas por postular a',
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
  final volunteerings = Provider.of<VolunteeringList>(context, listen: false).volunteering;
  final currentUser = Provider.of<UserService>(context, listen: false).user;
  if (currentUser != null) {

    volunteerings.forEach((element) {
      if (element.id == vol.id) {
        element.appliersEmail.add(currentUser.email);
      }
    });

    final userQuery = FirebaseCloudstoreITBA().db.collection('users').where('email', isEqualTo: currentUser.email);
    final userSnapshot = await userQuery.get();

    if (userSnapshot.docs.isNotEmpty) {
      final userDoc = userSnapshot.docs.first.reference;

      await FirebaseFirestore.instance.runTransaction((transaction) async {
        final userData = userSnapshot.docs.first.data();

        // Update or add the 'volunteeringId' field
        userData['volunteeringId'] = vol.id;

        transaction.set(userDoc, userData);
      });

      await FirebaseCloudstoreITBA().db
          .collection('ser_manos_data')
          .doc('voluntariados')
          .set({'values': volunteerings.map(Volunteering.toJson).toList()})
          .then((value) {
            final userService = Provider.of<UserService>(context, listen: false);
            userService.updateVolunteeringId(vol.id);
            userService.notifyListeners();
            Navigator.of(context).pop();
          }
          );
    }
  }
}

Future<void> _removeDialog(
    BuildContext context, Volunteering vol) async {
  await showDialog<void>(
    context: context,
    builder: (_) {
      return ApplyDialog(
        header: '¿Estas seguro que querés retirar tu postulación?',
        title: vol.title,
        cancelButtonText: 'Cancelar',
        confirmButtonText: 'Confirmar',
        onCancelPressed: () => Navigator.of(context).pop(),
        onConfirmPressed: () => removeAsParticipant(context, vol),
      );
    },
  );
}


Future<void> removeAsParticipant(BuildContext context, Volunteering vol) async {
  final volunteerings = Provider.of<VolunteeringList>(context, listen: false).volunteering;
  final currentUser = Provider.of<UserService>(context, listen: false).user;

  if (currentUser != null) {

    volunteerings.forEach((element) {
      if (element.id == vol.id) {
        element.appliersEmail.remove(currentUser.email);
        element.participantsEmail.remove(currentUser.email);
      }
    });

    final userQuery = FirebaseCloudstoreITBA().db.collection('users').where('email', isEqualTo: currentUser.email);
    final userSnapshot = await userQuery.get();

    if (userSnapshot.docs.isNotEmpty) {
      final userDoc = userSnapshot.docs.first.reference;

      try {
        await FirebaseFirestore.instance.runTransaction((transaction) async {
          final userData = userSnapshot.docs.first.data();

          // Update or add the 'volunteeringId' field
          if (userData.containsKey('volunteeringId')) {
            userData.remove('volunteeringId');
            transaction.set(userDoc, userData);
          }
        });
      } catch (error, stackTrace) {
        print('Error running Firestore transaction: $error');
        print('Stack trace:\n$stackTrace');
      }

      await FirebaseCloudstoreITBA().db
          .collection('ser_manos_data')
          .doc('voluntariados')
          .set({'values': volunteerings.map(Volunteering.toJson).toList()})
          .then((value) {
            final userService = Provider.of<UserService>(context, listen: false);
            userService.updateVolunteeringId(null);
            userService.notifyListeners();
            Navigator.of(context).pop();
          });
  }
}}

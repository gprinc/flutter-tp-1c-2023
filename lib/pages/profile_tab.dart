import 'package:dam_1c_2023/cells/cards.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../cells/modal.dart';
import '../cells/profile_modal.dart';
import '../models/user.dart';
import '../molecules/buttons.dart';
import '../tokens/token_fonts.dart';

class ProfileTab extends StatelessWidget {
  final UserModel user;
  const ProfileTab({super.key, required this.user});

  showProfileModal(BuildContext context) {
    buildModal(
        context,
        ProfileModal(
          user: user,
        ));
  }

  Widget filledProfile(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: Image.asset('assets/icon_picture.png'),
                      ),
                      const SizedBox(height: 16),
                      const Text('Voluntario', style: overline),
                      const SizedBox(height: 2),
                      Text('${user.name} ${user.lastName}', style: subtitle01),
                      const SizedBox(height: 2),
                      Text(
                        user.email,
                        style: body01Modif(const Color(0xff0D47A1)),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  InformationCard(
                    title: 'Información personal',
                    label1: 'FECHA DE NACIMIENTO',
                    content1: user.birthDay!,
                    label2: 'Género',
                    content2: user.gender!,
                  ),
                  InformationCard(
                    title: 'Datos de contacto',
                    label1: 'Teléfono',
                    content1: user.phoneNumber!,
                    label2: 'E-MAIL',
                    content2: user.email,
                  ),
                  SizedBox(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: CtaButton(
                              text: 'Editar perfil',
                              handlePress: () => showProfileModal(context),
                              enabledState: true),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextButton(
                          onPressed: () => context.goNamed('login'),
                          child: Text('Cerrar sesion',
                              style: btnModif(const Color(0xffB3261E))),
                        )
                      ],
                    ),
                  )
                ]),
          ),
          SizedBox(
            height: 32,
          )
        ],
      ),
    );
  }

  Widget emptyProfile(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: Image.asset('assets/icon_picture.png'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Voluntario', style: overline),
                  const SizedBox(height: 8),
                  Text('${user.name} ${user.lastName}', style: subtitle01),
                  const SizedBox(height: 8),
                  const Center(
                    child: Text(
                      "¡Completá tu perfil para tener acceso a mejores oportunidades!",
                      style: body01,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      const SizedBox(height: 16),
      Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 80),
          child: ShortButton(
            handlePress: () => showProfileModal(context),
            text: 'Completar',
            enabledState: true,
          ),
        ),
      ),
      const SizedBox(height: 16),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return user.phoneNumber == null || user.phoneNumber == ''
        ? emptyProfile(context)
        : filledProfile(context);
  }
}

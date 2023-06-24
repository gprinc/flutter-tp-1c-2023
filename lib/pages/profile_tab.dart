import 'package:dam_1c_2023/cells/cards.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../cells/modal.dart';
import '../cells/profile_modal.dart';
import '../models/user.dart';
import '../molecules/buttons.dart';
import '../tokens/token_fonts.dart';

class ProfileTab extends StatelessWidget {
  final UserITBA user;
  const ProfileTab({super.key, required this.user});

  showProfileModal(BuildContext context) {
    buildModal(context, const ProfileModal());
  }

  Widget filledProfile(BuildContext context) {
    return Column(
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
                      child: Image.asset('assets/profile.png'),
                    ),
                    const SizedBox(height: 16),
                    const Text('Voluntario', style: overline),
                    const SizedBox(height: 2),
                    const Text('Juan Cruz Gonzalez', style: subtitle01),
                    const SizedBox(height: 2),
                    Text(
                      "mimail@gmail.com",
                      style: body01Modif(const Color(0xff0D47A1)),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                const InformationCard(
                  title: 'Información personal',
                  label1: 'FECHA DE NACIMIENTO',
                  content1: '10/08/1990',
                  label2: 'Género',
                  content2: 'Hombre',
                ),
                const InformationCard(
                  title: 'Datos de contacto',
                  label1: 'Teléfono',
                  content1: '+5491165863216',
                  label2: 'E-MAIL',
                  content2: 'mimail@gmail.com',
                ),
                SizedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CtaButton(
                          text: 'Editar perfil',
                          handlePress: () => showProfileModal(context),
                          enabledState: true),
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
          height: 22,
        )
      ],
    );
  }

  Widget emptyProfile(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                    child: Image.asset('assets/profile.png'),
                  ),
                  const SizedBox(height: 16),
                  const Text('Voluntario', style: overline),
                  const SizedBox(height: 8),
                  const Text('Juan Cruz', style: subtitle01),
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
        child: Container(
          width: 123,
          height: 48,
          margin: const EdgeInsets.only(bottom: 80),
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
    return user. ? emptyProfile(context) : filledProfile(context);
  }
}

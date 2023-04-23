import 'package:dam_1c_2023/cells/cards.dart';
import 'package:dam_1c_2023/models/card_list.dart';
import 'package:dam_1c_2023/molecules/buttons.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../atoms/logos.dart';
import '../tokens/token_colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final cardsProvider = Provider.of<CardList>(context);
    return DefaultTabController(
      // --> Puedo manejar el estado del TabBar de forma automatica.
      // Es una clase "Inherited" que no convenia a veces.
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 14),
              child: rectangularLogo,
            ),
            bottom: PreferredSize(
              preferredSize: _tabBar.preferredSize,
              child: Container(color: inactiveTab, child: _tabBar),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: TabBarView(
                  children: [
                    ListView(
                      children: [
                        GestureDetector(
                          onTap: () => context.go('/selected-card'),
                          child: const VolunteeringCard(
                              title: 'Un techo para mi país',
                              imageName: 'assets/voluntariado.png'),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/selected-card'),
                          child: const VolunteeringCard(
                              title: 'Manos caritativas',
                              imageName: 'assets/manos.png'),
                        ),
                        GestureDetector(
                          onTap: () => context.go('/selected-card'),
                          child: const VolunteeringCard(
                              title: 'Iglesia',
                              imageName: 'assets/iglesia.png'),
                        ),
                      ],
                    ),
                    // The other tabs...
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
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
                        Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          child: SizedBox(
                            width: 123,
                            height: 48,
                            child: ShortButton(
                              handlePress: () {
                                // Do something when the button is pressed
                              },
                              text: 'Completar',
                              enabledState: true,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                    Column(),
                  ],
                ),
              ))
            ],
          )),
    );
  }

  TabBar get _tabBar => const TabBar(
          indicator: BoxDecoration(color: selectedTab),
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Postulaciones'),
            Tab(text: 'Mi Perfil'),
            Tab(text: 'Novedades'),
          ]);
}


        /*body: Column(
          children: [
            Container(color: unselectedColor, child: _tabBar),

            Si no le pongo el expanded me tira este error:
            The following assertion was thrown during performResize():
            Horizontal viewport was given unbounded height.
            Expanded(
              child: TabBarView(children: [
                1st Tab
                const PostulacionesBody(),
                PostulacionesBody(),
                Center(
                  child: Container(
                    height: 100,
                    width: 100,
                    color: Colors.orange,
                  ),
                ),
                Container(
                  color: Colors.blueAccent,
                ),
              ]),
            ),
          ],
        )*/
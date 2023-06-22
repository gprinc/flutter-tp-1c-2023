import 'dart:math';

import 'package:dam_1c_2023/cells/cards.dart';
import 'package:dam_1c_2023/models/newsList.dart';
import 'package:dam_1c_2023/models/volunteering_list.dart';
import 'package:dam_1c_2023/molecules/buttons.dart';
import 'package:dam_1c_2023/molecules/inputs.dart';
import 'package:dam_1c_2023/pages/profile_tab.dart';
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
    final volunteeringProvider = Provider.of<VolunteeringList>(context);
    final newsProvider = Provider.of<NewsList>(context);
    return DefaultTabController(
      // --> Puedo manejar el estado del TabBar de forma automatica.
      // Es una clase "Inherited" que no convenia a veces.
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 41,
            leadingWidth: 197,
            elevation: 0,
            leading: SizedBox(
              width: 50, // Adjust this value as needed
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: rectangularLogo,
                  ),
                ],
              ),
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
                    ListView.builder(
                        itemCount: volunteeringProvider.volunteering.length + 1,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == 0) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: SearchInput(search: () {
                                // Handle search input here
                              }),
                            );
                          }
                          final volunteering =
                              volunteeringProvider.volunteering[index - 1];
                          return Column(
                            children: [
                              GestureDetector(
                                child: VolunteeringCard(
                                    title: volunteering.title,
                                    imageName: volunteering.imageName),
                                onTap: () => context.goNamed('selected-card',
                                    params: {'id': index.toString()}),
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        }),
                    // The other tabs...
                    const ProfileTab(isEmpty: false),
                    // NOVEDADES
                    Padding(
                      padding: EdgeInsets.only(top: 32.0),
                      child: ListView.builder(
                        itemCount: newsProvider.news.length,
                        itemBuilder: (BuildContext context, int index) {
                          final news = newsProvider.news[index];
                          return Column(
                            children: [
                              NewsCard(
                                  index: index,
                                  title: news.title,
                                  header: news.header,
                                  description: news.description,
                                  imageName: news.imageName),
                              const SizedBox(height: 24),
                            ],
                          );
                        },
                      ),
                    )
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

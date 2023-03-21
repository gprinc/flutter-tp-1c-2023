import 'package:flutter/material.dart';
import '../atoms/logos.dart';
import '../tokens/token_colors.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      // --> Puedo manegar el estado del TabBar de forma automatica.
      // Es una clase "Inherited" que no convenia a veces.
      length: 3,
      child: Scaffold(
        appBar: AppBar(
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
        /*body: Column(
          children: [
            Container(color: unselectedColor, child: _tabBar),

            // Si no le pongo el expanded me tira este error:
            // The following assertion was thrown during performResize():
            //Horizontal viewport was given unbounded height.
            Expanded(
              child: TabBarView(children: [
                // 1st Tab
                //const PostulacionesBody(),
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
      ),
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

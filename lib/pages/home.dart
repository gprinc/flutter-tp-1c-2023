import 'package:dam_1c_2023/atoms/icons/location.dart';
import 'package:dam_1c_2023/cells/cards.dart';
import 'package:dam_1c_2023/models/newsList.dart';
import 'package:dam_1c_2023/models/volunteering.dart';
import 'package:dam_1c_2023/models/volunteering_list.dart';
import 'package:dam_1c_2023/molecules/buttons.dart';
import 'package:dam_1c_2023/molecules/inputs.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../atoms/logos.dart';
import '../tokens/token_colors.dart';

class Home extends StatefulWidget {
  const Home({required Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  var isMapVisible = false;

  List<Volunteering> _foundCards = [];
  List<Volunteering> _allCards = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _allCards =
        Provider.of<VolunteeringList>(context, listen: false).volunteering;
    _foundCards = _allCards;
  }

  void _runFilter(String enteredKeyword) {
    List<Volunteering> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allCards;
    } else {
      results = Provider.of<VolunteeringList>(context, listen: false)
          .searchVolunteerings(enteredKeyword);
    }

    setState(() {
      _foundCards = results;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                child: TabBarView(
                  children: [
                    // Postulaciones
                    if (isMapVisible)
                      Stack(
                        children: [
                          Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: SearchInput(
                                  search: (value) {
                                    _runFilter(value);
                                  },
                                  toggleMapVisibility: (bool value) {
                                    setState(() {
                                      isMapVisible = value;
                                    });
                                  },
                                  isMapVisible: isMapVisible,
                                ),
                              )),
                          const Positioned(
                              bottom: 286, right: 16, child: LocationIcon()),
                          Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                height: 270,
                                child: ListView.builder(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  itemCount: 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return _buildCarousel(context, index ~/ 2);
                                  },
                                ),
                              ))
                        ],
                      )
                    else
                      ListView.builder(
                          itemCount: _foundCards.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == 0) {
                              return Padding(
                                padding: const EdgeInsets.all(16),
                                child: SearchInput(
                                  search: (value) {
                                    _runFilter(value);
                                  },
                                  toggleMapVisibility: (bool value) {
                                    setState(() {
                                      isMapVisible = value;
                                    });
                                  },
                                  isMapVisible: isMapVisible,
                                ),
                              );
                            }
                            final volunteering = _foundCards[index - 1];
                            return Column(
                              children: [
                                SizedBox(
                                  height: 238,
                                  width: 328,
                                  child: GestureDetector(
                                    child: VolunteeringCard(
                                        title: volunteering.title,
                                        imageName: volunteering.imageName),
                                    onTap: () => context.goNamed(
                                        'selected-card',
                                        params: {'id': index.toString()}),
                                  ),
                                ),
                                const SizedBox(height: 24),
                              ],
                            );
                          }),

                    // MI PERFIL
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              decoration: const BoxDecoration(),
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

                    // NOVEDADES
                    Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: ListView.builder(
                        itemCount: newsProvider.news.length,
                        itemBuilder: (BuildContext context, int index) {
                          final news = newsProvider.news[index];
                          return Column(
                            children: [
                              NewsCard(
                                title: news.title,
                                header: news.header,
                                description: news.description,
                                imageName: news.imageName,
                              ),
                              const SizedBox(height: 24),
                            ],
                          );
                        },
                      ),
                    )
                  ],
                ),
              )
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

Widget _buildCarousel(BuildContext context, int carouselIndex) {
  final volunteeringProvider =
      Provider.of<VolunteeringList>(context, listen: false);
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      SizedBox(
        // you may want to use an aspect ratio here for tablet support
        height: 234.0,
        child: PageView.builder(
          itemCount: volunteeringProvider.volunteering.length,
          // store this controller in a State to save the carousel scroll position
          controller: PageController(viewportFraction: 0.8),
          itemBuilder: (BuildContext context, int itemIndex) {
            return _buildCarouselItem(
                context, carouselIndex, itemIndex, volunteeringProvider);
          },
        ),
      )
    ],
  );
}

Widget _buildCarouselItem(
    BuildContext context, int carouselIndex, int itemIndex, provider) {
  final volunteering = provider.volunteering[itemIndex];
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 0.0),
    child: GestureDetector(
      child: VolunteeringCard(
          title: volunteering.title, imageName: volunteering.imageName),
      onTap: () => context
          .goNamed('selected-card', params: {'id': itemIndex.toString()}),
    ),
  );
}

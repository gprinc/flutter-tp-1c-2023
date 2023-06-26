import 'package:dam_1c_2023/atoms/icons/location.dart';
import 'package:dam_1c_2023/cells/cards.dart';
import 'package:dam_1c_2023/models/newsList.dart';
import 'package:dam_1c_2023/models/user.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:dam_1c_2023/models/volunteering.dart';
import 'package:dam_1c_2023/models/volunteering_list.dart';
import 'package:dam_1c_2023/molecules/buttons.dart';
import 'package:dam_1c_2023/molecules/inputs.dart';
import 'package:dam_1c_2023/pages/profile_tab.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../atoms/logos.dart';
import '../models/userService.dart';
import '../tokens/token_colors.dart';

class Home extends StatefulWidget {
  final int initialTabIndex;

  const Home({required Key key, this.initialTabIndex = 0}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
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
  void initState() {
      Provider.of<VolunteeringList>(context, listen: false).getFromFirebase();
      Provider.of<NewsList>(context, listen: false).getFromFirebase();
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final newsProvider = Provider.of<NewsList>(context);
    UserModel? currentUser =
        Provider.of<UserService>(context, listen: false).user;

    return DefaultTabController(
      initialIndex: widget.initialTabIndex,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 41,
            //leadingWidth: 197,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 0),
                  child: rectangularLogo,
                ),
              ],
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
                      Container(
                          color: secondaryBlue,
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                children: [
                                  Flexible(
                                      child: ListView.builder(
                                          itemCount: _foundCards.length + 1,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            if (index == 0) {
                                              return Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 24,
                                                            bottom: 32),
                                                    child: SearchInput(
                                                      search: (value) {
                                                        _runFilter(value);
                                                      },
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: currentUser?.volunteeringId != null,
                                                    child: Column(
                                                      children: [
                                                        const Padding(
                                                          padding: EdgeInsets.only(bottom: 24),
                                                          child: Align(
                                                            alignment: Alignment.centerLeft,
                                                            child: Text(
                                                              'Tu actividad',
                                                              style: headLine01,
                                                            ),
                                                          ),
                                                        ),
                                                        if (currentUser?.volunteeringId != null && _allCards.isNotEmpty)
                                                          Padding(
                                                            padding: const EdgeInsets.only(bottom: 24),
                                                            child: GestureDetector(
                                                              child: CurrentVolunteeringCard(
                                                                volunteering: _allCards[currentUser!.volunteeringId!],
                                                              ),
                                                              onTap: () => context.goNamed(
                                                                'selected-card',
                                                                params: {
                                                                  'id': currentUser.volunteeringId?.toString() ?? '',
                                                                },
                                                              ),
                                                            ),
                                                          )
                                                      ],
                                                    ),
                                                  ),
                                                  const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 24),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Text(
                                                          'Voluntariados',
                                                          style: headLine01,
                                                        ),
                                                      )),
                                                  if (_foundCards.isEmpty &&
                                                      _allCards.isEmpty)
                                                    const EmptyVolunteeringCard(
                                                        msg:
                                                            'Actualmente no hay voluntariados vigentes. Pronto se iran incorporando nuevos')
                                                  else if (_foundCards.isEmpty)
                                                    const EmptyVolunteeringCard(
                                                      msg:
                                                          'No hay voluntariados vigentes para tu búsqueda.',
                                                    )
                                                ],
                                              );
                                            }
                                            final volunteering =
                                                _foundCards[index - 1];
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  child: VolunteeringCard(
                                                      volunteering:
                                                          volunteering,
                                                      currentUser: currentUser),
                                                  onTap: () => context.goNamed(
                                                      'selected-card',
                                                      params: {
                                                        'id': volunteering.id.toString()
                                                      }),
                                                ),
                                                const SizedBox(height: 24),
                                              ],
                                            );
                                          }))
                                ],
                              ))),

                    // MI PERFIL
                    ProfileTab(user: Provider.of<UserService>(context).user!),
                    // NOVEDADES
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 32.0, right: 16.0, left: 16.0),
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
              )
            ],
          )),
    );
  }

  TabBar get _tabBar => const TabBar(
          indicator: BoxDecoration(color: selectedTab),
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Postularse'),
            Tab(text: 'Mi Perfil'),
            Tab(text: 'Novedades'),
          ]);
}

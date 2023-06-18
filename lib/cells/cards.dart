import 'package:dam_1c_2023/tokens/token_colors.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:dam_1c_2023/tokens/token_shadows.dart';
import 'package:flutter/material.dart';

import '../atoms/icons/vol_location.dart';
import '../molecules/components.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class VolunteeringCard extends StatelessWidget {
  final String title;
  final String imageName;

  const VolunteeringCard({
    Key? key,
    required this.title,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 234,
      width: 328,
      decoration: cardShadow,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        child: Column(
          children: [
            SizedBox(
              height: 135,
              child: Image.asset(
                imageName,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ACCIÓN SOCIAL',
                    style: overline,
                  ),
                  Text(
                    title,
                    style: subtitle01,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 115),
                        child: Vacancies(counter: 10),
                      ),
                      const Icon(
                        Icons.favorite_border,
                        color: primary,
                      ),
                      VolLocation(() {
                        //MapsLauncher.launchQuery('Palmar 6841');
                        openMap('Palmar 6841');
                      })
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> openMap(String location) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$location';
  final Uri url = Uri.parse(googleUrl);
  // ignore: unnecessary_null_comparison
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not open the map.';
  }
}

class EmptyVolunteeringCard extends StatelessWidget {
  const EmptyVolunteeringCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: neutralBg,
      height: 108,
      child: const Align(
        alignment: Alignment.center,
        child: Text(
          'No hay voluntariados vigentes para tu búsqueda.',
          style: subtitle01,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String header;
  final String description;
  final String imageName;

  const NewsCard({
    Key? key,
    required this.title,
    required this.header,
    required this.description,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 156,
      child: Card(
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  imageName,
                  width: 118,
                  fit: BoxFit.cover,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(header, style: overline),
                            const SizedBox(height: 8),
                            Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: subtitle01,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: body02,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                              onPressed: () {
                                // TODO: Handle "Leer mas" button press
                              },
                              child: const Text("Leer mas", style: btnGreen),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

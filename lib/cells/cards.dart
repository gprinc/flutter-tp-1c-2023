import 'package:dam_1c_2023/models/user.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:dam_1c_2023/models/volunteering.dart';
import 'package:dam_1c_2023/models/volunteering_list.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:dam_1c_2023/tokens/token_shadows.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../atoms/icons/vol_location.dart';
import '../molecules/components.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';
import '../molecules/buttons.dart';
import '../tokens/token_colors.dart';

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  bool _isImageSelected = false;

  String get btnText => _isImageSelected ? 'Cambiar foto' : 'Subir foto';

  void _selectImage() {
    setState(() {
      _isImageSelected = true;
    });
  }

  Widget getCardDisposition() {
    return _isImageSelected
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Foto de perfil',
                    style: subtitle01,
                  ),
                  const SizedBox(height: 8),
                  ShortButton(
                    handlePress: _selectImage,
                    text: btnText,
                    enabledState: true,
                  ),
                ],
              ),
              SizedBox(
                width: 84,
                height: 84,
                child: Image.asset('assets/profile.png'),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Foto de perfil',
                style: subtitle01,
              ),
              const SizedBox(height: 8),
              ShortButton(
                handlePress: _selectImage,
                text: btnText,
                enabledState: true,
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 328,
        decoration: const BoxDecoration(
            color: profile,
            borderRadius: BorderRadius.all(Radius.circular(4.0))),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 14, bottom: 14, left: 16, right: 16),
          child: getCardDisposition(),
        ));
  }
}

class InformationCard extends StatelessWidget {
  final String title;
  final String label1;
  final String content1;
  final String label2;
  final String content2;

  const InformationCard(
      {super.key,
      required this.label1,
      required this.content1,
      required this.label2,
      required this.content2,
      required this.title});

  Widget _tile(String label, String content) {
    return Row(
      children: [
        Container(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              //crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: body01,
                ),
                Text(
                  content,
                  style: overline,
                )
              ]),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 328,
      height: 136,
      color: cardBg,
      child: Column(children: [
        Container(
          color: profile,
          height: 40,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
                child: Text(
                  title,
                  style: subtitle01,
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [_tile(label1, content1), _tile(label2, content2)],
          ),
        ))
      ]),
    );
  }
}

class InputCard extends StatefulWidget {
  final void Function(String?) handlePick;
  const InputCard({super.key, required this.handlePick});

  @override
  State<InputCard> createState() => _InputCardState();
}

class _InputCardState extends State<InputCard> {
  String? genero;

  Widget _radio(String text) {
    return Row(
      children: [
        SizedBox(
          height: 20,
          width: 20,
          child: Radio<String>(
            value: text,
            groupValue: genero,
            onChanged: (String? value) {
              widget.handlePick(value);
              genero = value;
            },
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        TextButton(
            onPressed: () {
              widget.handlePick(text);
              genero = text;
            },
            child: Text(
              text,
              style: body01,
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4.0), topRight: Radius.circular(4.0))),
      height: 152,
      width: 328,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: profile,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(4.0),
                    topRight: Radius.circular(4.0))),
            height: 40,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
                  child: Text(
                    'Información de perfil',
                    style: subtitle01,
                  ),
                )
              ],
            ),
          ),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.min,
              children: [
                _radio("Hombre"),
                _radio("Mujer"),
                _radio("No binario")
              ],
            ),
          ))
        ],
      ),
    );
  }
}

class VolunteeringCard extends StatelessWidget {
  final Volunteering volunteering;
  final void Function(Volunteering) onFavoritePressed;

  const VolunteeringCard({
    Key? key,
    required this.volunteering,
    required this.onFavoritePressed
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
                volunteering.imageName,
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
                    volunteering.title,
                    style: subtitle01,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 115),
                        child: Vacancies(counter: 10 - volunteering.participants.length),
                      ),
                      IconButton(
                        onPressed: () => onFavoritePressed(volunteering),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(
                          volunteering.favoritos.contains('guido@princ.com') ? Icons.favorite : Icons.favorite_border,
                          color: primary,)
                      ),
                      VolLocation(() {
                        openMap(volunteering.address);
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

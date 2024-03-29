import 'package:dam_1c_2023/atoms/icons/heart.dart';
import 'package:dam_1c_2023/models/user.dart';
import 'package:dam_1c_2023/models/volunteering.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:dam_1c_2023/tokens/token_shadows.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../atoms/icons/vol_location.dart';
import '../models/volunteering_list.dart';
import '../molecules/components.dart';
import 'package:url_launcher/url_launcher.dart';
import '../molecules/buttons.dart';

class ProfilePicture extends StatefulWidget {
  final void Function(String?) handleImageSelect;
  final String? encodedImage;

  const ProfilePicture(
      {super.key, required this.handleImageSelect, this.encodedImage});

  @override
  State<ProfilePicture> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  late bool _isImageSelected;

  String get btnText => _isImageSelected ? 'Cambiar foto' : 'Subir foto';

  @override
  void initState() {
    super.initState();
    _isImageSelected = widget.encodedImage != null;
  }

  void _pickFile() async {
    FilePickerResult? result;

    result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      Uint8List? selectedBytes = result.files.single.bytes;
      if (selectedBytes != null) {
        setState(() {
          _isImageSelected = true;
        });
        widget.handleImageSelect(base64Encode(selectedBytes));
      }
    } else {
      widget.handleImageSelect(null);
    }
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
                    handlePress: _pickFile,
                    text: btnText,
                    enabledState: true,
                    icon: false,
                  ),
                ],
              ),
              SizedBox(
                  width: 84,
                  height: 84,
                  child: Image.memory(base64Decode(widget.encodedImage!))),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Foto de perfil',
                style: subtitle01,
              ),
              ShortButton(
                handlePress: _pickFile,
                text: btnText,
                icon: false,
                enabledState: true,
              ),
            ],
          );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: overline,
              ),
              Text(
                content,
                style: body01,
              )
            ]),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
        GestureDetector(
          onTap: () {
            widget.handlePick(text);
            genero = text;
          },
          child: Text(
            text,
            style: body01,
          ),
        )
        //),
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

class CurrentVolunteeringCard extends StatelessWidget {
  final Volunteering volunteering;

  const CurrentVolunteeringCard({
    Key? key,
    required this.volunteering,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 72,
      decoration: cardShadow,
      child: Card(
        color: primaryLight,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: const BorderSide(color: primary)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      "ACCIÓN SOCIAL",
                      style: overline,
                    ),
                    Text(
                      volunteering.title,
                      style: subtitle01,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: VolLocationNoPadding(() {
                  openMap(volunteering.address);
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class VolunteeringCard extends StatefulWidget {
  final Volunteering volunteering;
  final UserModel? currentUser;

  const VolunteeringCard(
      {Key? key, required this.volunteering, this.currentUser})
      : super(key: key);

  @override
  State<VolunteeringCard> createState() => _VolunteeringCardState();
}

class _VolunteeringCardState extends State<VolunteeringCard> {
  bool? showFav;

  void onFavoritePressed(Volunteering vol) {
    if (widget.currentUser != null) {
      Provider.of<VolunteeringList>(context, listen: false)
          .updateFavorites(vol, widget.currentUser!.email)
          .then((value) => {
                setState(() {
                  showFav = true;
                })
              });
    }
  }

  @override
  Widget build(BuildContext context) {
    showFav = widget.volunteering.favoritos.contains(widget.currentUser?.email);
    return Container(
      //height: 234,
      decoration: cardShadow,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(2),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 138,
                    child: Image.asset(
                      widget.volunteering.imageName,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 8, left: 16, right: 16, bottom: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ACCIÓN SOCIAL',
                    style: overline,
                  ),
                  Text(
                    widget.volunteering.title,
                    style: subtitle01,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VacanciesNoConstrains(
                        counter:
                            10 - widget.volunteering.participantsEmail.length,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FavoriteIcon(
                            callback: () =>
                                onFavoritePressed(widget.volunteering),
                            icon: showFav == null || !showFav!
                                ? Icons.favorite_border
                                : Icons.favorite,
                            color: primary,
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(right: 4.0, left: 4.0),
                            child: VolLocationNoPadding(() {
                              openMap(widget.volunteering.address);
                            }),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            )
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
  final String msg;

  const EmptyVolunteeringCard({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: neutralBg,
      height: 108,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            msg,
            style: subtitle01,
            textAlign: TextAlign.center,
          ),
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
  final int index;

  const NewsCard({
    Key? key,
    required this.index,
    required this.title,
    required this.header,
    required this.description,
    required this.imageName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              imageName,
              width: 118,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(header, style: overline),
                    const SizedBox(height: 2),
                    Text(title, style: subtitle01),
                    const SizedBox(height: 2),
                    Text(description, style: body02),
                    //Text('Leer Más', style: btnModif(primary)),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 8.0, left: 8.0, top: 12),
                          child: TextButton(
                            onPressed: () => context.goNamed('selected-news',
                                params: {'id': index.toString()}),
                            child: Text('Leer Más', style: btnModif(primary)),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

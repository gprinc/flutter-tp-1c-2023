import 'package:dam_1c_2023/atoms/icons/arrow_back.dart';
import 'package:dam_1c_2023/molecules/buttons.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';
import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class NewsPage extends StatelessWidget {
  final String imageName;
  final String title;
  final String description;
  final String body;
  final String header;
  final int index;

  const NewsPage(
      {super.key,
      required this.imageName,
      required this.title,
      required this.description,
      required this.header,
      required this.body,
      required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: const ArrowBackIcon(),
          title: Padding(
            padding: const EdgeInsets.only(right: 40, top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Novedades',
                    style: subtitle01Modif(neutralBg),
                  ),
                ),
              ],
            ),
          )
          /*adding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, right: 40, left: 64),
          child: Text(
            'Novedades',
            style: subtitle01Modif(neutralBg),
          ),
        ),*/
          ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(
              top: 24.0, left: 16.0, right: 16.0, bottom: 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    header,
                    style: overline,
                  ),
                ],
              ),
              Text(
                title,
                style: headLine02,
              ),
              SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    width: 328,
                    height: 160,
                    child: Image.asset(
                      imageName,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
              // Imagen
              SizedBox(
                height: 16,
              ),
              Text(
                description,
                style: subtitle01Modif(secondaryBlue),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                body,
                style: body01,
                textAlign: TextAlign.start,
              ),
              SizedBox(
                height: 16,
              ),
              Center(
                  child: Text(
                'Comparte esta nota',
                style: headLine02,
              )),
              SizedBox(
                height: 16,
              ),
              CtaButton(
                  text: 'Compartir',
                  handlePress: () {
                    Share.share(
                        'mira esta novedad: https://sermanos.com/selected-news/' +
                            index.toString());
                  },
                  enabledState: true)
            ],
          ),
        ),
      ),
    );
  }
}

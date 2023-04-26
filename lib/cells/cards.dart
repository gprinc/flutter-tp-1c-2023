import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';

class VolunteeringCard extends StatelessWidget {
  final String title;
  final String imageName;

  const VolunteeringCard(
      {Key? key, required this.title, required this.imageName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Card(
        child: Column(children: [
          Image.asset(
            imageName,
            height: 138,
            width: 328,
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [const Text('ACCIÓN SOCIAL'), Text(title)],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: const [
                    Icon(Icons.favorite_border),
                    SizedBox(
                      width: 23,
                    ),
                    Icon(Icons.location_on),
                  ],
                )
              ],
            ),
          )
        ]),
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(header, style: overline),
                    const SizedBox(height: 8),
                    Text(title, style: subtitle01),
                    const SizedBox(height: 8),
                    Text(description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: body02),
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

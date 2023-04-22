import 'package:flutter/material.dart';

class VolunteeringCard extends StatelessWidget {
  final String title;
  final Image image;

  const VolunteeringCard({Key? key, required this.title, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: image.width,
      child: Card(
        child: Column(children: [
          image,
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

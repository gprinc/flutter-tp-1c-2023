import 'package:dam_1c_2023/atoms/logos.dart';
import 'package:flutter/material.dart';

class VolunteeringCard extends StatelessWidget {
  const VolunteeringCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: volunteering.width,
      child: Card(
        child: Column(children: [
          volunteering,
          Padding(
            padding:
                const EdgeInsets.only(top: 8, bottom: 16, left: 16, right: 18),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('ACCIÓN SOCIAL'),
                    Text('Un Techo para mi País')
                  ],
                )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
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

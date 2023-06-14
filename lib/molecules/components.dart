import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';

class Vacancies extends StatelessWidget {
  final int counter;

  Vacancies({required this.counter});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 20,
      top: 26,
      child: Row(
        children: [
          Container(
            width: 117,
            height: 28,
            decoration: BoxDecoration(
              color: const Color(0xFFCAE5FB),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    'Vacantes:',
                    style: body02,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 11.33, right: 2),
                  child: Icon(
                    Icons.person,
                    size: 18,
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: Text(
                      counter.toString(),
                      style: subtitle01,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';

class Vacancies extends StatelessWidget {
  final int counter;

  Vacancies({required this.counter});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 117,
        height: 28,
        decoration: BoxDecoration(
          color: const Color(0xFFCAE5FB),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                padding: EdgeInsets.only(left: 10, right: 2),
                child: Icon(
                  Icons.person,
                  size: 15,
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
        ));
  }
}
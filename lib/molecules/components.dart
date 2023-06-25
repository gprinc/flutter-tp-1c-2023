import 'package:dam_1c_2023/tokens/token_colors.dart';
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

class VacanciesNoConstrains extends StatelessWidget {
  final int counter;
  const VacanciesNoConstrains({required this.counter, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.only(right: 8.0, left: 8.0, top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFCAE5FB),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Vacantes:',
            style: body02,
          ),
          const SizedBox(
            width: 8.0,
          ),
          const Icon(
            Icons.person,
            size: 20,
            color: selectedTab,
          ),
          Text(
            counter.toString(),
            style: subtitle01Modif(selectedTab),
          )
        ],
      ),
    );
  }
}

import 'package:dam_1c_2023/cells/forms.dart';
import 'package:dam_1c_2023/molecules/inputs.dart';
import 'package:flutter/material.dart';
import 'package:dam_1c_2023/molecules/buttons.dart';

import 'package:flutter/material.dart';

class SelectedCardPage extends StatelessWidget {
  const SelectedCardPage({Key? key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 243, // set the height here
            width: double.infinity,
            child: Image.asset(
              'assets/voluntariado.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const <Widget>[
                  Text(
                    'Title',
                    style: TextStyle(
                      fontSize: 24, 
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Roboto',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: 24)
                  ),
                  Text(
                    'Some text here',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400
                      ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child:
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: const EdgeInsets.only(bottom: 56),
                    child: CtaButton(
                    text: 'Button Text',
                    handlePress: () {
                      // Handle button press here
                    },
                    enabledState: true,
                    disableAfterPress: false,
                  ),
                ),
              )
          )
        ],
      ),
    );
  }
}

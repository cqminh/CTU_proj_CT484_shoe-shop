import 'dart:math';

import 'package:flutter/material.dart';

class AppBanner extends StatelessWidget {
  const AppBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 94.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(
                    0xff2f2fa4),
        boxShadow: const [
          BoxShadow(
            blurRadius: 8,
            color: Colors.black26,
            offset: Offset(0, 6),
          )
        ],
      ),
      child: Text(
        'H&M',
        style: TextStyle(
          color: Color(0xfff64c72),
          fontSize: 50,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

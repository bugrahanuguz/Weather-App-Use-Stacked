// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';


class IconWidget extends StatelessWidget {
  final String assetName;
  const IconWidget({
    Key? key,
    required this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.2,
      child: Image.asset(
        "assets/weather/icon_$assetName.png",
        fit: BoxFit.cover,
      ),
    );
  }
}

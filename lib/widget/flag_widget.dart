import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlagWidget extends StatelessWidget {

  const FlagWidget({
    super.key,
    required this.code,
  });
  final String code;

  @override
  Widget build(BuildContext context) {
    final urlImage = 'assets/countries/$code.svg';

    return SvgPicture.asset(
      urlImage,
      height: 30,
      width: 30,
      fit: BoxFit.cover,
    );
  }
}

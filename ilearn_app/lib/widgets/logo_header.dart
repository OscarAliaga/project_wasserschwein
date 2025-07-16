import 'package:flutter/material.dart';

class LogoHeader extends StatelessWidget {
  final bool enableBack;

  const LogoHeader({super.key, this.enableBack = false});

  @override
  Widget build(BuildContext context) {
    final logo = Image.asset('assets/images/logo-06.png', height: 70);

    return Padding(
  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  child: SizedBox(
    height: 70, // ajusta según el tamaño de tu logo
    child: Stack(
      alignment: Alignment.center,
      children: [
        if (enableBack)
          const Align(
            alignment: Alignment.centerLeft,
            child: BackButton(),
          ),
        Center(
          child: GestureDetector(
            onTap: enableBack ? () => Navigator.pop(context) : null,
            child: logo,
          ),
        ),
      ],
    ),
  ),
);
  }
}

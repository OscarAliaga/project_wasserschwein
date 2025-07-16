import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class BackgroundContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;

  const BackgroundContainer({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Provider.of<ThemeProvider>(context).isDarkMode;

    return SizedBox.expand( // ✅ ocupa todo el espacio disponible
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              isDark
                  ? 'assets/images/fondo_night.png'
                  : 'assets/images/fondo_bright.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

enum UserRole { student, parent, teacher }

class RoleTheme {
  final Color backgroundColor;
  final Color accentColor;
  final Color textColor;
  final Color subtitleColor;

  /// Nuevo: estilo personalizado de botón por rol
  final ButtonStyle? buttonStyle;

  const RoleTheme({
    required this.backgroundColor,
    required this.accentColor,
    required this.textColor,
    required this.subtitleColor,
    this.buttonStyle,
  });
}

class RoleThemes {
  static RoleTheme forRole(BuildContext context, UserRole role) {
    final brightness = Theme.of(context).brightness;

    switch (role) {
      case UserRole.student:
        return RoleTheme(
          backgroundColor: brightness == Brightness.dark
              ? Colors.teal.shade700
              : Colors.teal.shade300,
          accentColor: brightness == Brightness.dark
              ? Colors.tealAccent.shade200
              : Colors.teal.shade800,
          textColor: brightness == Brightness.dark ? Colors.white : Colors.black87,
          subtitleColor: brightness == Brightness.dark ? Colors.white70 : Colors.black54,
          buttonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.tealAccent.shade100;
              }
              return Colors.teal.shade600;
            }),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(60)),
            textStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );

      case UserRole.parent:
        return RoleTheme(
          backgroundColor: brightness == Brightness.dark
              ? Colors.deepOrange.shade700
              : Colors.orange.shade300,
          accentColor: brightness == Brightness.dark
              ? Colors.orangeAccent.shade200
              : Colors.deepOrange.shade700,
          textColor: brightness == Brightness.dark ? Colors.white : Colors.black87,
          subtitleColor: brightness == Brightness.dark ? Colors.white70 : Colors.black54,
          buttonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.deepOrangeAccent.shade100;
              }
              return Colors.deepOrange.shade600;
            }),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(60)),
            textStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );

      case UserRole.teacher:
        return RoleTheme(
          backgroundColor: brightness == Brightness.dark
              ? Colors.indigo.shade700
              : Colors.indigo.shade300,
          accentColor: brightness == Brightness.dark
              ? Colors.indigoAccent.shade200
              : Colors.indigo.shade800,
          textColor: brightness == Brightness.dark ? Colors.white : Colors.black87,
          subtitleColor: brightness == Brightness.dark ? Colors.white70 : Colors.black54,
          buttonStyle: ButtonStyle(
            backgroundColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.hovered)) {
                return Colors.indigoAccent.shade100;
              }
              return Colors.indigo.shade600;
            }),
            foregroundColor: MaterialStateProperty.all(Colors.white),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(60)),
            textStyle: MaterialStateProperty.all(
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        );
    }
  }
}

import 'package:flutter/material.dart';
import 'dart:math';

///Transiciones con efecto Fade (desvanecimiento)
Route createFadeRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    },
  );
}

///Transición con efecto Slide (desplazamiento horizontal)
Route createSlideRoute(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 500),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final begin = const Offset(1.0, 0.0); // From right
      final end = Offset.zero;
      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));
      final offsetAnimation = animation.drive(tween);
      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

/// Cubo transición
Route createCubeTransition(Widget page) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 600),
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = pi; // 180 grados
      const end = 0.0;

      final tween = Tween<double>(begin: begin, end: end)
          .chain(CurveTween(curve: Curves.easeInOut));

      return AnimatedBuilder(
        animation: animation,
        builder: (context, _) {
          final angle = tween.evaluate(animation);
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001) // perspectiva
              ..rotateY(angle),
            child: child,
          );
        },
      );
    },
  );
}
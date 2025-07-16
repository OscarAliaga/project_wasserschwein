import 'package:flutter/material.dart';
import 'background_container.dart';
import 'logo_header.dart';

class ILearnScaffold extends StatelessWidget {
  final Widget child;
  final bool showBackButton;
  final EdgeInsetsGeometry contentPadding;

  const ILearnScaffold({
    super.key,
    required this.child,
    this.showBackButton = true,
    this.contentPadding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor, // asegura coherencia con el tema
      body: BackgroundContainer(
        padding: contentPadding,
        child: ListView(
          children: [
            LogoHeader(enableBack: showBackButton),
            const SizedBox(height: 10),
            child,
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import 'background_container.dart';
import 'logo_header.dart';
import '../theme/role_theme.dart';

class RoleAwareScaffold extends StatelessWidget {
  final String title;
  final Widget child;
  final bool showBackButton;
  final EdgeInsetsGeometry contentPadding;

  const RoleAwareScaffold({
    super.key,
    required this.title,
    required this.child,
    this.showBackButton = false,
    this.contentPadding = const EdgeInsets.all(20),
  });

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;
    final userRole = user?.role;
    final roleTheme = user != null
    ? RoleThemes.forRole(context, user.userRole)
    : null;

    return Scaffold(
      // Si quieres usar el color de fondo dinámico según rol, puedes descomentar esto:
      // backgroundColor: roleTheme?.backgroundColor,
      body: BackgroundContainer(
        padding: contentPadding,
        child: ListView(
          children: [
            LogoHeader(enableBack: showBackButton),
            const SizedBox(height: 10),
            if (user != null) ...[
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: roleTheme?.textColor, // 👈 aplica el color del rol
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
            ],
            child,
          ],
        ),
      ),
    );
  }
}

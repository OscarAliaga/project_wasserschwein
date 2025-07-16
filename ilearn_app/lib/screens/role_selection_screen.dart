import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/users.dart';
import '../services/services.dart';
import '../screens/student_home.dart';
import '../screens/parent_home.dart';
import '../providers/theme_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/background_container.dart';
import '../gen_l10n/app_localizations.dart';

class RoleSelectionScreen extends StatefulWidget {
  final void Function(Locale) onLocaleChange;

  const RoleSelectionScreen({super.key, required this.onLocaleChange});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  final _nameController = TextEditingController();
  final _idController = TextEditingController();

  void _handleRoleSelection(BuildContext context, String role) async {
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.enterYourData),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.name),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _idController,
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.userId),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              final name = _nameController.text.trim();
              final id = _idController.text.trim();
              if (name.isEmpty || id.isEmpty) return;

              final user = User(userId: id, name: name, role: role);
              await UserService.saveUser(user);
              Provider.of<UserProvider>(context, listen: false).setUser(user);

              Navigator.pop(ctx);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => role == 'student'
                      ? const StudentHome()
                      : ParentHome(user: user),
                ),
              );
            },
            child: Text(AppLocalizations.of(context)!.continueText),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
  backgroundColor: Colors.transparent,
  elevation: 0,
  title: null, // Eliminar título centrado
  automaticallyImplyLeading: false,
  actions: [
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: Text(
          AppLocalizations.of(context)!.selectRole,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    ),
    PopupMenuButton<void>(
      icon: const Icon(Icons.settings),
      tooltip: 'Configuración',
      itemBuilder: (context) => <PopupMenuEntry<void>>[
        PopupMenuItem<void>(
          enabled: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.language,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      widget.onLocaleChange(const Locale('es'));
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.languageSpanish),
                  ),
                  TextButton(
                    onPressed: () {
                      widget.onLocaleChange(const Locale('en'));
                      Navigator.pop(context);
                    },
                    child: Text(AppLocalizations.of(context)!.languageEnglish),
                  ),
                ],
              ),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem<void>(
          enabled: false,
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, _) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    themeProvider.isDarkMode
                        ? AppLocalizations.of(context)!.nightMode
                        : AppLocalizations.of(context)!.dayMode,
                  ),
                  Switch(
                    value: themeProvider.isDarkMode,
                    onChanged: (value) {
                      themeProvider.toggleTheme(value);
                      Navigator.pop(context); // cerrar el menú
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ],
    ),
  ],
),
      body: BackgroundContainer(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + kToolbarHeight + 16,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: OrientationBuilder(
          builder: (context, orientation) {
            final isPortrait = orientation == Orientation.portrait;

      final buttons = Column(
  mainAxisSize: MainAxisSize.min,
  children: [
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/capi_gamer.png',
          width: 120,
          height: 120,
        ),
        const SizedBox(width: 16),
        Flexible(
          fit: FlexFit.loose,
          child: ElevatedButton(
            onPressed: () {
              _handleRoleSelection(context, 'student');
            },
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(AppLocalizations.of(context)!.student),
          ),
        ),
      ],
    ),
    const SizedBox(height: 20),
    Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/capi_super_hero.png',
          width: 120,
          height: 120,
        ),
        const SizedBox(width: 16),
        Flexible(
          fit: FlexFit.loose,
          child: ElevatedButton(
            onPressed: () {
              _handleRoleSelection(context, 'parent');
            },
            style: ElevatedButton.styleFrom(
              textStyle: const TextStyle(fontSize: 20),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: Text(AppLocalizations.of(context)!.parent),
          ),
        ),
      ],
    ),
  ],
);
      return isPortrait
    ? SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/logo-06.png',
              width: 300,
              height: 300,
            ),
            const SizedBox(height: 40),
            buttons,
          ],
        ),
      )
    : Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo-06.png',
            width: 300,
            height: 300,
          ),
          const SizedBox(width: 40),
          SizedBox(
            width: 400, // ✅ Fix aplicado aquí
            child: buttons,
          ),
        ],
      );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }
}

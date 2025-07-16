import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'providers/theme_provider.dart';
import 'providers/user_provider.dart';
import 'screens/role_selection_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import '../gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final themeProvider = ThemeProvider();
  await themeProvider.loadPreference();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => themeProvider),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const ILearnApp(),
    ),
  );
}

class ILearnApp extends StatefulWidget {
  const ILearnApp({super.key});

  @override
  State<ILearnApp> createState() => _ILearnAppState();
}

class _ILearnAppState extends State<ILearnApp> {
  Locale _selectedLocale = const Locale('es');

  void _changeLocale(Locale newLocale) {
    setState(() {
      _selectedLocale = newLocale;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'I-Learn',
      locale: _selectedLocale,
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: Provider.of<ThemeProvider>(context).lightTheme.copyWith(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      darkTheme: Provider.of<ThemeProvider>(context).darkTheme.copyWith(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: RoleSelectionScreen(
        onLocaleChange: _changeLocale,
      ),
    );
  }
}

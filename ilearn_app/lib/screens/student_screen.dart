import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../models/users.dart';
import '../providers/user_provider.dart';
import '../widgets/role_aware_scaffold.dart';
import 'package:flutter/services.dart' show rootBundle;
import '../gen_l10n/app_localizations.dart';

class StudentScreen extends StatefulWidget {
  final String curso;
  final String materia;

  const StudentScreen({
    super.key,
    required this.curso,
    required this.materia,
  });

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final TextEditingController _controller = TextEditingController();
  String _response = '';
  String _followup = '';
  String _tip = '';
  String? _imageUrl;
  bool _loading = false;
  bool _showIntroImage = true;
  bool _showExampleButtons = false;
  String _temaDetectado = '';
  List<String> _temas = [];
  int _currentBackendStage = 1;

  @override
  void initState() {
    super.initState();
    cargarTemasDesdeTxt();
    _currentBackendStage = 1;
  }

  Future<void> cargarTemasDesdeTxt() async {
    try {
      final contenido = await rootBundle.loadString('assets/curriculum/math_5_b.txt');
      final temas = contenido
          .split('\n')
          .map((linea) => linea.trim().toLowerCase())
          .where((linea) => linea.isNotEmpty)
          .toList();
      setState(() {
        _temas = temas;
      });
    } catch (e) {
      print('Error al cargar el archivo del curr\u00edculum: \$e');
      setState(() {
        _temas = [];
      });
    }
  }

  Future<void> sendQuestion(String question) async {
    if (question.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context)!.emptyQuestionWarning)),
      );
      return;
    }

    final userId = Provider.of<UserProvider>(context, listen: false).currentUser?.userId ?? 'default_user';

    setState(() {
      _loading = true;
      _response = '';
      _tip = '';
      _followup = '';
      _imageUrl = null;
      _showExampleButtons = false;
      _showIntroImage = false;
    });

    try {
      final uri = Uri.parse('http://10.0.2.2:8000/ask');
      final result = await http.post(
        uri,
        headers: {'Content-Type': 'application/json; charset=utf-8'},
        body: jsonEncode({
          'question': question,
          'user_id': userId,
          'stage': _currentBackendStage,
          'lang': Localizations.localeOf(context).languageCode,
        }),
      );

      if (result.statusCode == 200) {
        final data = jsonDecode(utf8.decode(result.bodyBytes));
        final respuestaTexto = data['answer']?.toString() ?? '';

        final receivedNextStage = data['next_stage'] as int? ?? 1;
        final showButtons = data['show_buttons'] == true;

        final detectado = _temas.firstWhere(
          (t) => respuestaTexto.toLowerCase().contains(t),
          orElse: () => '',
        );

        setState(() {
          _response = respuestaTexto;
          _followup = data['followup'] ?? '';
          _tip = data['tip'] ?? '';
          _imageUrl = data['image'];
          _loading = false;
          _showExampleButtons = showButtons;
          _temaDetectado = detectado;
          _currentBackendStage = receivedNextStage;
        });
      } else {
        setState(() {
          _response = '${AppLocalizations.of(context)!.serverError(result.statusCode)} ${AppLocalizations.of(context)!.emptyQuestionWarning}';
          _loading = false;
          _showIntroImage = false;
        });
      }
    } catch (e) {
      setState(() {
        _response = '${AppLocalizations.of(context)!.connectionError(e.toString())} Aseg\u00farate de que el servidor est\u00e9 funcionando.';
        _loading = false;
        _showIntroImage = false;
      });
    } finally {
      _controller.clear();
    }
  }

  String getLocalizedSubject(BuildContext context, String key) {
    final loc = AppLocalizations.of(context)!;
    switch (key) {
      case 'subjectMath':
        return loc.subjectMath;
      case 'subjectLanguage':
        return loc.subjectLanguage;
      case 'subjectHistory':
        return loc.subjectHistory;
      case 'subjectScience':
        return loc.subjectScience;
      default:
        return key;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text(AppLocalizations.of(context)!.userNotAvailable)),
      );
    }

    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final subjectLabel = getLocalizedSubject(context, widget.materia);

    return RoleAwareScaffold(
      title: AppLocalizations.of(context)!.studentScreenTitle,
      showBackButton: true,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 700),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                if (_showIntroImage)
                  Column(
                    children: [
                      Image.asset('assets/images/Capi-tortuga.png', width: 180, height: 180),
                      const SizedBox(height: 12),
                      Text(
                        AppLocalizations.of(context)!.introMessage(subjectLabel),
                        style: textTheme.titleMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                if (_loading)
                  const CircularProgressIndicator()
                else ...[
                  if (_response.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(left: 2, top: 6),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.cardColor,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: const Offset(2, 2),
                            ),
                          ],
                        ),
                        child: Text(_response, style: textTheme.bodyMedium),
                      ),
                    ),
                  if (_tip.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/capi_profesor.png', width: 180, height: 180),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(left: 4, top: 10),
                              decoration: BoxDecoration(
                                color: theme.cardColor,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 4,
                                    offset: const Offset(2, 2),
                                  ),
                                ],
                              ),
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                _tip,
                                style: textTheme.bodyMedium,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  if (_followup.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surfaceVariant,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          _followup,
                          style: textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  if (_showExampleButtons)
  Padding(
    padding: const EdgeInsets.only(top: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 130,
          child: ElevatedButton(
            onPressed: () => sendQuestion("sí"),
            child: Text(AppLocalizations.of(context)!.yes),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 130,
          child: ElevatedButton(
            onPressed: () {
              _controller.clear();
              setState(() {
                _showExampleButtons = false;
                _temaDetectado = '';
                _currentBackendStage = 1;
                _showIntroImage = true;
                _response = '';
                _tip = '';
                _imageUrl = null;
                _followup = '';
              });
            },
            child: Text(AppLocalizations.of(context)!.no),
          ),
        ),
      ],
    ),
  ),
                  if (_imageUrl != null && _imageUrl!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          _imageUrl!,
                          height: 220,
                          fit: BoxFit.contain,
                          errorBuilder: (context, error, stackTrace) =>
                              Text(AppLocalizations.of(context)!.imageLoadError),
                        ),
                      ),
                    ),
                ],
                const SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  textInputAction: TextInputAction.done,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.questionHint,
                    border: const OutlineInputBorder(),
                    filled: true,
                    fillColor: theme.colorScheme.surface.withOpacity(0.9),
                  ),
                  onSubmitted: (value) {
                    setState(() {
                      _currentBackendStage = 1;
                    });
                    sendQuestion(value);
                  },
                ),
                const SizedBox(height: 10),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: _loading
                        ? null
                        : () {
                            setState(() {
                              _currentBackendStage = 1;
                            });
                            sendQuestion(_controller.text);
                          },
                    icon: const Icon(Icons.send),
                    label: Text(AppLocalizations.of(context)!.send),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../widgets/role_aware_scaffold.dart';
import '../gen_l10n/app_localizations.dart';

class TipDetailScreen extends StatefulWidget {
  final String tipTitle;
  final String tipDescription;

  const TipDetailScreen({
    super.key,
    required this.tipTitle,
    required this.tipDescription,
  });

  @override
  State<TipDetailScreen> createState() => _TipDetailScreenState();
}

class _TipDetailScreenState extends State<TipDetailScreen>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    // Extrae la parte de la pregunta sugerida desde la descripción
    final split = widget.tipDescription.split('**Why');
    final suggestedQuestion = split.first.trim();
    final rationaleText = '**Why${split.length > 1 ? split[1] : ''}';

    return RoleAwareScaffold(
      title: widget.tipTitle,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Contenedor para la pregunta sugerida
            Container(
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: isDark ? Colors.teal[900] : Colors.teal[50],
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: isDark ? Colors.black45 : Colors.black12,
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: MarkdownBody(
                data: suggestedQuestion,
                styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                  p: const TextStyle(fontSize: 16, height: 1.6),
                  strong: const TextStyle(fontWeight: FontWeight.bold),
                  em: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ),

            // Contenedor para el texto explicativo (colapsable)
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: ConstrainedBox(
                constraints: _expanded
                    ? const BoxConstraints()
                    : const BoxConstraints(maxHeight: 280),
                child: ClipRect(
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isDark ? Colors.grey[900] : Colors.grey[50],
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color:
                              isDark ? Colors.black45 : Colors.black12,
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      physics: const ClampingScrollPhysics(),
                      child: MarkdownBody(
                        data: rationaleText,
                        styleSheet:
                            MarkdownStyleSheet.fromTheme(theme).copyWith(
                          p: const TextStyle(fontSize: 16, height: 1.6),
                          h2: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          strong: const TextStyle(fontWeight: FontWeight.bold),
                          em: const TextStyle(fontStyle: FontStyle.italic),
                          listBullet: const TextStyle(fontSize: 16),
                          blockquotePadding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          blockquoteDecoration: BoxDecoration(
                            color: isDark
                                ? Colors.teal[800]!.withOpacity(0.2)
                                : Colors.teal[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Botón "¿Aprender más?" o "Ver menos"
            Center(
              child: TextButton.icon(
                onPressed: () {
                  setState(() {
                    _expanded = !_expanded;
                  });
                },
                icon: Icon(
                  _expanded ? Icons.expand_less : Icons.expand_more,
                ),
                label: Text(
                  _expanded ? local.showLess : local.learnMore,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/ilearn_scaffold.dart';
import 'student_unit_detail_screen.dart';
import '../gen_l10n/app_localizations.dart';

class StudentProgressScreen extends StatefulWidget {
  final String studentId;
  final String studentName;

  const StudentProgressScreen({
    super.key,
    required this.studentId,
    required this.studentName,
  });

  @override
  State<StudentProgressScreen> createState() => _StudentProgressScreenState();
}

class _StudentProgressScreenState extends State<StudentProgressScreen> {
  bool isLoading = true;
  List<Map<String, dynamic>> progressList = [];

  @override
  void initState() {
    super.initState();
    loadProgress();
  }

  Future<void> loadProgress() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('progreso')
        .where('studentId', isEqualTo: widget.studentId)
        .get();

    final data = snapshot.docs.map((doc) => doc.data()).toList();

    setState(() {
      progressList = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final local = AppLocalizations.of(context)!;
    final localeCode = Localizations.localeOf(context).languageCode;

    print('🌍 Código de idioma: $localeCode');


    // Función robusta para obtener la unidad traducida
 String resolveUnidad(dynamic raw, String locale) {
  if (raw == null) return 'Unidad desconocida';

  try {
    if (raw is Map) {
      final casted = Map<String, dynamic>.from(raw);
      debugPrint('🌐 Claves en unidad: ${casted.keys}');

      // Buscar clave exacta primero
      if (casted[locale] is String) {
        return casted[locale];
      }

      // Intentar clave limpiando espacios
      final keyMatch = casted.keys.firstWhere(
        (k) => k.trim().toLowerCase() == locale.toLowerCase(),
        orElse: () => '',
      );
      if (keyMatch.isNotEmpty && casted[keyMatch] is String) {
        debugPrint('🌍 Acceso corregido con clave "$keyMatch"');
        return casted[keyMatch];
      }

      // Fallbacks
      if (casted['en'] is String) return casted['en'];
      if (casted['es'] is String) return casted['es'];
      return casted.values.first.toString();
    }

    if (raw is String) {
      debugPrint('🔤 raw es String: $raw');
      return raw;
    }
  } catch (e) {
    debugPrint('⚠️ Error resolviendo unidad: $e');
  }

  return 'Unidad desconocida';
}


    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return ILearnScaffold(
      showBackButton: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(local.learningProgressTitle, style: textTheme.titleMedium),
            const SizedBox(height: 6),
            Text(
              local.studentLabel(widget.studentId),
              style: textTheme.bodySmall,
            ),
            const SizedBox(height: 20),

            if (progressList.isEmpty)
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    local.noProgressYet,
                    style: textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withOpacity(0.6),
                    ),
                  ),
                ),
              )
            else
              ...progressList.map((item) {
                final unidad = resolveUnidad(item['unidad'], localeCode);
                final actualizado = item['actualizado'] ?? '';
                final porcentaje = int.tryParse(item['porcentaje'].toString()) ?? 0;

                final progressColor = porcentaje >= 85
                    ? Colors.green
                    : porcentaje >= 40
                        ? Colors.amber
                        : Colors.red;

                return Card(
                  color: theme.cardColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.school, color: theme.colorScheme.primary, size: 28),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                unidad,
                                style: textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '$porcentaje%',
                              style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        LinearProgressIndicator(
                          value: porcentaje / 100,
                          minHeight: 8,
                          backgroundColor: theme.colorScheme.surfaceContainerHighest,
                          valueColor: AlwaysStoppedAnimation<Color>(progressColor),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${local.updatedAt}: $actualizado',
                              style: textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurface.withOpacity(0.6),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => StudentUnitDetailScreen(
                                      unidad: unidad,
                                      porcentaje: porcentaje,
                                      actualizado: actualizado,
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(
                                foregroundColor: theme.colorScheme.primary,
                                textStyle: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                              child: Text(local.viewDetail),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),

            const SizedBox(height: 30),
            Center(
              child: Text(
                local.motivationalFooter,
                style: textTheme.bodyMedium?.copyWith(fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../widgets/role_aware_scaffold.dart';
import '../gen_l10n/app_localizations.dart';

class StudentUnitDetailScreen extends StatelessWidget {
  final dynamic unidad;
  final int porcentaje;
  final String actualizado;

  const StudentUnitDetailScreen({
    super.key,
    required this.unidad,
    required this.porcentaje,
    required this.actualizado,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).languageCode;
    final unidadText = unidad is Map
    ? (unidad[locale] ?? unidad['es'] ?? 'Unidad desconocida')
    : unidad.toString();

    final progressColor = porcentaje >= 85
        ? Colors.green
        : porcentaje >= 40
            ? Colors.amber
            : Colors.red;

    return RoleAwareScaffold(
      title: unidadText,
      showBackButton: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${local.updatedAt}: $actualizado',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 20),
            Text(
              local.progressReached,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: porcentaje / 100,
              minHeight: 10,
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
            const SizedBox(height: 8),
            Text(
              '$porcentaje%',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 40),
            const SizedBox(height: 40),
Text(
  local.unitRecommendationTitle, // Ej: "Recomendación para el Apoyo"
  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
),
const SizedBox(height: 12),
Container(
  width: double.infinity,
  padding: const EdgeInsets.all(16),
  decoration: BoxDecoration(
    color: theme.colorScheme.surface, // buen fondo en ambos temas
    borderRadius: BorderRadius.circular(12),
    border: Border.all(
      color: theme.colorScheme.primary.withOpacity(0.4), // más contraste
      width: 1.2,
    ),
    boxShadow: [
      BoxShadow(
        color: theme.shadowColor.withOpacity(0.05),
        blurRadius: 4,
        offset: const Offset(0, 2),
      ),
    ],
  ),
  child: Text(
    locale == 'es'
        ? '💡 Ayuda a tu hijo a entender los grandes números, la multiplicación y la división usando ejemplos de la vida diaria.\n\nPuedes practicar sumando o multiplicando los precios de productos en el supermercado, o dividiendo un paquete entre varios miembros de la familia. Refuerza la idea de que dividir no siempre da un número exacto, y eso está bien.\n\nAnímalos a estimar primero el resultado antes de resolverlo. ¡No hace falta saber todas las respuestas! Solo con acompañar, mostrar interés y preguntar “¿cómo lo harías tú?” ya estás apoyando mucho su aprendizaje.'
        : '💡 Support your child’s understanding of large numbers, multiplication, and division using real-life situations.\n\nTry adding or multiplying prices while shopping, or dividing a snack fairly among family members. Remind them it’s okay if division doesn’t come out exact.\n\nEncourage your child to estimate first before solving. You don’t need to know all the answers! Simply showing interest and asking “how would you solve it?” is already powerful support.',
    style: theme.textTheme.bodyMedium?.copyWith(
      color: theme.colorScheme.onSurface, // texto bien visible
    ),
  ),
),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../gen_l10n/app_localizations.dart';
import '../widgets/role_aware_scaffold.dart';
import 'tip_detail_screen.dart';

class SupportLearningTipsScreen extends StatelessWidget {
  const SupportLearningTipsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final tips = [
      local.tipRoutine,
      local.tipEncourage,
      local.tipAskQuestions,
      local.tipPraiseEffort,
      local.tipCreateSpace,
      local.tipUseResources,
      local.tipTalkAboutSchool,
      local.tipStayPositive,
    ];

    final descriptions = [
      local.tipGeneric_description,
      local.tipGeneric_description,
      local.tipAskQuestions_description,
      local.tipGeneric_description,
      local.tipGeneric_description,
      local.tipGeneric_description,
      local.tipGeneric_description,
      local.tipGeneric_description,
    ];

    final icons = [
      Icons.schedule,
      Icons.emoji_events,
      Icons.question_answer,
      Icons.thumb_up_alt,
      Icons.chair_alt,
      Icons.menu_book,
      Icons.school,
      Icons.sentiment_satisfied_alt,
    ];

    return RoleAwareScaffold(
      title: local.supportLearningTitle,
      showBackButton: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: List.generate(tips.length, (index) {
            return Container(
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: isDark ? Colors.teal[300] : Colors.teal,
                  child: Icon(icons[index], color: Colors.white),
                ),
                title: Text(
                  tips[index],
                  style: const TextStyle(fontSize: 16),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TipDetailScreen(
                        tipTitle: tips[index],
                        tipDescription: descriptions[index],
                      ),
                    ),
                  );
                },
              ),
            );
          }),
        ),
      ),
    );
  }
}

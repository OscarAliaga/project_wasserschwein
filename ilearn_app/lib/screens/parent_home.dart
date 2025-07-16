import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import '../models/users.dart';
import '../providers/user_provider.dart';
import 'link_student_screen.dart';
import 'linked_students_screen.dart';
import '../widgets/section_button.dart';
import '../widgets/role_aware_scaffold.dart';
import '../gen_l10n/app_localizations.dart';
import 'support_learning_tips_screen.dart';


class ParentHome extends StatefulWidget {
  final User user;

  const ParentHome({super.key, required this.user});

  @override
  State<ParentHome> createState() => _ParentHomeState();
}

class _ParentHomeState extends State<ParentHome> {
  List<Map<String, dynamic>> linkedStudents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLinkedStudents();
  }

  Future<void> _fetchLinkedStudents() async {
    final user = Provider.of<UserProvider>(context, listen: false).currentUser;
    if (user == null) return;

    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('vinculos')
          .where('parentId', isEqualTo: user.userId)
          .get();

      setState(() {
        linkedStudents = snapshot.docs
            .map((doc) => {
                  'id': doc['studentId'],
                  'name': doc['studentId'],
                })
            .toList();
        isLoading = false;
      });
    } catch (e) {
      debugPrint('Error al cargar estudiantes: $e');
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).currentUser;
    final local = AppLocalizations.of(context)!;

    if (user == null) {
      return Scaffold(
        body: Center(child: Text(local.userUnavailable)),
      );
    }

    return RoleAwareScaffold(
      title: local.homeParentTitle,
      showBackButton: true,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    local.welcome(user.name),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    '${local.yourId(user.userId)} | ${local.yourRole(user.role)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 20),

                  SectionButton(
                    title: local.supportLearningTitle,
                    subtitle: local.supportLearningSubtitle,
                    imagePath: 'assets/images/lightbulb.png',
                    onPressed: () {Navigator.push(
    context,
    MaterialPageRoute(builder: (_) => const SupportLearningTipsScreen()),
  );},
                  ),

                  SectionButton(
                    title: local.linkStudentTitle,
                    subtitle: local.linkStudentSubtitle,
                    imagePath: 'assets/images/vinculate.png',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LinkStudentScreen(parent: user),
                        ),
                      ).then((_) => _fetchLinkedStudents());
                    },
                  ),

                  if (linkedStudents.isNotEmpty)
                    SectionButton(
                      title: local.viewProgressTitle,
                      subtitle: local.viewProgressSubtitle,
                      imagePath: 'assets/images/progress.png',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LinkedStudentsScreen(parent: user),
                          ),
                        );
                      },
                    ),

                  const SizedBox(height: 30),
                  _buildMotivationalQuote(local),
                ],
              ),
            ),
    );
  }

  Widget _buildMotivationalQuote(AppLocalizations local) {
    final textColor = Theme.of(context).textTheme.bodyMedium?.color;

    return Column(
      children: [
        Text(
          local.motivationalQuote,
          style: TextStyle(
            fontStyle: FontStyle.italic,
            fontSize: 16,
            color: textColor,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Image.asset(
          'assets/images/capi_tender.png',
          height: 180,
        ),
      ],
    );
  }
}

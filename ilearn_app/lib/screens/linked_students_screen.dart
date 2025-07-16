import 'package:flutter/material.dart';
import '../models/users.dart';
import '../services/link_service.dart';
import '../widgets/role_aware_scaffold.dart';
import '../gen_l10n/app_localizations.dart';
import 'student_progress_screen.dart';

class LinkedStudentsScreen extends StatefulWidget {
  final User parent;

  const LinkedStudentsScreen({super.key, required this.parent});

  @override
  State<LinkedStudentsScreen> createState() => _LinkedStudentsScreenState();
}

class _LinkedStudentsScreenState extends State<LinkedStudentsScreen> {
  List<Map<String, String>> linkedStudents = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  Future<void> _loadStudents() async {
    try {
      final students = await LinkService.getLinkedStudents(widget.parent.userId);
      setState(() {
        linkedStudents = students;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  Future<void> _unlinkStudent(String studentId) async {
    final local = AppLocalizations.of(context)!;

    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(local.unlinkConfirmTitle),
        content: Text(local.unlinkConfirmBody(studentId)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(local.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(local.confirm),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    try {
      await LinkService.unlinkParentFromStudent(widget.parent.userId, studentId);
      setState(() {
        linkedStudents.removeWhere((s) => s['id'] == studentId);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(local.unlinkSuccess)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(local.unlinkError)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;

    return RoleAwareScaffold(
      title: local.linkedStudentsTitle,
      showBackButton: true,
      child: isLoading
          ? const Center(child: CircularProgressIndicator())
          : linkedStudents.isEmpty
              ? Center(child: Text(local.noLinkedStudents))
              : SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(20),
                    itemCount: linkedStudents.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final student = linkedStudents[index];
                      final id = student['id']!;
                      final name = student['name']!;
                      return ListTile(
                        leading: const Icon(Icons.person),
                        title: Text('$name ($id)'),
                        trailing: IconButton(
                          icon: const Icon(Icons.link_off),
                          onPressed: () => _unlinkStudent(id),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => StudentProgressScreen(
                                studentId: id,
                                studentName: name,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/users.dart';
import '../services/link_service.dart';
import '../widgets/role_aware_scaffold.dart';
import '../widgets/section_button.dart';
import '../gen_l10n/app_localizations.dart';

class LinkStudentScreen extends StatefulWidget {
  final User parent;

  const LinkStudentScreen({super.key, required this.parent});

  @override
  State<LinkStudentScreen> createState() => _LinkStudentScreenState();
}

class _LinkStudentScreenState extends State<LinkStudentScreen> {
  final _studentIdController = TextEditingController();
  String? _feedbackMessage;
  bool _linking = false;
  List<Map<String, dynamic>> linkedStudents = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchLinkedStudents();
  }

  Future<void> _fetchLinkedStudents() async {
    setState(() => isLoading = true);
    try {
      final ids = await LinkService.getLinkedStudentIds(widget.parent.userId);
      final students = <Map<String, dynamic>>[];

      for (final id in ids) {
        final doc = await FirebaseFirestore.instance
            .collection('Usuarios ILearn')
            .doc(id)
            .get();
        if (doc.exists) {
          students.add({
            'id': id,
            'name': doc['name'] ?? id,
            'role': doc['role'] ?? '',
          });
        }
      }

      setState(() {
        linkedStudents = students;
        isLoading = false;
      });
    } catch (e) {
      print("❌ Error al cargar estudiantes vinculados: $e");
      setState(() => isLoading = false);
    }
  }

  Future<bool> _studentExists(String studentId) async {
    final doc = await FirebaseFirestore.instance
        .collection('Usuarios ILearn')
        .doc(studentId)
        .get();
    return doc.exists;
  }

  void _linkStudent() async {
    final local = AppLocalizations.of(context)!;
    final studentId = _studentIdController.text.trim();

    if (studentId.isEmpty) {
      setState(() => _feedbackMessage = local.enterValidId);
      return;
    }

    final exists = await _studentExists(studentId);
    if (!exists) {
      setState(() => _feedbackMessage = local.studentNotFound);
      return;
    }

    setState(() {
      _linking = true;
      _feedbackMessage = null;
    });

    try {
      await LinkService.linkParentToStudent(widget.parent.userId, studentId);
      setState(() {
        _feedbackMessage = local.linkSuccess;
        _studentIdController.clear();
      });
      _fetchLinkedStudents();
    } catch (e) {
      setState(() => _feedbackMessage = local.linkError);
    } finally {
      setState(() => _linking = false);
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
      await LinkService.unlinkParentFromStudent(
          widget.parent.userId, studentId);

      setState(() {
        linkedStudents.removeWhere((student) => student['id'] == studentId);
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
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context)!;

    return RoleAwareScaffold(
      title: local.linkStudentTitle,
      showBackButton: true,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(local.enterStudentId, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 12),
            TextField(
              controller: _studentIdController,
              decoration: InputDecoration(
                labelText: local.studentIdLabel,
                hintText: local.studentIdHint,
                border: const OutlineInputBorder(),
                filled: true,
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _linkStudent(),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _linking ? null : _linkStudent,
                icon: const Icon(Icons.link),
                label: Text(local.linkButton),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            if (_feedbackMessage != null)
              Text(
                _feedbackMessage!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: _feedbackMessage == local.linkSuccess
                      ? Colors.green
                      : Colors.red,
                ),
              ),
            const SizedBox(height: 30),
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (linkedStudents.isEmpty)
              Text(local.noLinkedStudents)
            else
              Column(
                children: linkedStudents.map((student) {
                  return SectionButton(
                    title: student['name'],
                    subtitle: '${local.userIdLabel}: ${student['id']}',
                    imagePath: 'assets/images/capi_aventurero_2.png',
                    onPressed: () => _unlinkStudent(student['id']),
                  );
                }).toList(),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _studentIdController.dispose();
    super.dispose();
  }
}

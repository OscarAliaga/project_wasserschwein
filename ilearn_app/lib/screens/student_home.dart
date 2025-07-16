import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/user_provider.dart';
import '../widgets/role_aware_scaffold.dart';
import 'student_screen.dart';
import '../gen_l10n/app_localizations.dart';
import '../providers/screen_transitions.dart';

class StudentHome extends StatefulWidget {
  const StudentHome({super.key});

  @override
  State<StudentHome> createState() => _StudentHomeState();
}

class _StudentHomeState extends State<StudentHome> {
  late List<String> cursos;
  late List<String> materias;

  String? cursoSeleccionado;
  String? materiaSeleccionada;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final local = AppLocalizations.of(context)!;

    cursos = [
      local.course1,
      local.course2,
      local.course3,
      local.course4,
      local.course5,
      local.course6,
    ];

    materias = [
      local.subjectMath,
      local.subjectLanguage,
      local.subjectHistory,
      local.subjectScience,
    ];
  }

  void _validarYRedirigir(Function onValid) {
    if (cursoSeleccionado != null && materiaSeleccionada != null) {
      onValid();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context)!.selectCourseAndSubject),
          backgroundColor: Colors.redAccent,
        ),
      );
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
      title: local.homeStudentTitle,
      showBackButton: true,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  Image.asset('assets/images/capi_gamer.png', width: 150),
                  const SizedBox(height: 20),
                  Text(
                    local.welcome(user.name),
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    local.yourId(user.userId),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    local.yourRole(user.role),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              local.selectCourse,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: cursoSeleccionado,
              hint: Text(local.chooseCourseHint),
              isExpanded: true,
              items: cursos.map((String curso) {
                return DropdownMenuItem<String>(
                  value: curso,
                  child: Text(curso),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  cursoSeleccionado = newValue;
                });
              },
            ),
            const SizedBox(height: 20),
            Text(
              local.selectSubject,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            DropdownButton<String>(
              value: materiaSeleccionada,
              hint: Text(local.chooseSubjectHint),
              isExpanded: true,
              items: materias.map((String materia) {
                return DropdownMenuItem<String>(
                  value: materia,
                  child: Text(materia),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  materiaSeleccionada = newValue;
                });
              },
            ),
            const SizedBox(height: 30),

            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton.icon(
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    minimumSize: MaterialStateProperty.all(const Size.fromHeight(70)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () {
                    _validarYRedirigir(() {
                      Navigator.push(
                        context,
                        createCubeTransition(
                          StudentScreen(
                            curso: cursoSeleccionado!,
                            materia: materiaSeleccionada!,
                          ),
                        ),
                      );
                    });
                  },
                  icon: const Icon(Icons.chat_bubble_outline),
                  label: Text(local.chatWithCapybara),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Center(
              child: SizedBox(
                width: 300,
                child: ElevatedButton.icon(
                  style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                    minimumSize: MaterialStateProperty.all(const Size.fromHeight(70)),
                    textStyle: MaterialStateProperty.all(
                      const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  onPressed: () {
                    _validarYRedirigir(() {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(local.soonAvailable),
                        ),
                      );
                    });
                  },
                  icon: const Icon(Icons.extension),
                  label: Text(local.funExercises),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

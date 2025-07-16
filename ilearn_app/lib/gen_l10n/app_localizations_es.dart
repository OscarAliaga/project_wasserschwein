// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get student => 'Soy Estudiante';

  @override
  String get parent => 'Soy Apoderado';

  @override
  String welcome(Object name) {
    return '¡Bienvenido, $name!';
  }

  @override
  String yourId(Object userId) {
    return 'Tu ID: $userId';
  }

  @override
  String yourRole(Object role) {
    return 'Rol: $role';
  }

  @override
  String get selectCourse => 'Selecciona tu curso:';

  @override
  String get selectSubject => 'Selecciona la materia:';

  @override
  String get chooseCourseHint => 'Elige tu curso';

  @override
  String get chooseSubjectHint => 'Elige la materia';

  @override
  String get chatWithCapybara => 'Ir con el tutor Capibara';

  @override
  String get funExercises => 'Ejercicios entretenidos';

  @override
  String get selectCourseAndSubject =>
      'Por favor, selecciona el curso y la materia.';

  @override
  String get soonAvailable => 'Esta opción estará disponible muy pronto';

  @override
  String get enterYourData => 'Ingresa tus datos';

  @override
  String get name => 'Nombre';

  @override
  String get userId => 'ID de usuario';

  @override
  String get cancel => 'Cancelar';

  @override
  String get continueText => 'Continuar';

  @override
  String get selectRole => 'Configuración';

  @override
  String get dayMode => 'Modo Diurno 🌞';

  @override
  String get nightMode => 'Modo Nocturno 🌜';

  @override
  String get languageSpanish => 'Español';

  @override
  String get languageEnglish => 'Inglés';

  @override
  String get language => 'Idioma';

  @override
  String get homeStudentTitle => 'Inicio del estudiante';

  @override
  String get userUnavailable => 'Usuario no disponible';

  @override
  String get course1 => '1° Básico';

  @override
  String get course2 => '2° Básico';

  @override
  String get course3 => '3° Básico';

  @override
  String get course4 => '4° Básico';

  @override
  String get course5 => '5° Básico';

  @override
  String get course6 => '6° Básico';

  @override
  String get subjectMath => 'Matemáticas';

  @override
  String get subjectLanguage => 'Lenguaje';

  @override
  String get subjectHistory => 'Historia y Ciencias Sociales';

  @override
  String get subjectScience => 'Ciencias Naturales';

  @override
  String get screenTitle => 'Tu amigo que te ayuda a Aprender';

  @override
  String get homeParentTitle => 'Inicio Apoderado';

  @override
  String get supportLearningTitle => 'Apoya el Aprendizaje de tu Hijo';

  @override
  String get supportLearningSubtitle =>
      'Consejos prácticos para padres y tutores';

  @override
  String get linkStudentTitle => 'Vincular estudiante';

  @override
  String get linkStudentSubtitle => 'Agrega un nuevo estudiante a tu cuenta.';

  @override
  String get viewProgressTitle => 'Ver Progreso de Aprendizaje';

  @override
  String get viewProgressSubtitle => 'Revisa el avance de tus estudiantes.';

  @override
  String get motivationalQuote =>
      'Recuerda que la paciencia y el cariño son los ingredientes más importantes para apoyar el aprendizaje de tus hijos.';

  @override
  String learningIntro(Object subject, Object grade, Object subjectName) {
    return 'Hola 👋, hoy aprenderemos $subjectName';
  }

  @override
  String get yes => 'Sí';

  @override
  String get no => 'No';

  @override
  String get askHint => 'Haz una pregunta para comenzar a aprender';

  @override
  String get askButton => 'Consultar';

  @override
  String get imageError => 'No se pudo cargar la imagen';

  @override
  String get noAnswerAvailable => 'Respuesta no disponible';

  @override
  String get linkedStudentsTitle => 'Estudiantes Vinculados';

  @override
  String get noLinkedStudents => 'Aún no hay estudiantes vinculados.';

  @override
  String get unlinkConfirmTitle => 'Desvincular Estudiante';

  @override
  String unlinkConfirmBody(Object studentId) {
    return '¿Estás seguro que deseas desvincular a $studentId?';
  }

  @override
  String get unlinkSuccess => 'Estudiante desvinculado correctamente.';

  @override
  String get unlinkError => 'Error al desvincular estudiante.';

  @override
  String get confirm => 'Confirmar';

  @override
  String get enterStudentId => 'Ingresa el ID del estudiante para vincularlo:';

  @override
  String get studentIdLabel => 'ID del estudiante';

  @override
  String get studentIdHint => 'Ej: oscar123';

  @override
  String get linkButton => 'Vincular';

  @override
  String get enterValidId => 'Por favor ingresa un ID válido';

  @override
  String get linkSuccess => '✅ Estudiante vinculado correctamente';

  @override
  String get linkError => '❌ Error al vincular estudiante';

  @override
  String get studentNotFound => 'ID de estudiante no encontrado en el sistema.';

  @override
  String get userIdLabel => 'ID de usuario';

  @override
  String get learningProgressTitle => 'Progreso de aprendizaje';

  @override
  String studentLabel(Object studentId) {
    return 'Estudiante: $studentId';
  }

  @override
  String get noProgressYet => 'Aún no hay registros de progreso.';

  @override
  String get motivationalFooter =>
      'Cada paso cuenta. ¡Sigue apoyando el aprendizaje!';

  @override
  String get viewDetail => 'Ver detalle';

  @override
  String get updatedAt => 'Actualizado';

  @override
  String get progressReached => 'Progreso alcanzado:';

  @override
  String get detailIntro => 'Aquí podrás agregar más detalles, como:';

  @override
  String get detailGoals => 'Objetivos cubiertos';

  @override
  String get detailFeedback => 'Retroalimentación del profesor';

  @override
  String get detailActivities => 'Actividades sugeridas';

  @override
  String get detailRecommendations => 'Recomendaciones personalizadas';

  @override
  String get tipRoutine =>
      'Establece una rutina constante para tareas y estudio.';

  @override
  String get tipEncourage => 'Valora el esfuerzo más que la perfección.';

  @override
  String get tipAskQuestions => 'Pregúntale a tu hijo qué aprendió hoy';

  @override
  String get tipPraiseEffort => 'Elogia la perseverancia y el trabajo duro.';

  @override
  String get tipCreateSpace =>
      'Crea un espacio tranquilo y ordenado para estudiar.';

  @override
  String get tipUseResources =>
      'Usa libros, apps o videos para reforzar el aprendizaje.';

  @override
  String get tipTalkAboutSchool => 'Habla positivamente sobre la escuela.';

  @override
  String get tipStayPositive => 'Mantén la calma y paciencia ante desafíos.';

  @override
  String get userNotAvailable => 'Usuario no disponible';

  @override
  String get studentScreenTitle => 'Tu Amigo que te ayuda a aprender';

  @override
  String introMessage(Object subjectName) {
    return 'Hola 👋, hoy aprenderemos $subjectName';
  }

  @override
  String get emptyQuestionWarning => 'Por favor, escribe una pregunta.';

  @override
  String serverError(Object code) {
    return 'Error del servidor: $code. Por favor, inténtalo de nuevo.';
  }

  @override
  String connectionError(Object error) {
    return 'Error de conexión: $error. Asegúrate de que el servidor esté funcionando.';
  }

  @override
  String get imageLoadError =>
      'No se pudo cargar la imagen. URL incorrecta o problema de red.';

  @override
  String get questionHint => 'Haz una pregunta para comenzar a aprender';

  @override
  String get send => 'Consultar';

  @override
  String get tipRoutineDetail =>
      'Establecer una rutina constante ayuda a los niños a sentirse seguros y a entender qué esperar cada día.';

  @override
  String get tipEncourageDetail =>
      'Anima el esfuerzo y la perseverancia de tu hijo, más allá de los resultados.';

  @override
  String get tipAskQuestionsDetail =>
      'Haz preguntas abiertas para estimular el pensamiento y la conversación.';

  @override
  String get tipPraiseEffortDetail =>
      'Elogia el proceso (estrategia, esfuerzo), no solo la inteligencia o los resultados.';

  @override
  String get tipCreateSpaceDetail =>
      'Ofrece un espacio tranquilo y ordenado donde tu hijo pueda concentrarse sin distracciones.';

  @override
  String get tipUseResourcesDetail =>
      'Aprovecha los recursos disponibles como libros, videos o apps educativas.';

  @override
  String get tipTalkAboutSchoolDetail =>
      'Habla regularmente sobre la escuela para mantenerte involucrado y mostrar apoyo.';

  @override
  String get tipStayPositiveDetail =>
      'Mantén una actitud positiva hacia el aprendizaje; tu enfoque influye en la motivación de tu hijo.';

  @override
  String get tipAskQuestions_description =>
      '❓ **Pregunta sugerida**\n\n🗣️ *Si tuvieras que enseñarme una cosa que aprendiste hoy, ¿qué sería?*\n\n🧠 **Por qué esta pregunta funciona**\n\nEsta pregunta se basa en el concepto de **práctica de recuperación**, una estrategia de aprendizaje respaldada por evidencia sólida (Karpicke & Roediger, 2008). La práctica de recuperación implica recordar activamente información desde la memoria, lo cual:\n\n- Fortalece las huellas de memoria\n- Mejora la retención a largo plazo\n- Aumenta la comprensión y la transferencia del conocimiento\n\nCuando se le pide a un niño que enseñe o explique algo que aprendió:\n\n- Reconstruye el conocimiento con sus propias palabras\n- Se involucra en un repaso elaborativo, más efectivo que una revisión pasiva\n- Aumenta su conciencia metacognitiva (es decir, lo que sabe sobre lo que sabe)\n\n👉 *Enseñar a otros — incluso de forma ficticia — ha demostrado ser particularmente poderoso porque obliga a los estudiantes a organizar y clarificar su comprensión* (Fiorella & Mayer, 2013).';

  @override
  String get tipGeneric_description =>
      'Este consejo está diseñado para ayudarte a apoyar el aprendizaje de tu hijo de forma cercana, efectiva y positiva. Aquí pronto encontrarás sugerencias prácticas, fundamentos pedagógicos y ejemplos fáciles de aplicar en casa. ¡Estamos preparando algo especial para ti! 💡';

  @override
  String get learnMore => 'Aprender más';

  @override
  String get showLess => 'Mostrar menos';

  @override
  String get introMessageTooltip => 'Intro message with subject name';

  @override
  String get unitRecommendationTitle => 'Recomendación para el Apoyo';
}

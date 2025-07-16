// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get student => 'I\'m a Student';

  @override
  String get parent => 'I\'m a Parent';

  @override
  String welcome(Object name) {
    return 'Welcome, $name!';
  }

  @override
  String yourId(Object userId) {
    return 'Your ID: $userId';
  }

  @override
  String yourRole(Object role) {
    return 'Role: $role';
  }

  @override
  String get selectCourse => 'Select your grade:';

  @override
  String get selectSubject => 'Select your subject:';

  @override
  String get chooseCourseHint => 'Choose your grade';

  @override
  String get chooseSubjectHint => 'Choose your subject';

  @override
  String get chatWithCapybara => 'Learn with Capybara';

  @override
  String get funExercises => 'Fun Exercises';

  @override
  String get selectCourseAndSubject => 'Please select grade and subject.';

  @override
  String get soonAvailable => 'This option will be available soon';

  @override
  String get enterYourData => 'Enter your information';

  @override
  String get name => 'Name';

  @override
  String get userId => 'User ID';

  @override
  String get cancel => 'Cancel';

  @override
  String get continueText => 'Continue';

  @override
  String get selectRole => 'Configuration';

  @override
  String get dayMode => 'Daytime Mode 🌞';

  @override
  String get nightMode => 'Nigh-time Mode 🌜';

  @override
  String get languageSpanish => 'Spanish';

  @override
  String get languageEnglish => 'English';

  @override
  String get language => 'Language';

  @override
  String get homeStudentTitle => 'Student Home';

  @override
  String get userUnavailable => 'User not available';

  @override
  String get course1 => '1st Grade';

  @override
  String get course2 => '2nd Grade';

  @override
  String get course3 => '3rd Grade';

  @override
  String get course4 => '4th Grade';

  @override
  String get course5 => '5th Grade';

  @override
  String get course6 => '6th Grade';

  @override
  String get subjectMath => 'Mathematics';

  @override
  String get subjectLanguage => 'Language';

  @override
  String get subjectHistory => 'History and Social Sciences';

  @override
  String get subjectScience => 'Natural Sciences';

  @override
  String get screenTitle => 'Your learning companion';

  @override
  String get homeParentTitle => 'Parent Home';

  @override
  String get supportLearningTitle => 'Support Your Child\'s Learning';

  @override
  String get supportLearningSubtitle =>
      'Practical tips for parents and guardians';

  @override
  String get linkStudentTitle => 'Link student';

  @override
  String get linkStudentSubtitle => 'Add a new student to your account.';

  @override
  String get viewProgressTitle => 'View Learning Progress';

  @override
  String get viewProgressSubtitle => 'Review your students\' progress.';

  @override
  String get motivationalQuote =>
      'Remember that patience and love are the most important ingredients to support your children\'s learning.';

  @override
  String learningIntro(Object subject, Object grade, Object subjectName) {
    return 'Hello 👋, today we will learn $subjectName';
  }

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get askHint => 'Ask a question to start learning';

  @override
  String get askButton => 'Ask';

  @override
  String get imageError => 'Could not load image';

  @override
  String get noAnswerAvailable => 'Answer not available';

  @override
  String get linkedStudentsTitle => 'Linked Students';

  @override
  String get noLinkedStudents => 'No students linked yet.';

  @override
  String get unlinkConfirmTitle => 'Unlink Student';

  @override
  String unlinkConfirmBody(Object studentId) {
    return 'Are you sure you want to unlink $studentId?';
  }

  @override
  String get unlinkSuccess => 'Student successfully unlinked.';

  @override
  String get unlinkError => 'Error unlinking student.';

  @override
  String get confirm => 'Confirm';

  @override
  String get enterStudentId => 'Enter the student\'s ID to link:';

  @override
  String get studentIdLabel => 'Student ID';

  @override
  String get studentIdHint => 'e.g., oscar123';

  @override
  String get linkButton => 'Link';

  @override
  String get enterValidId => 'Please enter a valid ID';

  @override
  String get linkSuccess => '✅ Student linked successfully';

  @override
  String get linkError => '❌ Error linking student';

  @override
  String get studentNotFound => 'Student ID not found in the system.';

  @override
  String get userIdLabel => 'User ID';

  @override
  String get learningProgressTitle => 'Learning Progress';

  @override
  String studentLabel(Object studentId) {
    return 'Student ID: $studentId';
  }

  @override
  String get noProgressYet => 'No progress records yet.';

  @override
  String get motivationalFooter =>
      'Every step counts. Keep supporting learning!';

  @override
  String get viewDetail => 'View details';

  @override
  String get updatedAt => 'Updated';

  @override
  String get progressReached => 'Progress reached:';

  @override
  String get detailIntro => 'Here you could add more details, such as:';

  @override
  String get detailGoals => 'Covered objectives';

  @override
  String get detailFeedback => 'Teacher\'s feedback';

  @override
  String get detailActivities => 'Suggested activities';

  @override
  String get detailRecommendations => 'Personalized recommendations';

  @override
  String get tipRoutine => 'Establish a consistent homework and study routine.';

  @override
  String get tipEncourage => 'Encourage effort over perfection.';

  @override
  String get tipAskQuestions => 'Ask your child what they learned today?';

  @override
  String get tipPraiseEffort => 'Praise persistence and hard work.';

  @override
  String get tipCreateSpace => 'Create a quiet and organized study space.';

  @override
  String get tipUseResources =>
      'Use books, apps, or videos to reinforce learning.';

  @override
  String get tipTalkAboutSchool => 'Talk about school in a positive way.';

  @override
  String get tipStayPositive =>
      'Stay calm and patient during learning challenges.';

  @override
  String get userNotAvailable => 'User not available';

  @override
  String get studentScreenTitle => 'Your Friend Who Helps You Learn';

  @override
  String introMessage(Object subjectName) {
    return 'Hello 👋, today we\'ll learn $subjectName';
  }

  @override
  String get emptyQuestionWarning => 'Please write a question.';

  @override
  String serverError(Object code) {
    return 'Server error: $code. Please try again.';
  }

  @override
  String connectionError(Object error) {
    return 'Connection error: $error. Make sure the server is running.';
  }

  @override
  String get imageLoadError =>
      'Could not load the image. Incorrect URL or network issue.';

  @override
  String get questionHint => 'Ask a question to start learning';

  @override
  String get send => 'Send';

  @override
  String get tipRoutineDetail =>
      'Establishing a consistent routine helps children feel secure and understand what to expect each day.';

  @override
  String get tipEncourageDetail =>
      'Encourage your child’s effort and persistence, rather than focusing only on results.';

  @override
  String get tipAskQuestionsDetail =>
      'Ask open-ended questions to stimulate thinking and learning conversations.';

  @override
  String get tipPraiseEffortDetail =>
      'Praise the process—such as strategy and effort—not just intelligence or outcomes.';

  @override
  String get tipCreateSpaceDetail =>
      'Provide a quiet, organized space where your child can focus on learning without distractions.';

  @override
  String get tipUseResourcesDetail =>
      'Make use of available learning resources like books, videos, or learning apps.';

  @override
  String get tipTalkAboutSchoolDetail =>
      'Have regular conversations about school to stay involved and show support.';

  @override
  String get tipStayPositiveDetail =>
      'Maintain a positive attitude toward learning; your mindset can influence your child’s motivation.';

  @override
  String get tipAskQuestions_description =>
      '❓ **Suggested question**\n\n🗣️ *If you had to teach me one thing you learned today, what would it be?*\n\n🧠 **Why this question works**\n\nThis question is grounded in the concept of **retrieval practice**, a learning strategy supported by robust evidence (Karpicke & Roediger, 2008). Retrieval practice involves actively recalling information from memory, which:\n\n- Strengthens memory traces\n- Improves long-term retention\n- Enhances understanding and transfer of knowledge\n\nWhen a child is asked to teach or explain something they learned:\n\n- They reconstruct the knowledge in their own words\n- They engage in elaborative rehearsal, which is more effective than passive review\n- They boost metacognitive awareness (awareness of what they know)\n\n👉 *Teaching others—even pretend teaching—has been shown to be particularly powerful because it forces learners to organize and clarify their understanding* (Fiorella & Mayer, 2013).';

  @override
  String get tipGeneric_description =>
      'This tip is designed to help you support your child’s learning in a caring, effective, and positive way. Soon, you’ll find practical suggestions, educational insights, and easy-to-apply examples right here. Something great is on the way! 💡';

  @override
  String get learnMore => 'Learn more';

  @override
  String get showLess => 'Show less';

  @override
  String get introMessageTooltip => 'Intro message with subject name';

  @override
  String get unitRecommendationTitle => 'Parent Tip';
}

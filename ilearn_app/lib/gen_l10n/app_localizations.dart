import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @student.
  ///
  /// In en, this message translates to:
  /// **'I\'m a Student'**
  String get student;

  /// No description provided for @parent.
  ///
  /// In en, this message translates to:
  /// **'I\'m a Parent'**
  String get parent;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcome(Object name);

  /// No description provided for @yourId.
  ///
  /// In en, this message translates to:
  /// **'Your ID: {userId}'**
  String yourId(Object userId);

  /// No description provided for @yourRole.
  ///
  /// In en, this message translates to:
  /// **'Role: {role}'**
  String yourRole(Object role);

  /// No description provided for @selectCourse.
  ///
  /// In en, this message translates to:
  /// **'Select your grade:'**
  String get selectCourse;

  /// No description provided for @selectSubject.
  ///
  /// In en, this message translates to:
  /// **'Select your subject:'**
  String get selectSubject;

  /// No description provided for @chooseCourseHint.
  ///
  /// In en, this message translates to:
  /// **'Choose your grade'**
  String get chooseCourseHint;

  /// No description provided for @chooseSubjectHint.
  ///
  /// In en, this message translates to:
  /// **'Choose your subject'**
  String get chooseSubjectHint;

  /// No description provided for @chatWithCapybara.
  ///
  /// In en, this message translates to:
  /// **'Learn with Capybara'**
  String get chatWithCapybara;

  /// No description provided for @funExercises.
  ///
  /// In en, this message translates to:
  /// **'Fun Exercises'**
  String get funExercises;

  /// No description provided for @selectCourseAndSubject.
  ///
  /// In en, this message translates to:
  /// **'Please select grade and subject.'**
  String get selectCourseAndSubject;

  /// No description provided for @soonAvailable.
  ///
  /// In en, this message translates to:
  /// **'This option will be available soon'**
  String get soonAvailable;

  /// No description provided for @enterYourData.
  ///
  /// In en, this message translates to:
  /// **'Enter your information'**
  String get enterYourData;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @userId.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userId;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @selectRole.
  ///
  /// In en, this message translates to:
  /// **'Configuration'**
  String get selectRole;

  /// No description provided for @dayMode.
  ///
  /// In en, this message translates to:
  /// **'Daytime Mode 🌞'**
  String get dayMode;

  /// No description provided for @nightMode.
  ///
  /// In en, this message translates to:
  /// **'Nigh-time Mode 🌜'**
  String get nightMode;

  /// No description provided for @languageSpanish.
  ///
  /// In en, this message translates to:
  /// **'Spanish'**
  String get languageSpanish;

  /// No description provided for @languageEnglish.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @homeStudentTitle.
  ///
  /// In en, this message translates to:
  /// **'Student Home'**
  String get homeStudentTitle;

  /// No description provided for @userUnavailable.
  ///
  /// In en, this message translates to:
  /// **'User not available'**
  String get userUnavailable;

  /// No description provided for @course1.
  ///
  /// In en, this message translates to:
  /// **'1st Grade'**
  String get course1;

  /// No description provided for @course2.
  ///
  /// In en, this message translates to:
  /// **'2nd Grade'**
  String get course2;

  /// No description provided for @course3.
  ///
  /// In en, this message translates to:
  /// **'3rd Grade'**
  String get course3;

  /// No description provided for @course4.
  ///
  /// In en, this message translates to:
  /// **'4th Grade'**
  String get course4;

  /// No description provided for @course5.
  ///
  /// In en, this message translates to:
  /// **'5th Grade'**
  String get course5;

  /// No description provided for @course6.
  ///
  /// In en, this message translates to:
  /// **'6th Grade'**
  String get course6;

  /// No description provided for @subjectMath.
  ///
  /// In en, this message translates to:
  /// **'Mathematics'**
  String get subjectMath;

  /// No description provided for @subjectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get subjectLanguage;

  /// No description provided for @subjectHistory.
  ///
  /// In en, this message translates to:
  /// **'History and Social Sciences'**
  String get subjectHistory;

  /// No description provided for @subjectScience.
  ///
  /// In en, this message translates to:
  /// **'Natural Sciences'**
  String get subjectScience;

  /// No description provided for @screenTitle.
  ///
  /// In en, this message translates to:
  /// **'Your learning companion'**
  String get screenTitle;

  /// No description provided for @homeParentTitle.
  ///
  /// In en, this message translates to:
  /// **'Parent Home'**
  String get homeParentTitle;

  /// No description provided for @supportLearningTitle.
  ///
  /// In en, this message translates to:
  /// **'Support Your Child\'s Learning'**
  String get supportLearningTitle;

  /// No description provided for @supportLearningSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Practical tips for parents and guardians'**
  String get supportLearningSubtitle;

  /// No description provided for @linkStudentTitle.
  ///
  /// In en, this message translates to:
  /// **'Link student'**
  String get linkStudentTitle;

  /// No description provided for @linkStudentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Add a new student to your account.'**
  String get linkStudentSubtitle;

  /// No description provided for @viewProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'View Learning Progress'**
  String get viewProgressTitle;

  /// No description provided for @viewProgressSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review your students\' progress.'**
  String get viewProgressSubtitle;

  /// No description provided for @motivationalQuote.
  ///
  /// In en, this message translates to:
  /// **'Remember that patience and love are the most important ingredients to support your children\'s learning.'**
  String get motivationalQuote;

  /// Intro message for the user indicating subject and grade
  ///
  /// In en, this message translates to:
  /// **'Hello 👋, today we will learn {subjectName}'**
  String learningIntro(Object subject, Object grade, Object subjectName);

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @askHint.
  ///
  /// In en, this message translates to:
  /// **'Ask a question to start learning'**
  String get askHint;

  /// No description provided for @askButton.
  ///
  /// In en, this message translates to:
  /// **'Ask'**
  String get askButton;

  /// No description provided for @imageError.
  ///
  /// In en, this message translates to:
  /// **'Could not load image'**
  String get imageError;

  /// No description provided for @noAnswerAvailable.
  ///
  /// In en, this message translates to:
  /// **'Answer not available'**
  String get noAnswerAvailable;

  /// No description provided for @linkedStudentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Linked Students'**
  String get linkedStudentsTitle;

  /// No description provided for @noLinkedStudents.
  ///
  /// In en, this message translates to:
  /// **'No students linked yet.'**
  String get noLinkedStudents;

  /// No description provided for @unlinkConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Unlink Student'**
  String get unlinkConfirmTitle;

  /// No description provided for @unlinkConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to unlink {studentId}?'**
  String unlinkConfirmBody(Object studentId);

  /// No description provided for @unlinkSuccess.
  ///
  /// In en, this message translates to:
  /// **'Student successfully unlinked.'**
  String get unlinkSuccess;

  /// No description provided for @unlinkError.
  ///
  /// In en, this message translates to:
  /// **'Error unlinking student.'**
  String get unlinkError;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @enterStudentId.
  ///
  /// In en, this message translates to:
  /// **'Enter the student\'s ID to link:'**
  String get enterStudentId;

  /// No description provided for @studentIdLabel.
  ///
  /// In en, this message translates to:
  /// **'Student ID'**
  String get studentIdLabel;

  /// No description provided for @studentIdHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., oscar123'**
  String get studentIdHint;

  /// No description provided for @linkButton.
  ///
  /// In en, this message translates to:
  /// **'Link'**
  String get linkButton;

  /// No description provided for @enterValidId.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid ID'**
  String get enterValidId;

  /// No description provided for @linkSuccess.
  ///
  /// In en, this message translates to:
  /// **'✅ Student linked successfully'**
  String get linkSuccess;

  /// No description provided for @linkError.
  ///
  /// In en, this message translates to:
  /// **'❌ Error linking student'**
  String get linkError;

  /// No description provided for @studentNotFound.
  ///
  /// In en, this message translates to:
  /// **'Student ID not found in the system.'**
  String get studentNotFound;

  /// No description provided for @userIdLabel.
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get userIdLabel;

  /// No description provided for @learningProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Learning Progress'**
  String get learningProgressTitle;

  /// No description provided for @studentLabel.
  ///
  /// In en, this message translates to:
  /// **'Student ID: {studentId}'**
  String studentLabel(Object studentId);

  /// No description provided for @noProgressYet.
  ///
  /// In en, this message translates to:
  /// **'No progress records yet.'**
  String get noProgressYet;

  /// No description provided for @motivationalFooter.
  ///
  /// In en, this message translates to:
  /// **'Every step counts. Keep supporting learning!'**
  String get motivationalFooter;

  /// No description provided for @viewDetail.
  ///
  /// In en, this message translates to:
  /// **'View details'**
  String get viewDetail;

  /// No description provided for @updatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get updatedAt;

  /// No description provided for @progressReached.
  ///
  /// In en, this message translates to:
  /// **'Progress reached:'**
  String get progressReached;

  /// No description provided for @detailIntro.
  ///
  /// In en, this message translates to:
  /// **'Here you could add more details, such as:'**
  String get detailIntro;

  /// No description provided for @detailGoals.
  ///
  /// In en, this message translates to:
  /// **'Covered objectives'**
  String get detailGoals;

  /// No description provided for @detailFeedback.
  ///
  /// In en, this message translates to:
  /// **'Teacher\'s feedback'**
  String get detailFeedback;

  /// No description provided for @detailActivities.
  ///
  /// In en, this message translates to:
  /// **'Suggested activities'**
  String get detailActivities;

  /// No description provided for @detailRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Personalized recommendations'**
  String get detailRecommendations;

  /// No description provided for @tipRoutine.
  ///
  /// In en, this message translates to:
  /// **'Establish a consistent homework and study routine.'**
  String get tipRoutine;

  /// No description provided for @tipEncourage.
  ///
  /// In en, this message translates to:
  /// **'Encourage effort over perfection.'**
  String get tipEncourage;

  /// No description provided for @tipAskQuestions.
  ///
  /// In en, this message translates to:
  /// **'Ask your child what they learned today?'**
  String get tipAskQuestions;

  /// No description provided for @tipPraiseEffort.
  ///
  /// In en, this message translates to:
  /// **'Praise persistence and hard work.'**
  String get tipPraiseEffort;

  /// No description provided for @tipCreateSpace.
  ///
  /// In en, this message translates to:
  /// **'Create a quiet and organized study space.'**
  String get tipCreateSpace;

  /// No description provided for @tipUseResources.
  ///
  /// In en, this message translates to:
  /// **'Use books, apps, or videos to reinforce learning.'**
  String get tipUseResources;

  /// No description provided for @tipTalkAboutSchool.
  ///
  /// In en, this message translates to:
  /// **'Talk about school in a positive way.'**
  String get tipTalkAboutSchool;

  /// No description provided for @tipStayPositive.
  ///
  /// In en, this message translates to:
  /// **'Stay calm and patient during learning challenges.'**
  String get tipStayPositive;

  /// No description provided for @userNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'User not available'**
  String get userNotAvailable;

  /// No description provided for @studentScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Friend Who Helps You Learn'**
  String get studentScreenTitle;

  /// No description provided for @introMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello 👋, today we\'ll learn {subjectName}'**
  String introMessage(Object subjectName);

  /// No description provided for @emptyQuestionWarning.
  ///
  /// In en, this message translates to:
  /// **'Please write a question.'**
  String get emptyQuestionWarning;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error: {code}. Please try again.'**
  String serverError(Object code);

  /// No description provided for @connectionError.
  ///
  /// In en, this message translates to:
  /// **'Connection error: {error}. Make sure the server is running.'**
  String connectionError(Object error);

  /// No description provided for @imageLoadError.
  ///
  /// In en, this message translates to:
  /// **'Could not load the image. Incorrect URL or network issue.'**
  String get imageLoadError;

  /// No description provided for @questionHint.
  ///
  /// In en, this message translates to:
  /// **'Ask a question to start learning'**
  String get questionHint;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @tipRoutineDetail.
  ///
  /// In en, this message translates to:
  /// **'Establishing a consistent routine helps children feel secure and understand what to expect each day.'**
  String get tipRoutineDetail;

  /// No description provided for @tipEncourageDetail.
  ///
  /// In en, this message translates to:
  /// **'Encourage your child’s effort and persistence, rather than focusing only on results.'**
  String get tipEncourageDetail;

  /// No description provided for @tipAskQuestionsDetail.
  ///
  /// In en, this message translates to:
  /// **'Ask open-ended questions to stimulate thinking and learning conversations.'**
  String get tipAskQuestionsDetail;

  /// No description provided for @tipPraiseEffortDetail.
  ///
  /// In en, this message translates to:
  /// **'Praise the process—such as strategy and effort—not just intelligence or outcomes.'**
  String get tipPraiseEffortDetail;

  /// No description provided for @tipCreateSpaceDetail.
  ///
  /// In en, this message translates to:
  /// **'Provide a quiet, organized space where your child can focus on learning without distractions.'**
  String get tipCreateSpaceDetail;

  /// No description provided for @tipUseResourcesDetail.
  ///
  /// In en, this message translates to:
  /// **'Make use of available learning resources like books, videos, or learning apps.'**
  String get tipUseResourcesDetail;

  /// No description provided for @tipTalkAboutSchoolDetail.
  ///
  /// In en, this message translates to:
  /// **'Have regular conversations about school to stay involved and show support.'**
  String get tipTalkAboutSchoolDetail;

  /// No description provided for @tipStayPositiveDetail.
  ///
  /// In en, this message translates to:
  /// **'Maintain a positive attitude toward learning; your mindset can influence your child’s motivation.'**
  String get tipStayPositiveDetail;

  /// No description provided for @tipAskQuestions_description.
  ///
  /// In en, this message translates to:
  /// **'❓ **Suggested question**\n\n🗣️ *If you had to teach me one thing you learned today, what would it be?*\n\n🧠 **Why this question works**\n\nThis question is grounded in the concept of **retrieval practice**, a learning strategy supported by robust evidence (Karpicke & Roediger, 2008). Retrieval practice involves actively recalling information from memory, which:\n\n- Strengthens memory traces\n- Improves long-term retention\n- Enhances understanding and transfer of knowledge\n\nWhen a child is asked to teach or explain something they learned:\n\n- They reconstruct the knowledge in their own words\n- They engage in elaborative rehearsal, which is more effective than passive review\n- They boost metacognitive awareness (awareness of what they know)\n\n👉 *Teaching others—even pretend teaching—has been shown to be particularly powerful because it forces learners to organize and clarify their understanding* (Fiorella & Mayer, 2013).'**
  String get tipAskQuestions_description;

  /// No description provided for @tipGeneric_description.
  ///
  /// In en, this message translates to:
  /// **'This tip is designed to help you support your child’s learning in a caring, effective, and positive way. Soon, you’ll find practical suggestions, educational insights, and easy-to-apply examples right here. Something great is on the way! 💡'**
  String get tipGeneric_description;

  /// No description provided for @learnMore.
  ///
  /// In en, this message translates to:
  /// **'Learn more'**
  String get learnMore;

  /// No description provided for @showLess.
  ///
  /// In en, this message translates to:
  /// **'Show less'**
  String get showLess;

  /// No description provided for @introMessageTooltip.
  ///
  /// In en, this message translates to:
  /// **'Intro message with subject name'**
  String get introMessageTooltip;

  /// No description provided for @unitRecommendationTitle.
  ///
  /// In en, this message translates to:
  /// **'Parent Tip'**
  String get unitRecommendationTitle;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

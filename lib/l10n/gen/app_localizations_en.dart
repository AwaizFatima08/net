// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Prep Simulator for NET';

  @override
  String loadError(String code) {
    return 'Could not load this. Please restart the app. ($code)';
  }

  @override
  String get tabTests => 'Mocks';

  @override
  String get tabPractice => 'Practice';

  @override
  String get tabGuide => 'Guide & tips';

  @override
  String get tabProgress => 'Progress';

  @override
  String get about => 'About';

  @override
  String get testsIntro =>
      '20 full-length NET-Engineering mocks: Mathematics 100, Physics 60 and English 40 questions, spread across the whole FSc syllabus. Every answer is explained after you submit.';

  @override
  String testNumber(int number) {
    return 'Mock $number';
  }

  @override
  String bestScore(int percent) {
    return 'Best $percent%';
  }

  @override
  String get inProgress => 'In progress';

  @override
  String get notStarted => 'Not taken';

  @override
  String sectionCount(int count) {
    return '$count questions';
  }

  @override
  String minutesLabel(int minutes) {
    return '$minutes minutes';
  }

  @override
  String get useEthics => 'Alternative section';

  @override
  String get useEthicsHelp => 'Not used in NET.';

  @override
  String get startTest => 'Start mock';

  @override
  String get resumeTest => 'Resume mock';

  @override
  String get restartTest => 'Start again';

  @override
  String get paperRules =>
      'Timed like the real NET-Engineering paper: 200 four-option questions in 3 hours, about 54 seconds each, 1 mark each and no negative marking, so answer every question. No calculator: work on scrap paper. You can move between questions, flag them and change answers. The timer pauses if you leave. Scores and explanations appear when you submit.';

  @override
  String get unofficialNote =>
      'Independent practice paper. NUST sets the real NET, its timing and scoring, so always follow nust.edu.pk, ugadmissions.nust.edu.pk and your admit card.';

  @override
  String get previousAttempts => 'Previous attempts';

  @override
  String questionOf(int number, int total) {
    return 'Question $number of $total';
  }

  @override
  String get previous => 'Previous';

  @override
  String get next => 'Next';

  @override
  String get flag => 'Flag';

  @override
  String get unflag => 'Unflag';

  @override
  String get questions => 'Questions';

  @override
  String get clearAnswer => 'Clear answer';

  @override
  String get submit => 'Submit paper';

  @override
  String get submitTitle => 'Submit this paper?';

  @override
  String submitBody(int answered, int total, int flagged) {
    return 'Answered $answered of $total. Flagged $flagged. You cannot change answers after submitting.';
  }

  @override
  String get keepWorking => 'Keep working';

  @override
  String get leaveTitle => 'Leave this paper?';

  @override
  String get leaveBody =>
      'Your answers are saved and the timer pauses. You can resume from the paper page.';

  @override
  String get leave => 'Leave';

  @override
  String get stay => 'Stay';

  @override
  String get readPassage => 'Show passage';

  @override
  String get hidePassage => 'Hide passage';

  @override
  String get timeLeft => 'Time left';

  @override
  String get results => 'Your result';

  @override
  String scoreOutOf(int correct, int total) {
    return '$correct / $total';
  }

  @override
  String percentLabel(int percent) {
    return '$percent%';
  }

  @override
  String scoreNote(int answered, int skipped) {
    return 'Answered $answered, skipped $skipped. NET has no negative marking: a skipped question is simply a lost mark. A practice estimate, not an official NET score.';
  }

  @override
  String get bySection => 'By subject';

  @override
  String get weakTopics => 'Topics to work on';

  @override
  String get reviewAnswers => 'Review answers and explanations';

  @override
  String get backHome => 'Back to mocks';

  @override
  String get filterAll => 'All';

  @override
  String get filterWrong => 'Wrong';

  @override
  String get filterSkipped => 'Skipped';

  @override
  String get filterEmpty => 'Nothing here.';

  @override
  String get yourAnswer => 'Your answer';

  @override
  String get correctAnswer => 'Correct answer';

  @override
  String get notAnswered => 'Not answered';

  @override
  String get explanation => 'Explanation';

  @override
  String get practiceIntro =>
      'Every subject in the NET papers, topic by topic: Mathematics, Physics and English (NET-Engineering), Chemistry and Biology (NET-Applied Sciences) and Quantitative Mathematics (NET-Business). Practice questions are never used in the mocks. Answers and explanations show as you go.';

  @override
  String practiceTally(int correct, int total) {
    return '$correct of $total right';
  }

  @override
  String get practiceEmpty => 'Questions for this topic are on the way.';

  @override
  String get checkAnswer => 'Check';

  @override
  String get finish => 'Finish';

  @override
  String get practiceAgain => 'Practise again';

  @override
  String get practiceDone => 'Practice finished';

  @override
  String get guideLoading => 'Guidance';

  @override
  String get progressEmpty => 'Finish a mock or a practice set to see your progress here.';

  @override
  String get testsTaken => 'Mocks taken';

  @override
  String get averageScore => 'Average';

  @override
  String get bestOverall => 'Best';

  @override
  String get history => 'Mock history';

  @override
  String get topicMastery => 'Weakest topics';

  @override
  String get deleteAttempt => 'Delete';

  @override
  String get aboutBody =>
      'Prep Simulator for NET is an independent practice app by HomiLabs for students preparing for the NUST Entry Test (NET), the undergraduate admission test of the National University of Sciences and Technology, Pakistan. It is not affiliated with, endorsed by or connected to NUST. All questions and explanations are original practice material written for this app, not real or recalled papers, and scores are practice estimates only. Always check nust.edu.pk for official dates, fees and rules.';

  @override
  String get privacy => 'Privacy policy';

  @override
  String get privacyChoices => 'Privacy choices';

  @override
  String get terms => 'Terms of use';

  @override
  String get website => 'Website';

  @override
  String get contact => 'Contact: homilabs.smc@gmail.com';

  @override
  String get version => 'Version 1.0.0';

  @override
  String get reviewTitle => 'Review answers';

  @override
  String get passLine =>
      'NUST publishes no pass mark: admission goes by merit (NET 75%, HSSC 15%, SSC 10%), and closing merit differs by programme and year. 70% is this app\'s practice target, not an official line.';

  @override
  String get passAbove => 'Strong: 70% or more';

  @override
  String get passBelow => 'Below 70%: keep practising';

  @override
  String get byGroup => 'Clinical and basic sciences';

  @override
  String get groupClinical => 'Clinical sciences';

  @override
  String get groupBasic => 'Applied basic sciences';

  @override
  String get lesson => 'Study notes';

  @override
  String get lessonHelp => 'Key ideas, worked examples and traps';

  @override
  String get practiceSet => 'Practise 10 questions';

  @override
  String practicePool(int count) {
    return '$count practice questions';
  }

  @override
  String get practiceNow => 'Practise this topic';

  @override
  String readingTime(int minutes) {
    return 'About $minutes minutes';
  }

  @override
  String netScore(int score) {
    return '$score / 200';
  }

  @override
  String get estimatedScore => 'Mock NET score';

  @override
  String get aggregateTitle => 'Estimate your merit aggregate';

  @override
  String get aggregateHelp =>
      'NUST aggregate = 75% NET + 15% HSSC (or Part I) + 10% SSC. Enter your board percentages.';

  @override
  String get sscPercent => 'SSC / Matric %';

  @override
  String get hsscPercent => 'HSSC / FSc %';

  @override
  String aggregateValue(String value) {
    return 'Aggregate $value%';
  }
}

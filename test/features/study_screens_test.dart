import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:net_prep/content/content_repository.dart';
import 'package:net_prep/features/guide/guide_article_screen.dart';
import 'package:net_prep/features/home/guide_tab.dart';
import 'package:net_prep/features/home/practice_tab.dart';
import 'package:net_prep/features/practice/topic_screen.dart';
import 'package:net_prep/l10n/gen/app_localizations.dart';
import 'package:net_prep/settings/settings_repository.dart';

/// Renders the study screens against the real built assets in assets/data.
class _NoTally extends PracticeTallyNotifier {
  @override
  Future<Map<String, List<int>>> build() async => const {};
}

final _assets = {
  for (final file in Directory('assets/data').listSync().whereType<File>())
    'assets/data/${file.uri.pathSegments.last}': file.readAsStringSync(),
};

Future<void> _pump(WidgetTester tester, Widget child) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        assetReaderProvider.overrideWithValue((path) async => _assets[path]!),
        practiceTallyProvider.overrideWith(_NoTally.new),
      ],
      child: MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(body: child),
      ),
    ),
  );
  for (var i = 0; i < 5; i++) {
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
    await tester.pump(const Duration(milliseconds: 100));
  }
}

void main() {
  testWidgets('practice lists every subject with its topics', (tester) async {
    await _pump(tester, const PracticeTab());
    expect(find.text('Mathematics'), findsOneWidget);
    expect(find.text('Number Systems and Complex Numbers'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Limits and Basic Calculus'), 500);
    expect(find.text('Limits and Basic Calculus'), findsOneWidget);
  });

  testWidgets('a topic offers practice', (tester) async {
    await _pump(tester, const TopicScreen(section: 'physics', topic: 'optics'));
    expect(find.text('Practise 10 questions'), findsOneWidget);
  });

  testWidgets('guide lists groups and opens an article', (tester) async {
    await _pump(tester, const GuideTab());
    expect(find.text('Start here'), findsOneWidget);
    expect(find.text('What is NET?'), findsOneWidget);
    await _pump(tester, const GuideArticleScreen(articleId: 'merit'));
    expect(find.text('Merit formula, with an example'), findsOneWidget);
  });
}

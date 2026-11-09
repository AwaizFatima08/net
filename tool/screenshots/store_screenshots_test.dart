// Renders the Play Store phone screenshots (1080x2400) from the real screens.
// Run: flutter test tool/screenshots/store_screenshots_test.dart
// Output: store-assets/screenshots/*.png
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:net_prep/app.dart';
import 'package:net_prep/attempts/attempt.dart';
import 'package:net_prep/attempts/attempt_repository.dart';
import 'package:net_prep/content/content_repository.dart';
import 'package:net_prep/content/models.dart';
import 'package:net_prep/core/clock.dart';
import 'package:net_prep/core/result.dart';
import 'package:net_prep/router.dart';
import 'package:net_prep/settings/settings_repository.dart';

final _now = DateTime(2026, 11, 4, 18);

class _FixedClock implements Clock {
  @override
  DateTime now() => _now;
}

class _MemoryStore implements DocumentStore {
  String? contents;
  @override
  Future<String?> read() async => contents;
  @override
  Future<void> write(String value) async => contents = value;
}

class _Choice extends ChoiceNotifier {
  _Choice(this.mode);
  final String mode;
  @override
  Future<TestChoice> build() async => TestChoice(mode: mode, stream: 'mock', useEthics: false);
}

class _Tally extends PracticeTallyNotifier {
  @override
  Future<Map<String, List<int>>> build() async => const {
    'physics/kinematics': [17, 20],
    'physics/forces': [14, 20],
    'physics/energy': [9, 15],
    'physics/circuits': [6, 12],
    'physics/optics': [11, 13],
    'math/functions': [18, 22],
    'math/trig': [12, 20],
    'chemistry/mole': [8, 14],
  };
}

final _assets = {
  for (final file in Directory('assets/data').listSync().whereType<File>())
    'assets/data/${file.uri.pathSegments.last}': file.readAsStringSync(),
};

Future<void> _loadFonts() async {
  final cache =
      '${Platform.environment['FLUTTER_ROOT'] ?? '/mnt/storage/projects/flutter'}/bin/cache/artifacts/material_fonts';
  Future<ByteData> bytes(String name) async =>
      ByteData.sublistView(File('$cache/$name').readAsBytesSync());
  final roboto = FontLoader('Roboto');
  for (final weight in ['Regular', 'Medium', 'Bold', 'Light', 'Italic']) {
    roboto.addFont(bytes('Roboto-$weight.ttf'));
  }
  await roboto.load();
  await (FontLoader('MaterialIcons')..addFont(bytes('MaterialIcons-Regular.otf'))).load();
}

/// Answers [correctCount] questions right and the rest wrong.
Map<String, int> _answers(List<Question> questions, int correctCount, {int? upTo}) => {
  for (final (i, q) in questions.take(upTo ?? questions.length).indexed)
    // Wrong answers spread through the paper, as in a real attempt.
    q.id: (i * 29) % questions.length < correctCount ? q.answer : (q.answer + 1) % q.options.length,
};

void main() {
  late _MemoryStore store;
  late Map<String, Sitting> sittings;

  setUpAll(() async {
    WidgetsApp.debugAllowBannerOverride = false;
    await _loadFonts();
    final repository = ContentRepository((path) async => _assets[path]!);
    final papers = await repository.papers();
    sittings = {
      for (final id in ['physics-01', 'math-03', 'chemistry-02', 'physics-04'])
        id: switch (await repository.sitting(
          papers.firstWhere((p) => p.id == id),
          useEthics: false,
        )) {
          Ok(:final value) => value,
          Err(:final failure) => throw failure,
        },
    };
  });

  setUp(() {
    store = _MemoryStore();
  });

  Future<void> shoot(
    WidgetTester tester,
    String name,
    String location, {
    String mode = 'physics',
    List<Attempt> attempts = const [],
    Future<void> Function()? then,
  }) async {
    tester.view.physicalSize = const Size(1080, 2400);
    tester.view.devicePixelRatio = 2.625;
    addTearDown(tester.view.reset);
    store.contents = jsonEncodeAttempts(attempts);
    final container = ProviderContainer(
      overrides: [
        assetReaderProvider.overrideWithValue((path) async => _assets[path]!),
        attemptStoreProvider.overrideWithValue(store),
        clockProvider.overrideWithValue(_FixedClock()),
        choiceProvider.overrideWith(() => _Choice(mode)),
        practiceTallyProvider.overrideWith(_Tally.new),
      ],
    );
    final boundary = GlobalKey();
    await tester.pumpWidget(
      RepaintBoundary(
        key: boundary,
        child: UncontrolledProviderScope(container: container, child: const NetApp()),
      ),
    );
    final router = container.read(routerProvider);
    if (location != '/') router.go(location);
    for (var i = 0; i < 6; i++) {
      await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 100)));
      await tester.pump(const Duration(milliseconds: 100));
    }
    if (then != null) {
      await then();
      for (var i = 0; i < 4; i++) {
        await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 50)));
        await tester.pump(const Duration(milliseconds: 300));
      }
    }
    await tester.runAsync(() async {
      final render = boundary.currentContext!.findRenderObject()! as RenderRepaintBoundary;
      final image = await render.toImage(pixelRatio: 2.625);
      final png = await image.toByteData(format: ui.ImageByteFormat.png);
      File('store-assets/screenshots/$name.png')
        ..createSync(recursive: true)
        ..writeAsBytesSync(png!.buffer.asUint8List());
    });
    await tester.pumpWidget(const SizedBox());
    router.dispose();
    container.dispose();
  }

  Attempt finished(String id, String paperId, int correct, int daysAgo) {
    final questions = sittings[paperId]!.questions;
    return Attempt(
      id: id,
      paperId: paperId,
      useEthics: false,
      startedAt: _now.subtract(Duration(days: daysAgo, hours: 1)),
      remainingSeconds: 0,
      answers: _answers(questions, correct),
      finishedAt: _now.subtract(Duration(days: daysAgo)),
      correct: correct,
      total: questions.length,
    );
  }

  List<Attempt> history() => [
    finished('3', 'physics-01', 37, 1),
    finished('2', 'math-03', 34, 3),
    finished('1', 'chemistry-02', 29, 6),
  ];

  testWidgets('1 mocks', (tester) async {
    await shoot(tester, '1-mocks', '/', attempts: history());
  });

  testWidgets('2 exam', (tester) async {
    final questions = sittings['physics-04']!.questions;
    final index = questions.indexWhere(
      (q) => q.stem.length > 140 && q.stem.length < 260 && !q.stem.contains('\n'),
    );
    final attempt = Attempt(
      id: '9',
      paperId: 'physics-04',
      useEthics: false,
      startedAt: _now,
      remainingSeconds: 37 * 60 + 12,
      answers: {
        ..._answers(questions, index, upTo: index),
        questions[index].id: questions[index].answer,
      },
      flagged: {questions[3].id},
      currentIndex: index,
    );
    await shoot(tester, '2-mock-question', '/exam/9', attempts: [attempt]);
  });

  testWidgets('3 results', (tester) async {
    await shoot(tester, '3-results', '/results/3', attempts: history());
  });

  testWidgets('4 review', (tester) async {
    await shoot(tester, '4-explanations', '/review/3', attempts: history());
  });

  testWidgets('5 practice', (tester) async {
    await shoot(
      tester,
      '5-practice',
      '/',
      then: () async {
        await tester.tap(find.byIcon(Icons.fitness_center));
      },
    );
  });

  testWidgets('6 notes', (tester) async {
    await shoot(tester, '6-study-notes', '/lesson/math/trig');
  });

  testWidgets('7 guide', (tester) async {
    await shoot(
      tester,
      '7-guide',
      '/',
      then: () async {
        await tester.tap(find.byIcon(Icons.lightbulb_outline));
      },
    );
  });
}

String jsonEncodeAttempts(List<Attempt> attempts) =>
    const JsonEncoder().convert([for (final a in attempts) a.toJson()]);

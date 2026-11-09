import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:net_prep/content/models.dart';

/// Checks the built assets: every paper resolves to real questions in the right pool.
void main() {
  final forms = jsonDecode(File('assets/data/forms.json').readAsStringSync()) as List<Object?>;
  final papers = [for (final form in forms) Paper.fromJson(form! as Json)];
  final questions = <String, Question>{};
  for (final file in Directory('assets/data').listSync().whereType<File>()) {
    final name = file.uri.pathSegments.last;
    if (!name.startsWith('bank_')) continue;
    final section = name.substring(5, name.length - 5);
    final json = jsonDecode(file.readAsStringSync()) as Json;
    for (final raw in json['questions']! as List<Object?>) {
      final question = Question.fromJson(raw! as Json, section);
      questions[question.id] = question;
    }
  }

  test('every paper uses test-pool questions only, each once', () {
    for (final paper in papers) {
      for (final useEthics in [false, true]) {
        final ids = [
          for (final section in paper.sectionsFor(useEthics: useEthics)) ...section.itemIds,
        ];
        expect(ids.toSet(), hasLength(ids.length), reason: paper.id);
        for (final id in ids) {
          expect(questions[id]?.isPractice, isFalse, reason: '${paper.id} $id');
        }
      }
    }
  });

  test('20 NET-Engineering mocks of 200 questions: Maths 100, Physics 60, English 40', () {
    final catalog = Catalog.fromJson(
      jsonDecode(File('assets/data/catalog.json').readAsStringSync()) as Json,
    );
    expect(catalog.modes.map((mode) => mode.key), ['engineering']);
    expect(papers, hasLength(20));
    final ids = <String>[];
    for (final paper in papers) {
      expect(paper.minutes, 180, reason: paper.id);
      expect(
        [for (final section in paper.sections) section.itemIds.length],
        [100, 60, 40],
        reason: paper.id,
      );
      ids.addAll([for (final section in paper.sections) ...section.itemIds]);
    }
    expect(ids.toSet(), hasLength(4000));
  });

  test('every subject has practice questions', () {
    final catalog = Catalog.fromJson(
      jsonDecode(File('assets/data/catalog.json').readAsStringSync()) as Json,
    );
    expect(catalog.sections.map((section) => section.key), [
      'math',
      'physics',
      'english',
      'chemistry',
      'biology',
      'quant',
    ]);
    for (final section in catalog.sections) {
      for (final topic in section.topics) {
        expect(topic.practiceCount, greaterThan(0), reason: '${section.key}/${topic.key}');
      }
    }
  });

  test('every answer key points at an option', () {
    for (final question in questions.values) {
      expect(
        question.answer,
        inInclusiveRange(0, question.options.length - 1),
        reason: question.id,
      );
    }
  });
}

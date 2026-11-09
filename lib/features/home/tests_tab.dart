import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:net_prep/app.dart';
import 'package:net_prep/attempts/attempt.dart';
import 'package:net_prep/attempts/attempt_repository.dart';
import 'package:net_prep/content/content_repository.dart';
import 'package:net_prep/content/models.dart';
import 'package:net_prep/settings/settings_repository.dart';
import 'package:net_prep/ui/async_value_view.dart';
import 'package:net_prep/ui/theme.dart';

class TestsTab extends ConsumerWidget {
  const TestsTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => AsyncBody(
    value: ref.watch(catalogProvider),
    data: (catalog) => AsyncBody(
      value: ref.watch(choiceProvider),
      data: (choice) => AsyncBody(
        value: ref.watch(papersProvider),
        data: (papers) => _TestsList(catalog: catalog, choice: choice, papers: papers),
      ),
    ),
  );
}

class _TestsList extends ConsumerWidget {
  const _TestsList({
    required this.catalog,
    required this.choice,
    required this.papers,
  });

  final Catalog catalog;
  final TestChoice choice;
  final List<Paper> papers;

  void _pickMode(WidgetRef ref, ModeInfo mode) => unawaited(
    ref
        .read(choiceProvider.notifier)
        .choose(
          choice.copyWith(mode: mode.key, stream: mode.streams.first.key),
        ),
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // A stored choice from an older build may name a mode or stream that no longer exists.
    final mode = catalog.modes.firstWhere(
      (candidate) => candidate.key == choice.mode,
      orElse: () => catalog.modes.first,
    );
    final stream = mode.streams.any((s) => s.key == choice.stream)
        ? choice.stream
        : mode.streams.first.key;
    final shown = [
      for (final paper in papers)
        if (paper.mode == mode.key && paper.stream == stream) paper,
    ];
    final attempts = ref.watch(attemptsProvider).value ?? const <Attempt>[];
    return ListView(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      children: [
        if (catalog.modes.length > 1)
          SegmentedButton<String>(
            showSelectedIcon: false,
            segments: [
              for (final option in catalog.modes)
                ButtonSegment(value: option.key, label: Text(option.title)),
            ],
            selected: {mode.key},
            onSelectionChanged: (value) => _pickMode(
              ref,
              catalog.modes.firstWhere((m) => m.key == value.first),
            ),
          ),
        const SizedBox(height: AppSpacing.sm),
        if (mode.streams.length > 1)
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              for (final stream in mode.streams)
                ChoiceChip(
                  label: Text(stream.title),
                  selected: stream.key == choice.stream,
                  onSelected: (_) => unawaited(
                    ref.read(choiceProvider.notifier).choose(choice.copyWith(stream: stream.key)),
                  ),
                ),
            ],
          ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '${mode.subtitle}. ${context.l10n.testsIntro}',
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final paper in shown) _PaperTile(paper: paper, attempts: attempts),
      ],
    );
  }
}

class _PaperTile extends StatelessWidget {
  const _PaperTile({required this.paper, required this.attempts});

  final Paper paper;
  final List<Attempt> attempts;

  String _status(BuildContext context) {
    final mine = [
      for (final attempt in attempts)
        if (attempt.paperId == paper.id) attempt,
    ];
    final l10n = context.l10n;
    if (mine.any((attempt) => !attempt.isFinished)) return l10n.inProgress;
    if (mine.isEmpty) return l10n.notStarted;
    final best = mine.map((attempt) => attempt.percent).reduce((a, b) => a > b ? a : b);
    return l10n.bestScore(best);
  }

  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: CircleAvatar(child: Text('${paper.number}')),
      title: Text(context.l10n.testNumber(paper.number)),
      subtitle: Text(_status(context)),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => unawaited(context.push('/paper/${paper.id}')),
    ),
  );
}

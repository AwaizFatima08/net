import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:net_prep/app.dart';
import 'package:net_prep/content/content_repository.dart';
import 'package:net_prep/settings/settings_repository.dart';
import 'package:net_prep/ui/async_value_view.dart';
import 'package:net_prep/ui/rich_lines.dart';
import 'package:net_prep/ui/theme.dart';

/// One topic: its study notes, its practice set and the candidate's record.
class TopicScreen extends ConsumerWidget {
  const TopicScreen({required this.section, required this.topic, super.key});

  final String section;
  final String topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final tally = ref.watch(practiceTallyProvider).value?['$section/$topic'];
    return AsyncValueView(
      value: ref.watch(catalogProvider),
      data: (catalog) {
        final info = catalog.sections
            .firstWhere((s) => s.key == section)
            .topics
            .firstWhere((t) => t.key == topic);
        return Scaffold(
          appBar: AppBar(title: Text(info.title)),
          body: ListView(
            padding: const EdgeInsetsDirectional.all(AppSpacing.md),
            children: [
              if (info.hasLesson)
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.school_outlined),
                    title: Text(l10n.lesson),
                    subtitle: Text(l10n.lessonHelp),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => unawaited(context.push('/lesson/$section/$topic')),
                  ),
                ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: Text(l10n.practiceSet),
                  subtitle: Text(
                    switch (tally) {
                      [final correct, final total] =>
                        '${l10n.practicePool(info.practiceCount)} · ${l10n.practiceTally(correct, total)}',
                      _ => l10n.practicePool(info.practiceCount),
                    },
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () => unawaited(context.push('/practice/$section/$topic')),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class LessonScreen extends ConsumerWidget {
  const LessonScreen({required this.section, required this.topic, super.key});

  final String section;
  final String topic;

  @override
  Widget build(BuildContext context, WidgetRef ref) => AsyncValueView(
    value: ref.watch(lessonsProvider),
    data: (lessons) {
      final lesson = lessons.firstWhere((l) => l.section == section && l.topic == topic);
      return Scaffold(
        appBar: AppBar(title: Text(lesson.title)),
        body: ListView(
          padding: const EdgeInsetsDirectional.all(AppSpacing.md),
          children: [
            Text(
              context.l10n.readingTime(lesson.minutes),
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: AppSpacing.sm),
            RichLines(lesson.lines),
            const SizedBox(height: AppSpacing.lg),
            FilledButton(
              onPressed: () => context.pushReplacement('/practice/$section/$topic'),
              child: Text(context.l10n.practiceNow),
            ),
          ],
        ),
      );
    },
  );
}

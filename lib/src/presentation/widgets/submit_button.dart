import 'package:fashion_app/src/presentation/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubmitButton extends ConsumerWidget {
  const SubmitButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(homeScreenControllerProvider);
    return Visibility(
      visible: ref.read(homeScreenControllerProvider.notifier).canSubmit,
      child: ElevatedButton(
          onPressed: () {
            ref.read(homeScreenControllerProvider.notifier).generateOutfits();
          },
          child: const Text('Generate Outfits')),
    );
  }
}

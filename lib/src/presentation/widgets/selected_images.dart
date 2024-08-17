import 'package:fashion_app/src/presentation/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedImages extends ConsumerWidget {
  const SelectedImages({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = ref.watch(homeScreenControllerProvider
        .select((state) => state.value?.images ?? []));

    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: images
          .map<Image>((file) => Image.file(
                file,
                height: 90,
                width: 90,
              ))
          .toList(),
    );
  }
}

import 'dart:io';
import 'package:fashion_app/src/presentation/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class SelectImagesButton extends ConsumerWidget {
  const SelectImagesButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
        // Prevent selecting images when screen is in the loading state
        onPressed: ref.watch(homeScreenControllerProvider).isLoading
            ? null
            : () async {
                final ImagePicker picker = ImagePicker();
                final List<XFile> selectedImages =
                    await picker.pickMultiImage();
                if (selectedImages.isEmpty) {
                  return;
                }
                final List<File> files = [];
                for (var file in selectedImages) {
                  files.add(File(file.path));
                }
                ref
                    .read(homeScreenControllerProvider.notifier)
                    .updateImages(files);
              },
        child: const Text('Select Images'));
  }
}

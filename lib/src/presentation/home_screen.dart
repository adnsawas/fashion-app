import 'package:fashion_app/src/presentation/widgets/outfits_widget.dart';
import 'package:fashion_app/src/presentation/widgets/select_images_button.dart';
import 'package:fashion_app/src/presentation/widgets/selected_images.dart';
import 'package:fashion_app/src/presentation/widgets/submit_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fashion App')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          SelectImagesButton(),
          SizedBox(height: 16),
          SelectedImages(),
          SizedBox(height: 16),
          SubmitButton(),
          SizedBox(height: 16),
          OutfitsWidget(),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}

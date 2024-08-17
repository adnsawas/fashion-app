import 'dart:convert';
import 'dart:io';

import 'package:fashion_app/src/models/outfit_model.dart';
import 'package:fashion_app/src/data/outfit_repository.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiOutfitRepository implements OutfitRepository {
  @override
  Future<List<Outfit>> generateOutfits(List<File> files) async {
    final model = GenerativeModel(
        model: 'gemini-1.5-pro',
        apiKey: dotenv.env['API_KEY']!,
        generationConfig:
            GenerationConfig(responseMimeType: 'application/json'));

    final imagesContent = files
        .map((image) => Content.data('image/png', image.readAsBytesSync()))
        .toList();
    final content = [Content.text(prompt), ...imagesContent];

    final geminiResposne = await model.generateContent(content);

    try {
      if (geminiResposne.text?.isEmpty ?? true) {
        throw '';
      }
      final jsonResponse = jsonDecode(geminiResposne.text!);
      final outfits =
          jsonResponse.map<Outfit>((outfit) => Outfit.fromMap(outfit)).toList();
      return outfits;
    } catch (e) {
      throw 'Could not generate an outfit from given images';
    }
  }
}

const String prompt = """
As a fashion designer, use only clothing items in the attached photos to come up with list of good looking outfits. Use this JSON example for the outfit:
[{
"name": "Sporty and Cool",
"description": "A stylish and comfortable outfit perfect for a workout or running errands.",
"components": [{"top": "Red T-Shirt"}, {"shoes": "Blue and white sneakers"}],
"occasions": ["Workout", "running errands", "casual day out"],
"mainColors": ["0xFFAABBCC", "0xFF123456"],
"explanation": "This outfit works because its colors are vibrant and has good contrasts and very suitable for summer days or handing out with friends"
}]
Note the following: 
Do not create outfits that consists of only one item. Every outfit should contain at least 2 components.
Do not duplicate colors in the "colors" property. This property should contain the main colors that represent the outfit without duplication.
Generate a JSON that contains a list of a maximum of 4 outfits
""";

import 'dart:convert';
import 'dart:io';
import 'package:fashion_app/src/models/outfit_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

Future<List<Outfit>> askGemini(List<File> files) async {
  final model = GenerativeModel(
      model: 'gemini-1.5-pro',
      apiKey: dotenv.env['API_KEY']!,
      generationConfig: GenerationConfig(responseMimeType: 'application/json'));

  final imagesContent = files
      .map((image) => Content.data('image/png', image.readAsBytesSync()))
      .toList();
  final content = [Content.text(prompt1), ...imagesContent];

  final geminiResposne = await model.generateContent(content);

  try {
    final jsonResponse = jsonDecode(geminiResposne.text!);
    List<Outfit> outfits = jsonResponse['outfits']
        .map<Outfit>((outfit) => Outfit.fromMap(outfit))
        .toList();
    return outfits;
  } catch (e) {
    throw 'Could not generate an outfit from given images';
  }
}

const prompt1 =
    '''I am looking for an outfit that is beautiful and good looking.
    All the attached images are clothing items.
    Look at all these clothig items and come up with multiple outfits (if applicable) that have the best combimation in terms of colors and fashion beauty.
    Please provide a detailed description of the designed outfit, including the specific clothing items and accessories, and a brief explanation of why it works well.
    Do not use clothing items other than the ones provided to you
    For the "mainColor" field. please specify the color HEX value (in this format 0xFF123456) instead of the color name.
    I want the response to be in a JSON format. Please follow this example:
    {
      "outfits": [
      "name": "Cloudy look"
      "description": "A casual and trendy outfit perfect for a day out. The striped t-shirt adds a pop of color, while the denim jacket provides a touch of coolness. The floral skirt adds a feminine touch, and the brown sandals complete the look with a comfortable and stylish finish.",
      "items": [
        { "type": "top", "description": "Striped T-shirt", "mainColor": "blue" },
        { "type": "bottom", "description": "Floral Skirt", , "mainColor": "red" },
        { "type": "outerwear", "description": "Denim Jacket", "mainColor": "black" },
        { "type": "shoes", "description": "Brown Sandals", "mainColor": "brown" },
        { "type": "accessory", "description": "Straw Hat", "mainColor": "yellwo" } 
      ],
    }]
    }''';

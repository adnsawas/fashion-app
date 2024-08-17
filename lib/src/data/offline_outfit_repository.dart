import 'dart:convert';
import 'dart:io';
import 'package:fashion_app/src/data/example_results.dart';
import 'package:fashion_app/src/models/outfit_model.dart';
import 'package:fashion_app/src/data/outfit_repository.dart';
import 'package:flutter/material.dart';

class OfflineOutfitRepository implements OutfitRepository {
  @override
  Future<List<Outfit>> generateOutfits(List<File> files) async {
    // Read the stored results
    await Future.delayed(Durations.extralong1);
    final json = jsonDecode(results);
    final outfits =
        json.map<Outfit>((outfit) => Outfit.fromMap(outfit)).toList();
    return outfits;
  }
}

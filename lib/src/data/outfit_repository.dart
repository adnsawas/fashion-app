import 'dart:io';

import 'package:fashion_app/src/data/gemeni_outfit_repository.dart';
import 'package:fashion_app/src/data/offline_outfit_repository.dart';
import 'package:fashion_app/src/models/outfit_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:fashion_app/src/data/gemeni_outfit_repository.dart';

abstract class OutfitRepository {
  Future<List<Outfit>> generateOutfits(List<File> files);
}

final outfitRepositoryProvider = Provider<OutfitRepository>((ref) {
  // return OfflineOutfitRepository();
  return GeminiOutfitRepository();
});

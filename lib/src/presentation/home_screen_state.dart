import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:fashion_app/src/models/outfit_model.dart';

class HomeScreenState {
  final List<File> images;
  final List<Outfit> outfits;

  HomeScreenState({required this.images, required this.outfits});

  HomeScreenState copyWith({
    List<File>? images,
    List<Outfit>? outfits,
  }) {
    return HomeScreenState(
      images: images ?? this.images,
      outfits: outfits ?? this.outfits,
    );
  }

  @override
  bool operator ==(covariant HomeScreenState other) {
    if (identical(this, other)) return true;

    return listEquals(other.images, images) &&
        listEquals(other.outfits, outfits);
  }

  @override
  int get hashCode => images.hashCode ^ outfits.hashCode;
}

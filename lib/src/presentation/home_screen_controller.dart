import 'dart:io';
import 'package:fashion_app/src/data/outfit_repository.dart';
import 'package:fashion_app/src/presentation/home_screen_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreenControllerNotifier extends AsyncNotifier<HomeScreenState> {
  @override
  Future<HomeScreenState> build() async {
    return HomeScreenState(images: [], outfits: []);
  }

  // Create a new AsyncValue that contains a new HomeScreenState with images updated
  void updateImages(List<File> files) {
    state = AsyncData(state.requireValue.copyWith(images: files));
  }

  Future<void> generateOutfits() async {
    if (!canSubmit) {
      return;
    }
    state = const AsyncLoading();
    final newState = await AsyncValue.guard(() => ref
        .read(outfitRepositoryProvider)
        .generateOutfits(state.requireValue.images));

    if (newState.hasError) {
      state = AsyncError(newState.error!, StackTrace.current);
    } else {
      state = AsyncValue.data(
          state.requireValue.copyWith(outfits: newState.requireValue));
    }
  }

  bool get canSubmit =>
      !state.isLoading &&
      state.hasValue &&
      state.requireValue.images.length > 1;
}

final homeScreenControllerProvider =
    AsyncNotifierProvider<HomeScreenControllerNotifier, HomeScreenState>(
        HomeScreenControllerNotifier.new);

import 'package:fashion_app/src/presentation/home_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OutfitsWidget extends ConsumerWidget {
  const OutfitsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(homeScreenControllerProvider);
    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) =>
          Text(error.toString(), style: const TextStyle(color: Colors.red)),
      data: (data) => Column(
        children: data.outfits
            .map<Widget>((outfit) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                    childrenPadding: const EdgeInsets.all(12),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                        side:
                            const BorderSide(color: Colors.black26, width: 2)),
                    title: Row(
                      children: [
                        Text(outfit.name),
                        const SizedBox(width: 8),
                        ...outfit.mainColors.map<Widget>((color) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: OutfitColor(
                                color: Color(int.parse(color)),
                              ),
                            ))
                      ],
                    ),
                    children: [
                      Wrap(
                        spacing: 4,
                        children: [
                          ...outfit.occasions.map<Widget>((occasion) => Chip(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              padding: const EdgeInsets.all(0),
                              backgroundColor: Colors.amber[100],
                              labelPadding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 0),
                              visualDensity: VisualDensity.compact,
                              label: Text(
                                occasion,
                                style: const TextStyle(fontSize: 10),
                              ))),
                        ],
                      ),
                      Text(outfit.description),
                      const SizedBox(height: 24),
                      ...outfit.components.map<Widget>((component) => Row(
                            children: [
                              Expanded(
                                  flex: 1, child: Text(component.keys.first)),
                              Expanded(
                                  flex: 4, child: Text(component.values.first))
                            ],
                          )),
                      const SizedBox(height: 24),
                    ],
                  ),
                ))
            .toList(),
      ),
    );
  }
}

class OutfitColor extends StatelessWidget {
  final Color color;
  const OutfitColor({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 12,
      height: 12,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(spreadRadius: 1, blurRadius: 1, color: Colors.black26)
          ]),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class Outfit {
  final String name;
  final String description;
  final List<Map<String, String>> components;
  final List<String> occasions;
  final List<String> mainColors;
  final String explanation;

  Outfit({
    required this.name,
    required this.description,
    required this.components,
    required this.occasions,
    required this.mainColors,
    required this.explanation,
  });

  Outfit copyWith({
    String? name,
    String? description,
    List<Map<String, String>>? components,
    List<String>? occasions,
    List<String>? mainColors,
    String? explanation,
  }) {
    return Outfit(
      name: name ?? this.name,
      description: description ?? this.description,
      components: components ?? this.components,
      occasions: occasions ?? this.occasions,
      mainColors: mainColors ?? this.mainColors,
      explanation: explanation ?? this.explanation,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'components': components,
      'occasions': occasions,
      'mainColors': mainColors,
      'explanation': explanation,
    };
  }

  factory Outfit.fromMap(Map<String, dynamic> map) {
    return Outfit(
      name: map['name'] as String,
      description: map['description'] as String,
      components: map['components']
          .map<Map<String, String>>(
            (x) => {
              x.entries.first.key.toString(): x.entries.first.value.toString()
            },
          )
          .toList(),
      occasions: List<String>.from(map['occasions'] as List),
      mainColors: List<String>.from(map['mainColors'] as List),
      explanation: map['explanation'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Outfit.fromJson(String source) =>
      Outfit.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Fashion(name: $name, description: $description, components: $components, occasions: $occasions, mainColors: $mainColors, explanation: $explanation)';
  }

  @override
  bool operator ==(covariant Outfit other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        listEquals(other.components, components) &&
        listEquals(other.occasions, occasions) &&
        listEquals(other.mainColors, mainColors) &&
        other.explanation == explanation;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        components.hashCode ^
        occasions.hashCode ^
        mainColors.hashCode ^
        explanation.hashCode;
  }
}

import 'package:graphqldemo/models/language.dart';

class Country {
  final String? code;
  final String? name;
  final String? capital;
  final String? emoji;
  final String? currency;
  final List<Language>? languages;
  final Continent? continent;

  Country({
    this.code,
    this.name,
    this.capital,
    this.emoji,
    this.currency,
    this.languages,
    this.continent,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      code: json['code'],
      name: json['name'],
      capital: json['capital'],
      emoji: json['emoji'],
      currency: json['currency'],
      languages: json['languages'] != null
          ? (json['languages'] as List)
              .map((lang) => Language.fromJson(lang))
              .toList()
          : null,
      continent: json['continent'] != null
          ? Continent.fromJson(json['continent'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'capital': capital,
      'emoji': emoji,
      'currency': currency,
      'languages': languages?.map((lang) => lang.toJson()).toList(),
      'continent': continent?.toJson(),
    };
  }
}

class Continent {
  final String? code;
  final String? name;

  Continent({
    this.code,
    this.name,
  });

  factory Continent.fromJson(Map<String, dynamic> json) {
    return Continent(
      code: json['code'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
    };
  }
}

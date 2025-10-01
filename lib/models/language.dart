class Language {
  final String? code;
  final String? name;
  final String? native;
  final bool? rtl;

  Language({
    this.code,
    this.name,
    this.native,
    this.rtl,
  });

  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      code: json['code'],
      name: json['name'],
      native: json['native'],
      rtl: json['rtl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'name': name,
      'native': native,
      'rtl': rtl,
    };
  }
}

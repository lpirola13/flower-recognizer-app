
class Language {
  String language;
  String locale;

  Language(this.language, this.locale);

  @override
  int get hashCode => locale.hashCode;

  @override
  bool operator ==(Object other) => other is Language && language == other.language && locale == other.locale;
}
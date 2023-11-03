import 'dart:ui';

enum Language {
  english(
    Locale('en', 'US'),
    'English',
  ),
  arabic(
    Locale('ar', 'SR'),
    'Arabic',
  );

  /// Add another languages support here
  const Language(this.value, this.text);

  final Locale value;
  final String text; // Optional: this properties used for ListTile details
}

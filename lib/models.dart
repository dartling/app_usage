class UsedApp {
  final String id;
  final String name;
  final Duration timeUsed;

  UsedApp(this.id, this.name, this.timeUsed);

  static UsedApp fromJson(dynamic json) {
    return UsedApp(
      json['id'] as String,
      json['name'] as String,
      Duration(minutes: json['minutesUsed'] as int),
    );
  }
}

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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UsedApp &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          timeUsed == other.timeUsed;

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ timeUsed.hashCode;
}

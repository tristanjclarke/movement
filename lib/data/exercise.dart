class Exercise {
  Exercise({
    required this.name,
  });

  final String name;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exercise && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  Exercise copyWith({
    String? name,
  }) {
    return Exercise(
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Exercise{name: $name}';
  }
}

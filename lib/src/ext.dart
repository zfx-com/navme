extension Linq<T> on List<T> {
  /// default = null
  T get firstOrDefault => isEmpty ? null : first;
  bool get empty => this == null || isEmpty;
}

extension XDartString on String {
  Uri toUri() {
    if (this == null) {
      return null;
    }
    return Uri.parse(this);
  }
}

/// extension List
extension Linq<T> on List<T?>? {
  /// default = null
  T? get firstOrDefault =>
      this == null ? null : (this!.isEmpty ? null : this!.first);

  /// null || isEmpty
  bool get empty => this == null || this!.isEmpty;
}

/// extension String
extension XDartString on String? {
  /// get Uri from string
  Uri? toUri() {
    if (this == null) {
      return null;
    }
    return Uri.parse(this!);
  }
}

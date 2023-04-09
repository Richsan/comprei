extension DateDiff on List<DateTime> {
  List<int> toDaysDiff() {
    if (isEmpty) {
      return [];
    }

    sort();

    final copy = List<DateTime>.from([first, ...this]);

    copy.removeLast();

    return asMap()
        .entries
        .map((e) => e.value.difference(copy[e.key]).inDays)
        .toList();
  }
}

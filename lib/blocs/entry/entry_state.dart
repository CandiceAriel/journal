part of 'entry_bloc.dart';

enum EntryStatus { initial, success, failure }

final class EntryState extends Equatable {
  const EntryState({
    this.status = EntryStatus.initial,
    this.entries = const <Entry>[],
    this.hasReachedMax = false,
  });

  final EntryStatus status;
  final List<Entry> entries;
  final bool hasReachedMax;

  EntryState copyWith({
    EntryStatus? status,
    List<Entry>? entries,
    bool? hasReachedMax,
  }) {
    return EntryState(
      status: status ?? this.status,
      entries: entries ?? this.entries,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''EntryState { status: $status, hasReachedMax: $hasReachedMax, Entries: ${entries.length} }''';
  }

  @override
  List<Object> get props => [status, entries, hasReachedMax];
}
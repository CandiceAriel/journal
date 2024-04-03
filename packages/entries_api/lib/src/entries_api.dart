import 'package:entries_api/src/models/entry.dart';

abstract class EntriesApi {
  const EntriesApi();

  /// Provides a [Stream] of all entries.
  Stream<List<Entry>> getEntries();

  /// Saves a [entry].
  ///
  /// If a [entry] with the same id already exists, it will be replaced.
  Future<void> saveEntry(Entry entry);

  /// Deletes the `entry` with the given id.
  ///
  /// If no `entry` with the given id exists, a [EntryNotFoundException] error is
  /// thrown.
  Future<void> deleteEntry(String id);
}

/// Error thrown when a [Entry] with a given id is not found.
class EntryNotFoundException implements Exception {}
import 'package:entries_api/entries_api.dart';

/// A repository that handles `entry` related requests.
class EntriesRepository {
  const EntriesRepository({
    required EntriesApi entriesApi,
  }) : _entriesApi = entriesApi;

  final EntriesApi _entriesApi;

  Stream<List<Entry>> getEntries() => _entriesApi.getEntries();

  Future<void> saveEntry(Entry entry) => _entriesApi.saveEntry(entry);

  Future<void> deleteEntry(String id) => _entriesApi.deleteEntry(id);
}
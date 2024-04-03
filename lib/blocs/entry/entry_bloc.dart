import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:entries_api/entries_api.dart';


part 'entry_event.dart';
part 'entry_state.dart';

class PostBloc extends Bloc<EntryEvent, EntryState> {
  PostBloc({required this.httpClient}) : super(const EntryState()) {
    on<EntryFetched>(
      _onEntryFetched,
    );
  }

  final http.Client httpClient;

  Future<void> _onEntryFetched(
    EntryFetched event,
    Emitter<EntryState> emit,
  ) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == EntryStatus.initial) {
        final entries = await _fetchEntries();
        return emit(
          state.copyWith(
            status: EntryStatus.success,
            entries: entries,
            hasReachedMax: false,
          ),
        );
      }
      final entries = await _fetchEntries(state.entries.length);
      entries.isEmpty
          ? emit(state.copyWith(hasReachedMax: true))
          : emit(
              state.copyWith(
                status: EntryStatus.success,
                entries: List.of(state.entries)..addAll(entries),
                hasReachedMax: false,
              ),
            );
    } catch (_) {
      emit(state.copyWith(status: EntryStatus.failure));
    }
  }


  Future<List<Entry>> _fetchEntries([int startIndex = 0]) async {
    final response = await httpClient.get(
      Uri.https(
        'jsonplaceholder.typicode.com',
        '/posts',
      ),
    );
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return Entry(
          id: map['id'] as String,
          title: map['title'] as String,
          content: map['content'] as String,
          date: map['date'] as String,
        );
      }).toList();
    }
    throw Exception('error fetching posts');
  }
}
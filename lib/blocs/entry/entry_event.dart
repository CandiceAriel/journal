part of 'entry_bloc.dart';

sealed class EntryEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class EntryFetched extends EntryEvent {}
final class CreateEntry extends EntryEvent {}
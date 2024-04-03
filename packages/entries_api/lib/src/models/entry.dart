import 'package:entries_api/src/models/json_map.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'entry.g.dart';

/// {@template todo_item}
/// A single `entry` item.
///
/// Contains a [title], [content], [date] and [id].
///
/// If an [id] is provided, it cannot be empty. If no [id] is provided, one
/// will be generated.
///
/// {@endtemplate}
@immutable
@JsonSerializable()
class Entry extends Equatable {
  Entry({
    required this.title,
    String? id,
    this.content = '',
    this.date = ' '
  })  : assert(
          id == null || id.isNotEmpty,
          'id must either be null or not empty',
        ),
        id = id ?? const Uuid().v4();

  /// The unique identifier of the `entry`.
  ///
  /// Cannot be empty.
  final String id;

  /// The title of the `entry`.
  ///
  /// Note that the title may be empty.
  final String title;

  /// The content of the `entry`.
  ///
  /// Defaults to an empty string.
  final String content;

  /// The 'date' of the entry.
  ///
  /// Defaults to today's date.
  final String date;

  /// Returns a copy of this `entry` with the given values updated.
  ///
  /// {@macro entry_item}
  Entry copyWith({
    String? id,
    String? title,
    String? content,
    String? date,
  }) {
    return Entry(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      date: date ?? this.date,
    );
  }

  /// Deserializes the given [JsonMap] into a [Entry].
  static Entry fromJson(JsonMap json) => _$EntryFromJson(json);

  /// Converts this [Entry] into a [JsonMap].
  JsonMap toJson() => _$EntryToJson(this);

  @override
  List<Object> get props => [id, title, content, date];
}
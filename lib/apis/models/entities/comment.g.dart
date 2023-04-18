// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$CommentCWProxy {
  Comment id(String? id);

  Comment type(String? type);

  Comment comment(String? comment);

  Comment user(User? user);

  Comment post(String? post);

  Comment likesCount(int? likesCount);

  Comment repliesCount(int? repliesCount);

  Comment isLiked(bool? isLiked);

  Comment allowLikes(bool? allowLikes);

  Comment allowReplies(bool? allowReplies);

  Comment visibility(String? visibility);

  Comment status(String? status);

  Comment createdAt(DateTime? createdAt);

  Comment updatedAt(DateTime? updatedAt);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Comment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Comment(...).copyWith(id: 12, name: "My name")
  /// ````
  Comment call({
    String? id,
    String? type,
    String? comment,
    User? user,
    String? post,
    int? likesCount,
    int? repliesCount,
    bool? isLiked,
    bool? allowLikes,
    bool? allowReplies,
    String? visibility,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfComment.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfComment.copyWith.fieldName(...)`
class _$CommentCWProxyImpl implements _$CommentCWProxy {
  const _$CommentCWProxyImpl(this._value);

  final Comment _value;

  @override
  Comment id(String? id) => this(id: id);

  @override
  Comment type(String? type) => this(type: type);

  @override
  Comment comment(String? comment) => this(comment: comment);

  @override
  Comment user(User? user) => this(user: user);

  @override
  Comment post(String? post) => this(post: post);

  @override
  Comment likesCount(int? likesCount) => this(likesCount: likesCount);

  @override
  Comment repliesCount(int? repliesCount) => this(repliesCount: repliesCount);

  @override
  Comment isLiked(bool? isLiked) => this(isLiked: isLiked);

  @override
  Comment allowLikes(bool? allowLikes) => this(allowLikes: allowLikes);

  @override
  Comment allowReplies(bool? allowReplies) => this(allowReplies: allowReplies);

  @override
  Comment visibility(String? visibility) => this(visibility: visibility);

  @override
  Comment status(String? status) => this(status: status);

  @override
  Comment createdAt(DateTime? createdAt) => this(createdAt: createdAt);

  @override
  Comment updatedAt(DateTime? updatedAt) => this(updatedAt: updatedAt);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Comment(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Comment(...).copyWith(id: 12, name: "My name")
  /// ````
  Comment call({
    Object? id = const $CopyWithPlaceholder(),
    Object? type = const $CopyWithPlaceholder(),
    Object? comment = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
    Object? post = const $CopyWithPlaceholder(),
    Object? likesCount = const $CopyWithPlaceholder(),
    Object? repliesCount = const $CopyWithPlaceholder(),
    Object? isLiked = const $CopyWithPlaceholder(),
    Object? allowLikes = const $CopyWithPlaceholder(),
    Object? allowReplies = const $CopyWithPlaceholder(),
    Object? visibility = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? createdAt = const $CopyWithPlaceholder(),
    Object? updatedAt = const $CopyWithPlaceholder(),
  }) {
    return Comment(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      type: type == const $CopyWithPlaceholder()
          ? _value.type
          // ignore: cast_nullable_to_non_nullable
          : type as String?,
      comment: comment == const $CopyWithPlaceholder()
          ? _value.comment
          // ignore: cast_nullable_to_non_nullable
          : comment as String?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as User?,
      post: post == const $CopyWithPlaceholder()
          ? _value.post
          // ignore: cast_nullable_to_non_nullable
          : post as String?,
      likesCount: likesCount == const $CopyWithPlaceholder()
          ? _value.likesCount
          // ignore: cast_nullable_to_non_nullable
          : likesCount as int?,
      repliesCount: repliesCount == const $CopyWithPlaceholder()
          ? _value.repliesCount
          // ignore: cast_nullable_to_non_nullable
          : repliesCount as int?,
      isLiked: isLiked == const $CopyWithPlaceholder()
          ? _value.isLiked
          // ignore: cast_nullable_to_non_nullable
          : isLiked as bool?,
      allowLikes: allowLikes == const $CopyWithPlaceholder()
          ? _value.allowLikes
          // ignore: cast_nullable_to_non_nullable
          : allowLikes as bool?,
      allowReplies: allowReplies == const $CopyWithPlaceholder()
          ? _value.allowReplies
          // ignore: cast_nullable_to_non_nullable
          : allowReplies as bool?,
      visibility: visibility == const $CopyWithPlaceholder()
          ? _value.visibility
          // ignore: cast_nullable_to_non_nullable
          : visibility as String?,
      status: status == const $CopyWithPlaceholder()
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as String?,
      createdAt: createdAt == const $CopyWithPlaceholder()
          ? _value.createdAt
          // ignore: cast_nullable_to_non_nullable
          : createdAt as DateTime?,
      updatedAt: updatedAt == const $CopyWithPlaceholder()
          ? _value.updatedAt
          // ignore: cast_nullable_to_non_nullable
          : updatedAt as DateTime?,
    );
  }
}

extension $CommentCopyWith on Comment {
  /// Returns a callable class that can be used as follows: `instanceOfComment.copyWith(...)` or like so:`instanceOfComment.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$CommentCWProxy get copyWith => _$CommentCWProxyImpl(this);
}

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CommentAdapter extends TypeAdapter<Comment> {
  @override
  final int typeId = 15;

  @override
  Comment read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Comment(
      id: fields[0] as String?,
      type: fields[1] as String?,
      comment: fields[2] as String?,
      user: fields[4] as User?,
      post: fields[3] as String?,
      likesCount: fields[5] as int?,
      repliesCount: fields[6] as int?,
      isLiked: fields[7] as bool?,
      allowLikes: fields[8] as bool?,
      allowReplies: fields[9] as bool?,
      visibility: fields[10] as String?,
      status: fields[11] as String?,
      createdAt: fields[12] as DateTime?,
      updatedAt: fields[13] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Comment obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.type)
      ..writeByte(2)
      ..write(obj.comment)
      ..writeByte(3)
      ..write(obj.post)
      ..writeByte(4)
      ..write(obj.user)
      ..writeByte(5)
      ..write(obj.likesCount)
      ..writeByte(6)
      ..write(obj.repliesCount)
      ..writeByte(7)
      ..write(obj.isLiked)
      ..writeByte(8)
      ..write(obj.allowLikes)
      ..writeByte(9)
      ..write(obj.allowReplies)
      ..writeByte(10)
      ..write(obj.visibility)
      ..writeByte(11)
      ..write(obj.status)
      ..writeByte(12)
      ..write(obj.createdAt)
      ..writeByte(13)
      ..write(obj.updatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CommentAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: json['_id'] as String?,
      type: json['type'] as String?,
      comment: json['comment'] as String?,
      user: json['user'] == null
          ? null
          : User.fromJson(json['user'] as Map<String, dynamic>),
      post: json['post'] as String?,
      likesCount: json['likesCount'] as int?,
      repliesCount: json['repliesCount'] as int?,
      isLiked: json['isLiked'] as bool?,
      allowLikes: json['allowLikes'] as bool?,
      allowReplies: json['allowReplies'] as bool?,
      visibility: json['visibility'] as String?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'comment': instance.comment,
      'post': instance.post,
      'user': instance.user,
      'likesCount': instance.likesCount,
      'repliesCount': instance.repliesCount,
      'isLiked': instance.isLiked,
      'allowLikes': instance.allowLikes,
      'allowReplies': instance.allowReplies,
      'visibility': instance.visibility,
      'status': instance.status,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

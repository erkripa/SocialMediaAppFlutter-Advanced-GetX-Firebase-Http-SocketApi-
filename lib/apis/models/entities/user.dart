import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:social_media_app/apis/models/entities/media_file.dart';
import 'package:social_media_app/constants/hive_type_id.dart';

part 'user.g.dart';

@CopyWith()
@JsonSerializable()
@HiveType(typeId: HiveTypeId.user)
class User {
  User({
    required this.id,
    required this.fname,
    required this.lname,
    required this.email,
    required this.uname,
    this.profession,
    this.avatar,
    required this.isPrivate,
    required this.followingStatus,
    required this.accountStatus,
    required this.isVerified,
    this.verifiedCategory,
    required this.isBlockedByYou,
    required this.isBlockedByUser,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @JsonKey(name: '_id')
  @HiveField(0)
  final String id;

  @JsonKey(name: 'fname')
  @HiveField(1)
  final String fname;

  @JsonKey(name: 'lname')
  @HiveField(2)
  final String lname;

  @JsonKey(name: 'email')
  @HiveField(3)
  final String email;

  @JsonKey(name: 'uname')
  @HiveField(4)
  final String uname;

  @JsonKey(name: 'avatar')
  @HiveField(5)
  final MediaFile? avatar;

  @JsonKey(name: 'followingStatus')
  @HiveField(6)
  String followingStatus;

  @JsonKey(name: 'accountStatus')
  @HiveField(7)
  final String accountStatus;

  @JsonKey(name: 'profession')
  @HiveField(8)
  final String? profession;

  @JsonKey(name: 'isPrivate')
  @HiveField(9)
  bool isPrivate;

  @JsonKey(name: 'isVerified')
  @HiveField(10)
  bool isVerified;

  @JsonKey(name: 'verifiedCategory')
  @HiveField(11)
  String? verifiedCategory;

  @JsonKey(name: 'isBlockedByYou')
  @HiveField(12)
  final bool isBlockedByYou;

  @JsonKey(name: 'isBlockedByUser')
  @HiveField(13)
  final bool isBlockedByUser;

  @JsonKey(name: 'createdAt')
  @HiveField(14)
  final DateTime createdAt;

  @JsonKey(name: 'updatedAt')
  @HiveField(15)
  final DateTime updatedAt;
}

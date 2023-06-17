// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProfileResponseModel _$ProfileResponseModelFromJson(Map<String, dynamic> json) {
  return _ProfileResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ProfileResponseModel {
  int get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  String get avatar => throw _privateConstructorUsedError;
  DateTime get creationAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProfileResponseModelCopyWith<ProfileResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProfileResponseModelCopyWith<$Res> {
  factory $ProfileResponseModelCopyWith(ProfileResponseModel value,
          $Res Function(ProfileResponseModel) then) =
      _$ProfileResponseModelCopyWithImpl<$Res, ProfileResponseModel>;
  @useResult
  $Res call(
      {int id,
      String email,
      String password,
      String name,
      String role,
      String avatar,
      DateTime creationAt,
      DateTime updatedAt});
}

/// @nodoc
class _$ProfileResponseModelCopyWithImpl<$Res,
        $Val extends ProfileResponseModel>
    implements $ProfileResponseModelCopyWith<$Res> {
  _$ProfileResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? password = null,
    Object? name = null,
    Object? role = null,
    Object? avatar = null,
    Object? creationAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      creationAt: null == creationAt
          ? _value.creationAt
          : creationAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProfileResponseModelCopyWith<$Res>
    implements $ProfileResponseModelCopyWith<$Res> {
  factory _$$_ProfileResponseModelCopyWith(_$_ProfileResponseModel value,
          $Res Function(_$_ProfileResponseModel) then) =
      __$$_ProfileResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String email,
      String password,
      String name,
      String role,
      String avatar,
      DateTime creationAt,
      DateTime updatedAt});
}

/// @nodoc
class __$$_ProfileResponseModelCopyWithImpl<$Res>
    extends _$ProfileResponseModelCopyWithImpl<$Res, _$_ProfileResponseModel>
    implements _$$_ProfileResponseModelCopyWith<$Res> {
  __$$_ProfileResponseModelCopyWithImpl(_$_ProfileResponseModel _value,
      $Res Function(_$_ProfileResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? password = null,
    Object? name = null,
    Object? role = null,
    Object? avatar = null,
    Object? creationAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$_ProfileResponseModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: null == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String,
      creationAt: null == creationAt
          ? _value.creationAt
          : creationAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProfileResponseModel implements _ProfileResponseModel {
  const _$_ProfileResponseModel(
      {required this.id,
      required this.email,
      required this.password,
      required this.name,
      required this.role,
      required this.avatar,
      required this.creationAt,
      required this.updatedAt});

  factory _$_ProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_ProfileResponseModelFromJson(json);

  @override
  final int id;
  @override
  final String email;
  @override
  final String password;
  @override
  final String name;
  @override
  final String role;
  @override
  final String avatar;
  @override
  final DateTime creationAt;
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ProfileResponseModel(id: $id, email: $email, password: $password, name: $name, role: $role, avatar: $avatar, creationAt: $creationAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProfileResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.creationAt, creationAt) ||
                other.creationAt == creationAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, email, password, name, role,
      avatar, creationAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProfileResponseModelCopyWith<_$_ProfileResponseModel> get copyWith =>
      __$$_ProfileResponseModelCopyWithImpl<_$_ProfileResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProfileResponseModelToJson(
      this,
    );
  }
}

abstract class _ProfileResponseModel implements ProfileResponseModel {
  const factory _ProfileResponseModel(
      {required final int id,
      required final String email,
      required final String password,
      required final String name,
      required final String role,
      required final String avatar,
      required final DateTime creationAt,
      required final DateTime updatedAt}) = _$_ProfileResponseModel;

  factory _ProfileResponseModel.fromJson(Map<String, dynamic> json) =
      _$_ProfileResponseModel.fromJson;

  @override
  int get id;
  @override
  String get email;
  @override
  String get password;
  @override
  String get name;
  @override
  String get role;
  @override
  String get avatar;
  @override
  DateTime get creationAt;
  @override
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$_ProfileResponseModelCopyWith<_$_ProfileResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

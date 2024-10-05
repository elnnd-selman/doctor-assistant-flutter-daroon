// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 1;

  @override
  UserModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserModel(
      user: fields[0] as User?,
      token: fields[1] as String?,
      success: fields[2] as bool?,
      message: fields[3] as String?,
      status: fields[4] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.token)
      ..writeByte(2)
      ..write(obj.success)
      ..writeByte(3)
      ..write(obj.message)
      ..writeByte(4)
      ..write(obj.status);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 2;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      id: fields[0] as String?,
      firstName: fields[1] as String?,
      firstNameKu: fields[2] as String?,
      firstNameEn: fields[3] as String?,
      firstNameAr: fields[4] as String?,
      username: fields[5] as String?,
      email: fields[6] as String?,
      isEmailVerified: fields[7] as bool?,
      gender: fields[8] as String?,
      biographyKu: fields[9] as String?,
      biographyAr: fields[10] as String?,
      biographyEn: fields[11] as String?,
      isActive: fields[12] as bool?,
      phone: fields[13] as Phone?,
      level: fields[14] as String?,
      speciality: fields[15] as String?,
      education: (fields[16] as List).cast<String>(),
      lastNameKu: fields[17] as String?,
      lastNameAr: fields[18] as String?,
      lastNameEn: fields[19] as String?,
      experienceByYear: fields[20] as int?,
      typeOfUser: fields[21] as String?,
      languages: (fields[22] as List).cast<String>(),
      appLang: fields[23] as String?,
      isThirdParty: fields[24] as bool?,
      usePictureAsLink: fields[25] as bool?,
      dateOfBirth: fields[26] as DateTime?,
      createdAt: fields[27] as DateTime?,
      updatedAt: fields[28] as DateTime?,
      v: fields[29] as int?,
      sessionToken: fields[30] as String?,
      profilePicture: fields[31] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(32)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.firstNameKu)
      ..writeByte(3)
      ..write(obj.firstNameEn)
      ..writeByte(4)
      ..write(obj.firstNameAr)
      ..writeByte(5)
      ..write(obj.username)
      ..writeByte(6)
      ..write(obj.email)
      ..writeByte(7)
      ..write(obj.isEmailVerified)
      ..writeByte(8)
      ..write(obj.gender)
      ..writeByte(9)
      ..write(obj.biographyKu)
      ..writeByte(10)
      ..write(obj.biographyAr)
      ..writeByte(11)
      ..write(obj.biographyEn)
      ..writeByte(12)
      ..write(obj.isActive)
      ..writeByte(13)
      ..write(obj.phone)
      ..writeByte(14)
      ..write(obj.level)
      ..writeByte(15)
      ..write(obj.speciality)
      ..writeByte(16)
      ..write(obj.education)
      ..writeByte(17)
      ..write(obj.lastNameKu)
      ..writeByte(18)
      ..write(obj.lastNameAr)
      ..writeByte(19)
      ..write(obj.lastNameEn)
      ..writeByte(20)
      ..write(obj.experienceByYear)
      ..writeByte(21)
      ..write(obj.typeOfUser)
      ..writeByte(22)
      ..write(obj.languages)
      ..writeByte(23)
      ..write(obj.appLang)
      ..writeByte(24)
      ..write(obj.isThirdParty)
      ..writeByte(25)
      ..write(obj.usePictureAsLink)
      ..writeByte(26)
      ..write(obj.dateOfBirth)
      ..writeByte(27)
      ..write(obj.createdAt)
      ..writeByte(28)
      ..write(obj.updatedAt)
      ..writeByte(29)
      ..write(obj.v)
      ..writeByte(30)
      ..write(obj.sessionToken)
      ..writeByte(31)
      ..write(obj.profilePicture);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PhoneAdapter extends TypeAdapter<Phone> {
  @override
  final int typeId = 3;

  @override
  Phone read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Phone(
      number: fields[0] as String?,
      isVerified: fields[1] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, Phone obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.number)
      ..writeByte(1)
      ..write(obj.isVerified);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PhoneAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

import 'dart:convert';

class UserFields {
  static final String id = 'id';
  static final String password = 'password';
  static final String name = 'name';
  static final String phoneNumber = 'phoneNumber';
  static final String isAbsent='isAbsent';


  static List<String> getFields() => [id, password, name, phoneNumber,isAbsent];
}

class User{
  final int id;
  final String password;
  final String name;
  final String phoneNumber;
  final bool isAbsent;

  const User({
    required this.id,
    required this.password,
    required this.name,
    required this.phoneNumber,
    required this.isAbsent,
  });

  User copy({
    int ? id,
    String ? password,
    String ? name,
    String ? phoneNumber,
    bool ? isAbsent,
  }) => 
      User(
        id: id ?? this.id,
        password: password ?? this.password,
        name: name ?? this.name,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        isAbsent: isAbsent ?? this.isAbsent,
      );

  static User fromJson(Map<String, dynamic> json) => User(
    id: jsonDecode(json[UserFields.id]),
    password: json[UserFields.password],
    name: json[UserFields.name],
    phoneNumber: jsonDecode(json[UserFields.phoneNumber]),
    isAbsent: jsonDecode(json[UserFields.isAbsent]),
  );

  Map<String, dynamic> toJson() => {
    UserFields.id:id,
    UserFields.password:password,
    UserFields.name:name,
    UserFields.phoneNumber:phoneNumber,
    UserFields.isAbsent: isAbsent,
  };
}
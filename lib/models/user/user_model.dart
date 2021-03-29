import 'package:floor/floor.dart';

@entity
class UserModel {
  @PrimaryKey(autoGenerate: true)
  int id;
  String phone;
  String password;
  String address;
  String firstName;
  String lastName;
  String createdAt;
  String updatedAt;
  bool isVerified;
  int roleId;
  String profileImage;
  int branchId;
  String userPermission;
  String otpCode;
  String employeeNumber;
  String managerNumber;

  UserModel();

  Map<String, dynamic> toMap() => {
        'id': id,
        'userPermission': userPermission,
        'managerNumber': managerNumber,
        'otpCode': otpCode,
        'phone': phone,
        'password': password,
        'employeeNumber': employeeNumber,
        'address': address,
        'firstName': firstName,
        'lastName': lastName,
        'createdAt': createdAt,
        'updatedAt': updatedAt,
        'isVerified': isVerified,
        'roleId': roleId,
        'profileImage': profileImage,
        'branchId': branchId,
        'user_permission': userPermission,
      };

  UserModel.fromMap(Map<String, dynamic> json)
      : id = json['id'],
        otpCode = json['otpCode'],
        employeeNumber = json['employeeNumber'],
        managerNumber = json['managerNumber'],
        userPermission = json['userPermission'],
        phone = json['phone'],
        password = json['password'],
        address = json['address'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'],
        isVerified = json['isVerified'],
        roleId = json['roleId'],
        profileImage = json['profileImage'],
        branchId = json['branchId'];
}

import 'dart:io';

import 'package:dio/dio.dart';

class EditProfileParams {
  String? name;
  String? address;
  String? phone;
  File? image;

  EditProfileParams({this.name, this.address, this.phone});

  factory EditProfileParams.fromJson(Map<String, dynamic> json) {
    return EditProfileParams(
      name: json['name'] as String?,
      address: json['address'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'address': address,
    'phone': phone,
  };

  FormData toFormData() {
    return FormData.fromMap({
      if (name != null) 'name': name,
      if (address != null) 'address': address,
      if (phone != null) 'phone': phone,
      if (image != null)
        'image': MultipartFile.fromFileSync(
          image!.path,
          filename: image!.path.split('/').last,
        ),
    });
  }
}

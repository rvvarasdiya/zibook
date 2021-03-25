import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/main.dart';

class ContactUsReq {
  String name;
  String countryCode;
  String phone;
  String email; 
  String message;

  ContactUsReq(
      {this.name, this.countryCode, this.phone, this.email, this.message});

  ContactUsReq.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    countryCode = json['countryCode'];
    phone = json['phone'];
    email = json['email'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['countryCode'] = this.countryCode;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['message'] = this.message;
    return data;
  }
}

class ContactUsRes extends BaseApiResp {
  Data data;

  ContactUsRes({this.data});

  ContactUsRes.fromJson(Map<String, dynamic> json) : super.fromJson(json){
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String sId;
  bool isDeleted;
  bool isActive;
  String name;
  String countryCode;
  String phone;
  String email;
  String message;
  String createdAt;
  String updatedAt;
  int iV;

  Data(
      {this.sId,
      this.isDeleted,
      this.isActive,
      this.name,
      this.countryCode,
      this.phone,
      this.email,
      this.message,
      this.createdAt,
      this.updatedAt,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    name = json['name'];
    countryCode = json['countryCode'];
    phone = json['phone'];
    email = json['email'];
    message = json['message'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['name'] = this.name;
    data['countryCode'] = this.countryCode;
    data['phone'] = this.phone;
    data['email'] = this.email;
    data['message'] = this.message;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }
}

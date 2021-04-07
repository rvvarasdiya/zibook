import 'package:zaviato/app/base/BaseApiResp.dart';

class AddFavoriteRes extends BaseApiResp {
  Data data;

  AddFavoriteRes({this.data});

  AddFavoriteRes.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  ResetPassword resetPassword;
  ResetPassword mobileVerification;

  bool isConnected;
  int wrongLoginAttempts;

  List<String> favouriteBusinesses;
  bool isActive;
  bool isDeleted;
  String sId;
  int type;
  String firstName;
  String lastName;
  int gender;
  String dob;
  String password;
  String image;
  String name;

  List<Emails> emails;
  List<Mobiles> mobiles;
  String code;

  String createdAt;
  String updatedAt;
  int iV;
  String loginToken;
  String refreshToken;
  String updatedBy;

  Data({
    this.resetPassword,
    this.mobileVerification,
    this.isConnected,
    this.wrongLoginAttempts,
    this.favouriteBusinesses,
    this.isActive,
    this.isDeleted,
    this.sId,
    this.type,
    this.firstName,
    this.lastName,
    this.gender,
    this.dob,
    this.password,
    this.image,
    this.name,
    this.emails,
    this.mobiles,
    this.code,
    this.createdAt,
    this.updatedAt,
    this.iV,
    this.loginToken,
    this.refreshToken,
    this.updatedBy,
  });

  Data.fromJson(Map<String, dynamic> json) {
    resetPassword = json['resetPassword'] != null
        ? new ResetPassword.fromJson(json['resetPassword'])
        : null;
    mobileVerification = json['mobileVerification'] != null
        ? new ResetPassword.fromJson(json['mobileVerification'])
        : null;

    isConnected = json['isConnected'];
    wrongLoginAttempts = json['wrongLoginAttempts'];

    favouriteBusinesses = json['favouriteBusinesses'].cast<String>();
    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    type = json['type'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    gender = json['gender'];
    dob = json['dob'];
    password = json['password'];
    image = json['image'];
    name = json['name'];

    if (json['emails'] != null) {
      emails = new List<Emails>();
      json['emails'].forEach((v) {
        emails.add(new Emails.fromJson(v));
      });
    }
    if (json['mobiles'] != null) {
      mobiles = new List<Mobiles>();
      json['mobiles'].forEach((v) {
        mobiles.add(new Mobiles.fromJson(v));
      });
    }
    code = json['code'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    loginToken = json['loginToken'];
    refreshToken = json['refreshToken'];
    updatedBy = json['updatedBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.resetPassword != null) {
      data['resetPassword'] = this.resetPassword.toJson();
    }
    if (this.mobileVerification != null) {
      data['mobileVerification'] = this.mobileVerification.toJson();
    }

    data['isConnected'] = this.isConnected;
    data['wrongLoginAttempts'] = this.wrongLoginAttempts;

    data['favouriteBusinesses'] = this.favouriteBusinesses;
    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['type'] = this.type;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['password'] = this.password;
    data['image'] = this.image;
    data['name'] = this.name;

    if (this.emails != null) {
      data['emails'] = this.emails.map((v) => v.toJson()).toList();
    }
    if (this.mobiles != null) {
      data['mobiles'] = this.mobiles.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;

    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['loginToken'] = this.loginToken;
    data['refreshToken'] = this.refreshToken;
    data['updatedBy'] = this.updatedBy;

    return data;
  }
}

class ResetPassword {
  String code;
  String expireTime;

  ResetPassword({this.code, this.expireTime});

  ResetPassword.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    expireTime = json['expireTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['expireTime'] = this.expireTime;
    return data;
  }
}

class Emails {
  String sId;
  String email;
  bool isPrimary;
  bool isVerified;

  Emails({this.sId, this.email, this.isPrimary, this.isVerified});

  Emails.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    email = json['email'];
    isPrimary = json['isPrimary'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['isPrimary'] = this.isPrimary;
    data['isVerified'] = this.isVerified;
    return data;
  }
}

class Mobiles {
  String sId;
  String countryCode;
  String mobile;
  bool isPrimary;
  bool isVerified;

  Mobiles(
      {this.sId,
      this.countryCode,
      this.mobile,
      this.isPrimary,
      this.isVerified});

  Mobiles.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    isPrimary = json['isPrimary'];
    isVerified = json['isVerified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['countryCode'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['isPrimary'] = this.isPrimary;
    data['isVerified'] = this.isVerified;
    return data;
  }
}

import 'package:zaviato/app/base/BaseApiResp.dart';
import 'package:zaviato/app/utils/string_utils.dart';

class MyBusinessByCategoryRes extends BaseApiResp {
  Data data;

  MyBusinessByCategoryRes({this.data});

  MyBusinessByCategoryRes.fromJson(Map<String, dynamic> json)
      : super.fromJson(json) {
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
  List<Business> list;
  int count;

  Data({this.list, this.count});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = new List<Business>();
      json['list'].forEach((v) {
        list.add(new Business.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list.map((v) => v.toJson()).toList();
    }
    data['count'] = this.count;
    return data;
  }
}

class Business {
  List<Categories> categories;

  bool isActive;
  bool isDeleted;
  String sId;
  String name;
  String category;
  String addedBy;
  int addedByType;
  Categories owner;
  List<Mobiles> mobiles;
  List<Emails> emails;
  List<Addresses> addresses;
  String code;
  int status;

  String createdAt;
  String updatedAt;
  int iV;

  int averageRating;

  Business(
      {this.categories,
      this.isActive,
      this.isDeleted,
      this.sId,
      this.name,
      this.category,
      this.addedBy,
      this.addedByType,
      this.owner,
      this.mobiles,
      this.emails,
      this.addresses,
      this.code,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.averageRating});

  Business.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = new List<Categories>();
      json['categories'].forEach((v) {
        categories.add(new Categories.fromJson(v));
      });
    }

    isActive = json['isActive'];
    isDeleted = json['isDeleted'];
    sId = json['_id'];
    name = json['name'];
    category = json['category'];
    addedBy = json['addedBy'];
    addedByType = json['addedByType'];
    owner =
        json['owner'] != null ? new Categories.fromJson(json['owner']) : null;
    if (json['mobiles'] != null) {
      mobiles = new List<Mobiles>();
      json['mobiles'].forEach((v) {
        mobiles.add(new Mobiles.fromJson(v));
      });
    }
    if (json['emails'] != null) {
      emails = new List<Emails>();
      json['emails'].forEach((v) {
        emails.add(new Emails.fromJson(v));
      });
    }
    if (json['addresses'] != null) {
      addresses = new List<Addresses>();
      json['addresses'].forEach((v) {
        addresses.add(new Addresses.fromJson(v));
      });
    }
    code = json['code'];
    status = json['status'];

    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    averageRating = json["averageRating"] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.map((v) => v.toJson()).toList();
    }

    data['isActive'] = this.isActive;
    data['isDeleted'] = this.isDeleted;
    data['_id'] = this.sId;
    data['name'] = this.name;
    data['category'] = this.category;
    data['addedBy'] = this.addedBy;
    data['addedByType'] = this.addedByType;
    if (this.owner != null) {
      data['owner'] = this.owner.toJson();
    }
    if (this.mobiles != null) {
      data['mobiles'] = this.mobiles.map((v) => v.toJson()).toList();
    }
    if (this.emails != null) {
      data['emails'] = this.emails.map((v) => v.toJson()).toList();
    }
    if (this.addresses != null) {
      data['addresses'] = this.addresses.map((v) => v.toJson()).toList();
    }
    data['code'] = this.code;
    data['status'] = this.status;

    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    return data;
  }

  getMobileName(Business businessModel) {
    String mobileNumber = "";

    for (var mobile in businessModel.mobiles) {
      if (mobile.isPrimary) {
        if (!isNullEmptyOrFalse(mobile.mobile)) {
          mobileNumber = mobile.mobile;
          break;
        }
      }
    }
    return mobileNumber;
  }
}

class Categories {
  String sId;
  String name;

  Categories({this.sId, this.name});

  Categories.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

class Mobiles {
  bool isPrimary;
  String sId;
  String countryCode;
  String mobile;
  String ownerName;

  Mobiles(
      {this.isPrimary,
      this.sId,
      this.countryCode,
      this.mobile,
      this.ownerName});

  Mobiles.fromJson(Map<String, dynamic> json) {
    isPrimary = json['isPrimary'];
    sId = json['_id'];
    countryCode = json['countryCode'];
    mobile = json['mobile'];
    ownerName = json['ownerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPrimary'] = this.isPrimary;
    data['_id'] = this.sId;
    data['countryCode'] = this.countryCode;
    data['mobile'] = this.mobile;
    data['ownerName'] = this.ownerName;
    return data;
  }
}

class Emails {
  bool isPrimary;
  String sId;
  String email;
  String ownerName;

  Emails({this.isPrimary, this.sId, this.email, this.ownerName});

  Emails.fromJson(Map<String, dynamic> json) {
    isPrimary = json['isPrimary'];
    sId = json['_id'];
    email = json['email'];
    ownerName = json['ownerName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isPrimary'] = this.isPrimary;
    data['_id'] = this.sId;
    data['email'] = this.email;
    data['ownerName'] = this.ownerName;
    return data;
  }
}

class Addresses {
  String sId;
  String postalCode;
  String line1;
  String line2;
  String landmark;

  Addresses({this.sId, this.postalCode, this.line1, this.line2, this.landmark});

  Addresses.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    postalCode = json['postalCode'];
    line1 = json['line1'];
    line2 = json['line2'];
    landmark = json['landmark'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['postalCode'] = this.postalCode;
    data['line1'] = this.line1;
    data['line2'] = this.line2;
    data['landmark'] = this.landmark;
    return data;
  }
}

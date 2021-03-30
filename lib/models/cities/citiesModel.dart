import 'package:zaviato/app/base/BaseApiResp.dart';

class Cities extends BaseApiResp {
  List<Data> data;

  Cities({this.data});

  Cities.fromJson(Map<String, dynamic> json) : super.fromJson(json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  bool isDeleted;
  bool isActive;
  String sId;
  String createdAt;
  String updatedAt;
  String name;
  String normalizeName;
  String remark;
  String stateId;
  String countryId;
  int iV;

  Data(
      {this.isDeleted,
      this.isActive,
      this.sId,
      this.createdAt,
      this.updatedAt,
      this.name,
      this.normalizeName,
      this.remark,
      this.stateId,
      this.countryId,
      this.iV});

  Data.fromJson(Map<String, dynamic> json) {
    isDeleted = json['isDeleted'];
    isActive = json['isActive'];
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    name = json['name'];
    normalizeName = json['normalizeName'];
    remark = json['Remark'];
    stateId = json['stateId'];
    countryId = json['countryId'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isDeleted'] = this.isDeleted;
    data['isActive'] = this.isActive;
    data['_id'] = this.sId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['name'] = this.name;
    data['normalizeName'] = this.normalizeName;
    data['Remark'] = this.remark;
    data['stateId'] = this.stateId;
    data['countryId'] = this.countryId;
    data['__v'] = this.iV;
    return data;
  }
}

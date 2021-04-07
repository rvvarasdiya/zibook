class ChangePassReq {
  String username;
  String currentPassword;
  String newPassword;

  ChangePassReq({this.username, this.currentPassword, this.newPassword});

  ChangePassReq.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    currentPassword = json['currentPassword'];
    newPassword = json['newPassword'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['currentPassword'] = this.currentPassword;
    data['newPassword'] = this.newPassword;
    return data;
  }
}

class LogoutReq {
  int type;
  String username;
  String password;

  LogoutReq({this.type, this.username, this.password});

  LogoutReq.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['username'] = this.username;
    data['password'] = this.password;
    return data;
  }
}

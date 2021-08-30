class RegisterResponse {
  bool success;
  bool register;
  String userToken;
  String message;

  RegisterResponse({this.success, this.register, this.userToken, this.message});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    register = json['register'];
    userToken = json['user_token'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['register'] = this.register;
    data['user_token'] = this.userToken;
    data['message'] = this.message;
    return data;
  }
}

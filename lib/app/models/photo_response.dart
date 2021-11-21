class PhotoResponse {
  bool success;
  String message;
  String newPhoto;

  PhotoResponse({this.success, this.message, this.newPhoto});

  PhotoResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    newPhoto = json['new_photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['new_photo'] = this.newPhoto;
    return data;
  }
}

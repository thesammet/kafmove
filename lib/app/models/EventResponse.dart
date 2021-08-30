class EventResponse {
  bool success;
  String message;
  List<Events> events;

  EventResponse({this.success, this.message, this.events});

  EventResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    if (json['events'] != null) {
      events = new List<Events>();
      json['events'].forEach((v) {
        events.add(new Events.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.events != null) {
      data['events'] = this.events.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Events {
  String id;
  String place;
  String address;
  String placePhoto;
  String title;
  String description;
  String photo;
  String location;
  String city;
  String date;
  int friends;

  Events(
      {this.id,
      this.place,
      this.address,
      this.placePhoto,
      this.title,
      this.description,
      this.photo,
      this.location,
      this.city,
      this.date,
      this.friends});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    place = json['place'];
    address = json['address'];
    placePhoto = json['place_photo'];
    title = json['title'];
    description = json['description'];
    photo = json['photo'];
    location = json['location'];
    city = json['city'];
    date = json['date'];
    friends = json['friends'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['place'] = this.place;
    data['address'] = this.address;
    data['place_photo'] = this.placePhoto;
    data['title'] = this.title;
    data['description'] = this.description;
    data['photo'] = this.photo;
    data['location'] = this.location;
    data['city'] = this.city;
    data['date'] = this.date;
    data['friends'] = this.friends;
    return data;
  }
}

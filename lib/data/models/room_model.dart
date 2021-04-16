// To parse this JSON data, do
//
//     final room = roomFromJson(jsonString);

import 'dart:convert';

Room roomFromJson(String str) => Room.fromJson(json.decode(str));

String roomToJson(Room data) => json.encode(data.toJson());

class Room {
    Room({
        this.value,
        this.name,
        this.type,
        this.status,
        this.credits,
        this.guest,
        this.checkin,
        this.checkout,
        this.time
    });

    String value;
    String name;
    String type;
    String status;
    String credits;
    String guest;
    String checkin;
    String checkout;
    String time;

    factory Room.fromJson(Map<String, dynamic> json) => Room(
        value: json["value"],
        name: json["name"],
        type: json["type"],
        status: json["status"],
        credits: json["credits"],
        guest: json["guest"],
        checkin: json["Checkin"],
        checkout: json["Checkout"],
        time: json["time"]
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "name": name,
        "type": type,
        "status": status,
        "credits": credits,
        "guest": guest,
        "Checkin": checkin,
        "Checkout": checkout,
        "time":time
    };
}

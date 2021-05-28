class TickEvent {
  bool first;
  String payload;

  TickEvent({required this.first, required this.payload});

  TickEvent.fromJson(Map<String, dynamic> json)
      : first = json['first'],
        payload = json['payload'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first'] = this.first;
    data['payload'] = this.payload;
    return data;
  }
}

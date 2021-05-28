class ShutdownEvent {
  String change;

  ShutdownEvent({required this.change});

  ShutdownEvent.fromJson(Map<String, dynamic> json) : change = json['change'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['change'] = this.change;
    return data;
  }
}

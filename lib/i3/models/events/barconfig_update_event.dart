class BarConfigEvent {
  String config;

  BarConfigEvent({required this.config});

  BarConfigEvent.fromJson(Map<String, dynamic> json)
      : config = json['config'].toString();

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['config'] = this.config;
    return data;
  }
}

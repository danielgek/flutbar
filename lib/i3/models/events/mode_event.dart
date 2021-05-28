class ModeEvent {
  String? change;
  bool? pangoMarkup;

  ModeEvent({required this.change, required this.pangoMarkup});

  ModeEvent.fromJson(Map<String, dynamic> json)
      : change = json['change'],
        pangoMarkup = json['pango_markup'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['change'] = this.change;
    data['pango_markup'] = this.pangoMarkup;
    return data;
  }
}

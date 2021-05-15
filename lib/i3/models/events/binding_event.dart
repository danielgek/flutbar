import 'package:flutbar/i3/models/common/binding.dart';

class BindingEvent {
  String change;
  Binding binding;

  BindingEvent({this.change, this.binding});

  BindingEvent.fromJson(Map<String, dynamic> json) {
    change = json['change'];
    binding =
        json['binding'] != null ? new Binding.fromJson(json['binding']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['change'] = this.change;
    if (this.binding != null) {
      data['binding'] = this.binding.toJson();
    }
    return data;
  }
}

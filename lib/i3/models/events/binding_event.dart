import 'package:flutbar/i3/models/common/binding.dart';

class BindingEvent {
  String change;
  Binding binding;

  BindingEvent({required this.change, required this.binding});

  BindingEvent.fromJson(Map<String, dynamic> json)
      : change = json['change'],
        binding = Binding.fromJson(json['binding']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['change'] = this.change;
    if (this.binding != null) {
      data['binding'] = this.binding.toJson();
    }
    return data;
  }
}

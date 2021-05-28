class Binding {
  String command;
  List<String> eventStateMask;
  int inputCode;
  String symbol;
  String inputType;

  Binding(
      {required this.command,
      required this.eventStateMask,
      required this.inputCode,
      required this.symbol,
      required this.inputType});

  Binding.fromJson(Map<String, dynamic> json)
      : command = json['command'],
        eventStateMask = json['event_state_mask'].cast<String>(),
        inputCode = json['input_code'],
        symbol = json['symbol'],
        inputType = json['input_type'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['command'] = this.command;
    data['event_state_mask'] = this.eventStateMask;
    data['input_code'] = this.inputCode;
    data['symbol'] = this.symbol;
    data['input_type'] = this.inputType;
    return data;
  }
}

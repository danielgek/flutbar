class WindowProperties {
  String cssClass;
  String instance;
  String windowRole;
  String title;
  Null transientFor;

  WindowProperties(
      {this.cssClass,
      this.instance,
      this.windowRole,
      this.title,
      this.transientFor});

  WindowProperties.fromJson(Map<String, dynamic> json) {
    cssClass = json['class'];
    instance = json['instance'];
    windowRole = json['window_role'];
    title = json['title'];
    transientFor = json['transient_for'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['class'] = this.cssClass;
    data['instance'] = this.instance;
    data['window_role'] = this.windowRole;
    data['title'] = this.title;
    data['transient_for'] = this.transientFor;
    return data;
  }
}

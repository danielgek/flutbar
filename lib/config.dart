class Config {
  int height;

  Config({required this.height,});

  Config.fromJson(Map<String, dynamic> json)
      : height = json['height'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    
    return data;
  }
}

class Rect {
  int x;
  int y;
  int width;
  int height;

  Rect(
      {required this.x,
      required this.y,
      required this.width,
      required this.height});

  Rect.fromJson(Map<String, dynamic> json)
      : x = json['x'],
        y = json['y'],
        width = json['width'],
        height = json['height'];

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['x'] = this.x;
    data['y'] = this.y;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}

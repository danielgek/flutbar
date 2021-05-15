class Gaps {
  int inner;
  int outer;
  int top;
  int right;
  int bottom;
  int left;

  Gaps({this.inner, this.outer, this.top, this.right, this.bottom, this.left});

  Gaps.fromJson(Map<String, dynamic> json) {
    inner = json['inner'];
    outer = json['outer'];
    top = json['top'];
    right = json['right'];
    bottom = json['bottom'];
    left = json['left'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['inner'] = this.inner;
    data['outer'] = this.outer;
    data['top'] = this.top;
    data['right'] = this.right;
    data['bottom'] = this.bottom;
    data['left'] = this.left;
    return data;
  }
}

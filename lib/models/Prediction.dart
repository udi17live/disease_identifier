class Prediction {
  String? name;
  double? accuracy;

  Prediction({this.name, this.accuracy});

  Prediction.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    accuracy = json['accuracy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['accuracy'] = this.accuracy;

    return data;
  }
}

class Expenses {
  String? id;
  String? note;
  DateTime? date;
  double? amount;
  int? categoryId;
  String? categoryName;
  String? categoryType;
  String? place;
  String? placeLat;
  String? placeLng;
  Expenses(
      {this.id,
      this.note,
      this.date,
      this.amount,
      this.categoryId,
      this.categoryName,
      this.categoryType,
      this.place,
      this.placeLat,
      this.placeLng});
  Expenses.fromJson(Map<String, dynamic> json, {String? id}) {
    id = id;
    note = json["note"];
    if (json['date'] != null) {
      date = DateTime.fromMicrosecondsSinceEpoch(int.parse(json["date"]));
    }
    amount = json["amount"];
    categoryId = json["category_id"];
    categoryName = json["category_name"];
    categoryType = json["category_type"];
    place = json['place'];
    placeLat = json['place_lat'];
    placeLng = json['place_lng'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['amount'] = amount;
    data['note'] = note;
    if (date != null) {
      data['date'] = date!.microsecondsSinceEpoch.toString();
    }
    data['category_id'] = categoryId;
    data['category_name'] = categoryName;
    data['category_type'] = categoryType;
    data['place'] = place;
    data['place_lat'] = placeLat;
    data['place_lng'] = placeLng;
    return data;
  }
}

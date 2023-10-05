class Category {
  int? id;
  String? title;
  int? parenpId;
  bool? selected;
  String? svgUrl;
  String? type;
  Category(
      {this.id,
      this.title,
      this.parenpId,
      this.selected,
      this.svgUrl,
      this.type});
  Category.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    parenpId = json["parenpId"];
  }

  Category copyOf() {
    var data = Category();
    data.id = id;
    data.title = title;
    data.parenpId = parenpId;
    data.type = type;
    selected = false;
    return data;
  }

  static List<Category> group() {
    return [
      Category(
        id: -1,
        title: 'Chi tiêu hàng tháng',
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: -2,
        title: 'Chi tiêu cần thiết',
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: -3,
        title: 'Vui - chơi',
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: -4,
        title: 'Đầu tư, Cho vay & Nợ',
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: -5,
        title: 'Khoản thu',
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: -6,
        title: 'Khác',
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: -7,
        title: 'Thêm mới',
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 1,
        title: 'Ăn uống',
        parenpId: -1,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 2,
        title: 'Di chuyển',
        parenpId: -1,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 3,
        title: 'Hoá đơn nước',
        parenpId: -1,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 4,
        title: 'Hoá đơn điện thoại',
        parenpId: -1,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 5,
        title: 'Hoá đơn điện',
        parenpId: -1,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 6,
        title: 'Hoá đơn gas',
        parenpId: -1,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 7,
        title: 'Hoá đơn TV',
        parenpId: -1,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 8,
        title: 'Hoá đơn internet',
        parenpId: -1,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 9,
        title: 'Hoá đơn tiện ích khác',
        parenpId: -1,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 10,
        title: 'Sửa & trang trí nhà',
        parenpId: -2,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 10,
        title: 'Bảo dưỡng xe',
        parenpId: -2,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 11,
        title: 'Khám sức khoẻ',
        parenpId: -2,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 12,
        title: 'Bảo hiểm',
        parenpId: -2,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 13,
        title: 'Giáo dục',
        parenpId: -2,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 14,
        title: 'Đồ gia dụng',
        parenpId: -2,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 15,
        title: 'Đồ dùng cá nhân',
        parenpId: -2,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 16,
        title: 'Vật nuôi',
        parenpId: -2,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 17,
        title: 'Dịch vụ gia đình',
        parenpId: -2,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 18,
        title: 'Các chi phí khác',
        parenpId: -2,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 19,
        title: 'Thể dục thể thao',
        parenpId: -3,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 20,
        title: 'Làm đẹp',
        parenpId: -3,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 10,
        title: 'Quà tặng & Quyên góp',
        parenpId: -3,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 21,
        title: 'Dịch vụ trực tuyến',
        parenpId: -3,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 22,
        title: 'Vui - chơi',
        parenpId: -3,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 23,
        title: 'Đầu tư',
        parenpId: -4,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 24,
        title: 'Thu nợ',
        parenpId: -4,
        svgUrl: '',
        type: '1',
      ),
      Category(
        id: 25,
        title: 'Đi vay',
        parenpId: -4,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 26,
        title: 'Cho vay',
        parenpId: -4,
        svgUrl: '',
        type: '1',
      ),
      Category(
        id: 27,
        title: 'Trả nợ',
        parenpId: -4,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 28,
        title: 'Trả lãi',
        parenpId: -4,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 29,
        title: 'Thu lãi',
        parenpId: -4,
        svgUrl: '',
        type: '1',
      ),
      Category(
        id: 30,
        title: 'Lương',
        parenpId: -5,
        svgUrl: '',
        type: '1',
      ),
      Category(
        id: 31,
        title: 'Thu nhập khác',
        parenpId: -5,
        svgUrl: '',
        type: '1',
      ),
      Category(
        id: 32,
        title: 'Tiền chuyển đi',
        parenpId: -6,
        svgUrl: '',
        type: '0',
      ),
      Category(
        id: 33,
        title: 'Tiền chuyển đến',
        parenpId: -6,
        svgUrl: '',
        type: '1',
      ),
    ];
  }
  // Category(id: -1, title: 'Chi tiêu hàng tháng', svgUrl: '', type: '0'),
  // Category(id: -2, title: 'Chi tiêu cần thiết', svgUrl: '', type: '0'),
  // Category(id: -3, title: 'Vui - chơi', svgUrl: '', type: '0'),
  // Category(id: -4, title: 'Đầu tư, Cho vay & Nợ', svgUrl: '', type: '0'),
  // Category(id: -5, title: 'Khoản thu', svgUrl: '', type: '0'),
  // Category(id: -6, title: 'Khác', svgUrl: '', type: '0'),
  // Category(id: -7, title: 'Thêm mới', svgUrl: '', type: '0'),
  // Category(id: 1, title: 'Ăn uống', parenpId: -1, svgUrl: '', type: '0'),
  // Category(id: 2, title: 'Di chuyển', parenpId: -1, svgUrl: '', type: '0'),
  // Category(id: 3, title: 'Hoá đơn nước', parenpId: -1, svgUrl: '', type: '0'),
  // Category(id: 4, title: 'Hoá đơn điện thoại', parenpId: -1, svgUrl: '', type: '0'),
  // Category(id: 5, title: 'Hoá đơn điện', parenpId: -1, svgUrl: '', type: '0'),
  // Category(id: 6, title: 'Hoá đơn gas', parenpId: -1, svgUrl: '', type: '0'),
  // Category(id: 7, title: 'Hoá đơn TV', parenpId: -1, svgUrl: '', type: '0'),
  // Category(id: 8, title: 'Hoá đơn internet', parenpId: -1, svgUrl: '', type: '0'),
  // Category(id: 9, title: 'Hoá đơn tiện ích khác', parenpId: -1, svgUrl: '', type: '0'),
  // Category(id: 10, title: 'Sửa & trang trí nhà', parenpId: -2, svgUrl: '', type: '0'),
  // Category(id: 10, title: 'Bảo dưỡng xe', parenpId: -2, svgUrl: '', type: '0'),
  // Category(id: 11, title: 'Khám sức khoẻ', parenpId: -2, svgUrl: '', type: '0'),
  // Category(id: 12, title: 'Bảo hiểm', parenpId: -2, svgUrl: '', type: '0'),
  // Category(id: 13, title: 'Giáo dục', parenpId: -2, svgUrl: '', type: '0'),
  // Category(id: 14, title: 'Đồ gia dụng', parenpId: -2, svgUrl: '', type: '0'),
  // Category(id: 15, title: 'Đồ dùng cá nhân', parenpId: -2, svgUrl: '', type: '0'),
  // Category(id: 16, title: 'Vật nuôi', parenpId: -2, svgUrl: '', type: '0'),
  // Category(id: 17, title: 'Dịch vụ gia đình', parenpId: -2, svgUrl: '', type: '0'),
  // Category(id: 18, title: 'Các chi phí khác', parenpId: -2, svgUrl: '', type: '0'),
  // Category(id: 19, title: 'Thể dục thể thao', parenpId: -3, svgUrl: '', type: '0'),
  // Category(id: 20, title: 'Làm đẹp', parenpId: -3, svgUrl: '', type: '0'),
  // Category(id: 10, title: 'Quà tặng & Quyên góp', parenpId: -3, svgUrl: '', type: '0'),
  // Category(id: 21, title: 'Dịch vụ trực tuyến', parenpId: -3, svgUrl: '', type: '0'),
  // Category(id: 22, title: 'Vui - chơi', parenpId: -3, svgUrl: '', type: '0'),
  // Category(id: 23, title: 'Đầu tư', parenpId: -4, svgUrl: '', type: '0'),
  // Category(id: 24, title: 'Thu nợ', parenpId: -4, svgUrl: '', type: '1'),
  // Category(id: 25, title: 'Đi vay', parenpId: -4, svgUrl: '', type: '0'),
  // Category(id: 26, title: 'Cho vay', parenpId: -4, svgUrl: '', type: '1'),
  // Category(id: 27, title: 'Trả nợ', parenpId: -4, svgUrl: '', type: '0'),
  // Category(id: 28, title: 'Trả lãi', parenpId: -4, svgUrl: '', type: '0'),
  // Category(id: 29, title: 'Thu lãi', parenpId: -4, svgUrl: '', type: '1'),
  // Category(id: 30, title: 'Lương', parenpId: -5, svgUrl: '', type: '1'),
  // Category(id: 31, title: 'Thu nhập khác', parenpId: -5, svgUrl: '', type: '1'),
  // Category(id: 32, title: 'Tiền chuyển đi', parenpId: -6, svgUrl: '', type: '0'),
  // Category(id: 33, title: 'Tiền chuyển đến', parenpId: -6, svgUrl: '', type: '1'),
}

class PaginationDataModel {
  int? currentPage;
  int? totalPages;
  int? totalRows;
  int? perPage;

  PaginationDataModel({this.currentPage, this.totalPages, this.totalRows = 0, this.perPage});

  PaginationDataModel.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    totalPages = json['total_pages'];
    totalRows = json['total_rows'];
    perPage = json['perPage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['total_pages'] = this.totalPages;
    data['total_rows'] = this.totalRows;
    data['perPage'] = this.perPage;
    return data;
  }
}

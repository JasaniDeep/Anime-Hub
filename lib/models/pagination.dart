class PaginationItems {
  final int? count;
  final int? total;
  final int? perPage;

  PaginationItems({
    this.count,
    this.total,
    this.perPage,
  });

  factory PaginationItems.fromJson(Map<String, dynamic> json) {
    return PaginationItems(
      count: json['count'] as int?,
      total: json['total'] as int?,
      perPage: json['per_page'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'count': count,
      'total': total,
      'per_page': perPage,
    };
  }
}

class Pagination {
  final int? lastVisiblePage;
  final bool? hasNextPage;
  final int? currentPage;
  final PaginationItems? items;

  Pagination({
    this.lastVisiblePage,
    this.hasNextPage,
    this.currentPage,
    this.items,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      lastVisiblePage: json['last_visible_page'] as int?,
      hasNextPage: json['has_next_page'] as bool?,
      currentPage: json['current_page'] as int?,
      items: json['items'] != null
          ? PaginationItems.fromJson(json['items'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'last_visible_page': lastVisiblePage,
      'has_next_page': hasNextPage,
      'current_page': currentPage,
      'items': items?.toJson(),
    };
  }
}


class SalesModel {
  final int id;
  final String name;
  final String accessUrl;
  final List<dynamic> companyId;
  final List<dynamic> partnerId;
  final String dateOrder;
  final String createDate;
  final String state;

  SalesModel({
    required this.id,
    required this.name,
    required this.accessUrl,
    required this.companyId,
    required this.partnerId,
    required this.dateOrder,
    required this.createDate,
    required this.state,
  });

  factory SalesModel.fromJson(Map<String, dynamic> json) => SalesModel(
      id: json['id'],
      name: json['name'],
      accessUrl: json['access_url'],
      companyId: json['company_id'],
      partnerId: json['partner_id'],
      dateOrder: json['date_order'],
      createDate: json['create_date'],
      state: json['state']);

  Map<String, dynamic> toJson() => {
        "id": id,
        'name': name,
        'access_url': accessUrl,
        'company_id': companyId,
        'partner_id': partnerId,
        'date_order': dateOrder,
        'create_date': createDate,
        'state': state
      };
}

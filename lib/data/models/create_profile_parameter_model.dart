class CreateProfileParameter{
  String CustomerName;
  String CustomerAddress;
  String CustomerCity;
  String CustomerState;
  String CustomerPostCode;
  String CustomerCountry;
  String CustomerPhone;
  String CustomerFax;
  String ShippingName;
  String ShippingAddress;
  String ShippingCity;
  String ShippingState;
  String ShippingPostCode;
  String ShippingCountry;
  String ShippingPhone;
  CreateProfileParameter({
    required this.CustomerName,
    required this.CustomerAddress,
    required this.CustomerCity,
    required this.CustomerState,
    required this.CustomerPostCode,
    required this.CustomerCountry,
    required this.CustomerPhone,
    required this.CustomerFax,
    required this.ShippingName,
    required this.ShippingAddress,
    required this.ShippingCity,
    required this.ShippingState,
    required this.ShippingPostCode,
    required this.ShippingCountry,
    required this.ShippingPhone,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cus_name'] = CustomerName;
    data['cus_add'] = CustomerAddress;
    data['cus_city'] = CustomerCity;
    data['cus_state'] = CustomerState;
    data['cus_postcode'] = CustomerPostCode;
    data['cus_country'] = CustomerCountry;
    data['cus_phone'] = CustomerPhone;
    data['cus_fax'] = CustomerFax;
    data['ship_name'] = ShippingName;
    data['ship_add'] = ShippingAddress;
    data['ship_city'] = ShippingCity;
    data['ship_state'] = ShippingState;
    data['ship_postcode'] = ShippingPostCode;
    data['ship_country'] = ShippingCountry;
    data['ship_phone'] = ShippingPhone;
    return data;
  }

}
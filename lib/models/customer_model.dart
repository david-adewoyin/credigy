import 'package:flutter/material.dart';

const String _columnCustomerId = "customer_id";
const String _columnCustomerName = "customer_name";
const String _columnCustomerPhone = "customer_phone";
const String _columnCustomerEmail = "customer_email";
const String _columnCustomerAddress = "customer_address";
const String _columnCustomerDescription = "customer_description";

class CustomerModel {
  int? id;
  String name;
  String? email;
  String? phone;
  String? address;
  String? description;

  CustomerModel({
    this.address,
    this.description,
    this.id,
    this.email,
    required this.name,
    this.phone,
  });
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _columnCustomerId: id,
      _columnCustomerName: name,
      _columnCustomerEmail: email,
      _columnCustomerPhone: phone,
      _columnCustomerAddress: address,
      _columnCustomerDescription: description,
    };
    return map;
  }
}

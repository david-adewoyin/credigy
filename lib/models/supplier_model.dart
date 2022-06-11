import 'package:flutter/material.dart';

const String _columnSupplierId = "supplier_id";
const String _columnSupplierName = "supplier_name";
const String _columnSupplierPhone = "supplier_phone";
const String _columnSupplierEmail = "supplier_email";
const String _columnSupplierAddress = "supplier_address";
const String _columnSupplierDescription = "supplier_description";

class SupplierModel {
  int? id;
  String name;
  String? email;
  String? phone;
  String? address;
  String? description;

  SupplierModel({
    this.address,
    this.description,
    this.id,
    this.email,
    required this.name,
    this.phone,
  });
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _columnSupplierId: id,
      _columnSupplierName: name,
      _columnSupplierEmail: email,
      _columnSupplierPhone: phone,
      _columnSupplierAddress: address,
      _columnSupplierDescription: description,
    };
    return map;
  }
}

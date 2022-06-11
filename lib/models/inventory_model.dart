import 'package:flutter/material.dart';

const String _columnProductId = "product_id";
const String _columnProductName = "product_name";
const String _columnMeasurementUnit = "product_measurement_unit";
const String _columnQuantity = "product_quantity";
const String _columnCostPrice = "product_cost_price";
const String _columnSellingPrice = "product_selling_price";

enum MeasurementUnit { kg, crate, box, bag, none }

class InventoryModel {
  int? id;
  String productName;
  MeasurementUnit unit;
  int? quantity;
  double costPrice;
  double sellingPrice;

  InventoryModel({
    required this.productName,
    this.id,
    required this.unit,
    this.quantity,
    required this.costPrice,
    required this.sellingPrice,
  });
  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      _columnProductId: id,
      _columnProductName: productName,
      _columnMeasurementUnit: unit.toString(),
      _columnQuantity: quantity,
      _columnCostPrice: costPrice,
      _columnSellingPrice: sellingPrice,
    };
    return map;
  }

  /* InventoryModel.fromMap(Map<String, Object?> map) {
    = map[_columnProductId] as int?;
    productName = (map[_columnProductName]) as String;
    costPrice = (map[_columnCostPrice]) as double;
    quantity = (map[_columnQuantity]) as int?;
    sellingPrice = (map[_columnSellingPrice]) as double;
  } */
}

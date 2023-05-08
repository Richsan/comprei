import 'package:comprei/models/product.dart';
import 'package:comprei/models/purchase.dart';

extension MerchantEntity on Merchant {
  Map<String, dynamic> toMapEntity() {
    return {
      'merchant_id': id,
      'merchant_name': name,
      'merchant_nickname': nickName,
    };
  }
}

extension BrandEntity on Brand {
  Map<String, dynamic> toMapEntity() {
    return {
      'brand_id': id.uuid,
      'brand_name': name,
      'brand_nickname': nickName,
    };
  }
}

extension ProductEntity on Product {
  Map<String, dynamic> toMapEntity() {
    if (brand?.id != null) {
      return {
        'product_cod': cod,
        'product_description': description,
        'product_nickName': nickName,
        'brand_id': brand!.id.uuid
      };
    } else {
      return {
        'product_cod': cod,
        'product_description': description,
        'product_nickName': nickName,
      };
    }
  }
}

extension PurchaseEntity on Purchase {
  Map<String, dynamic> toMapEntity() {
    return {
      'purchase_id': id.uuid,
      'merchant_id': merchant.id,
      'purchase_date_time': date.toIso8601String(),
      'purchase_discount': discount,
      'purchase_tax_value': taxValue,
      ...(invoice != null ? {'purchase_invoice': invoice!} : {})
    };
  }
}

extension PurchaseItemEntity on PurchaseItem {
  Map<String, dynamic> toMapEntity() {
    return {
      'purchase_item_id': id.uuid,
      'product_cod': product.cod,
      'purchase_item_value': value,
      'purchase_item_discount': discount,
      'purchase_item_unities': unities,
      'purchase_item_unit_measure': unitMeasure,
    };
  }
}

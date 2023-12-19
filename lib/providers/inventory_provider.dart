import 'package:dehub/models/inventory_goods.dart';
import 'package:flutter/material.dart';

class InventoryProvider extends ChangeNotifier {
  InventoryGoods product = InventoryGoods();
  List<String> images = [];
  bool itemTypeValidate = false;
  bool classificationValidate = false;
  bool subClassificationValidate = false;
  bool categoryValidate = false;
  bool subCategoryValidate = false;
  bool tagValidate = false;

  itValidate() {
    if (product.itemTypeName == null) {
      itemTypeValidate = true;
    }
    notifyListeners();
  }

  classValidate() {
    if (product.classificationName == null) {
      classificationValidate = true;
    }
    notifyListeners();
  }

  subClassValidate() {
    if (product.subClassificationName == null) {
      subClassificationValidate = true;
    }
    notifyListeners();
  }

  catValidate() {
    if (product.categoryName == null) {
      categoryValidate = true;
    }
    notifyListeners();
  }

  subCatValidate() {
    if (product.subCategoryName == null) {
      subCategoryValidate = true;
    }
    notifyListeners();
  }

  tValidate() {
    if (product.tagName == null) {
      tagValidate = true;
    }
    notifyListeners();
  }

  brand(String value, String id) {
    product.brandName = value;
    product.brandId = id;
    notifyListeners();
  }

  supplier(String value, String id) {
    product.supplierName = value;
    product.supplierId = id;
    notifyListeners();
  }

  manufacturer(String value, String id) {
    product.manufacturerName = value;
    product.manufacturerId = id;
    notifyListeners();
  }

  manufacturerCountry(String value, String id) {
    product.manufacturerCountryName = value;
    product.manufacturerCountryId = id;
    notifyListeners();
  }

  importerCountry(String value, String id) {
    product.importerCountryName = value;
    product.importerCountryId = id;
    notifyListeners();
  }

  distributor(String value, String id) {
    product.distributorName = value;
    product.distributorId = id;
    notifyListeners();
  }

  itemType(String value, String id) {
    product.itemTypeName = value;
    product.itemTypeId = id;
    itemTypeValidate = false;
    notifyListeners();
  }

  classification(String value, String id) {
    product.classificationName = value;
    product.classificationId = id;
    classificationValidate = false;
    notifyListeners();
  }

  subClassification(String value, String id) {
    product.subClassificationName = value;
    product.subClassificationId = id;
    subClassificationValidate = false;
    notifyListeners();
  }

  category(String value, String id) {
    product.categoryName = value;
    product.categoryId = id;
    categoryValidate = false;
    notifyListeners();
  }

  subCategory(String value, String id) {
    product.subCategoryName = value;
    product.subCategoryId = id;
    subCategoryValidate = false;
    notifyListeners();
  }

  tag(String value, String id) {
    product.tagName = value;
    product.tagId = id;
    tagValidate = false;
    notifyListeners();
  }

  profileImage(String value) {
    product.url = value;
    notifyListeners();
  }

  bannerImages(String value) {
    images.add(value);
    product.detailImages = images;
    notifyListeners();
  }

  removeBannerImage(int index) {
    product.detailImages?.removeAt(index);
    notifyListeners();
  }

  description(String value) {
    product.description = value;
    notifyListeners();
  }

  units(String value, String id) {
    product.unitId = id;
    product.unitName = value;
    notifyListeners();
  }

  unitWeightLabel(String value, String id) {
    product.unitWeightLabel = value;
    product.unitWeightLabelId = id;
    notifyListeners();
  }

  unitSpaceLabels(String value, String id) {
    product.unitSpaceLabel = value;
    product.unitSpaceLabelId = id;
    notifyListeners();
  }

  returnType(String value, String id) {
    product.returnType = value;
    product.returnTypeId = id;
    notifyListeners();
  }

  option(String value, String id) {
    product.option = value;
    product.optionId = id;
    notifyListeners();
  }

  clearCategory() {
    product.classificationName = null;
    product.subClassificationName = null;
    product.categoryName = null;
    product.subCategoryName = null;
    product.classificationId = null;
    product.subClassificationId = null;
    product.categoryId = null;
    product.subCategoryId = null;
  }

  clearData() {
    product = InventoryGoods();
    itemTypeValidate = false;
    classificationValidate = false;
    subClassificationValidate = false;
    categoryValidate = false;
    subCategoryValidate = false;
    tagValidate = false;
    notifyListeners();
  }
}

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
  bool profileValidate = false;
  bool bannerValidate = false;
  bool fieldValidate = false;
  List<InventoryGoods> quantityPrices = [];
  List<InventoryGoods> sections = [];
  List<InventoryGoods> variantSuppliers = [];
  List<InventoryGoods> values = [];
  List<InventoryGoods> sectionFieldValues = [];
  List<InventoryGoods> additionalUnits = [];
  TextEditingController nameBillController = TextEditingController();
  TextEditingController nameAppController = TextEditingController();
  TextEditingController nameWebController = TextEditingController();
  List<List<InventoryGoods>> options = [];

  id(String value) {
    product.id = value;
    notifyListeners();
  }

  removeOption(int index) {
    options.removeAt(index);
    notifyListeners();
  }

  proValidate() {
    if (product.url == null) {
      profileValidate = true;
    }
    notifyListeners();
  }

  banValidate() {
    bannerValidate = true;
    notifyListeners();
  }

  nameBill(String value) {
    nameBillController.text = value;
    nameAppController.text = value;
    nameWebController.text = value;
    notifyListeners();
  }

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
    bannerValidate = false;
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

  returnAllow(bool value) {
    product.returnAllow = value;
    notifyListeners();
  }

  section(InventoryGoods data, bool isDuplicate) {
    if (isDuplicate == true) {
      int index = sections.indexWhere((element) => element.id == data.id);
      if (index < 0) {
        sections.add(data);
      }
    } else {
      sections.add(data);
    }
    product.sections = sections;
    notifyListeners();
  }

  removeSection(int index) {
    sections.removeAt(index);
    product.sections = sections;
    notifyListeners();
  }

  checkBoxField(bool value, int index, int fieldIndex) {
    product.sections?[index].fields?[fieldIndex].checked = value;
    notifyListeners();
  }

  fieldValue(String value, String id, int index, int fieldIndex) {
    product.sections?[index].fields?[fieldIndex].fieldValueId = id;
    product.sections?[index].fields?[fieldIndex].fieldValueName = value;
    fieldValidate = false;
    notifyListeners();
  }

  fValidate(int index, int fieldIndex) {
    if (product.sections?[index].fields?[fieldIndex].fieldValueName == null) {
      fieldValidate = true;
    }
    notifyListeners();
  }

  supplierType(String value, String id) {
    product.supplierType = id;
    product.supplierTypeName = value;
    notifyListeners();
  }

  setPrice(double price, String endDate, String startDate) {
    product.startDate = startDate;
    product.endDate = endDate;
    product.customPrice = price;
    notifyListeners();
  }

  setQuantityPrice(InventoryGoods data) {
    quantityPrices.add(data);
    product.quantityPrices = quantityPrices;
    notifyListeners();
  }

  warehouse(InventoryGoods data) {
    product.warehouse = data;
    notifyListeners();
  }

  merchStaff(InventoryGoods data) {
    product.merchStaff = data;
    notifyListeners();
  }

  buyerBusiness(InventoryGoods data) {
    product.buyerBusiness = data;
    notifyListeners();
  }

  supplierBusiness(InventoryGoods data) {
    product.supplierBusiness = data;
    notifyListeners();
  }

  partner(InventoryGoods data) {
    product.partnerBusiness = data;
    notifyListeners();
  }

  clearBusiness() {
    product.buyerBusiness = null;
    product.partnerBusiness = null;
    product.supplierBusiness = null;
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

  variantSupplier(InventoryGoods data) {
    variantSuppliers.add(data);
    product.variantSuppliers = variantSuppliers;
    notifyListeners();
  }

  select(InventoryGoods data) {
    values.add(data);
    product.values = values;
    notifyListeners();
  }

  remove(int index) {
    values.removeAt(index);
    product.values = values;
    notifyListeners();
  }

  additinalUnit(InventoryGoods data) {
    additionalUnits.add(data);
    product.additionalUnits = additionalUnits;
    notifyListeners();
  }

  setAdditionalUnit(InventoryGoods data, int index) {
    product.additionalUnits?[index].convertValue = data.convertValue;
    product.additionalUnits?[index].floatValue = data.floatValue;
    product.additionalUnits?[index].height = data.height;
    product.additionalUnits?[index].width = data.width;
    product.additionalUnits?[index].length = data.length;
    product.additionalUnits?[index].weight = data.weight;
    product.additionalUnits?[index].isForLoad = data.isForLoad;
    product.additionalUnits?[index].spaceLabel = data.spaceLabel;
    product.additionalUnits?[index].weightLabel = data.weightLabel;
    product.additionalUnits?[index].convertType = data.convertType;
    notifyListeners();
  }

  removeAdditinoalUnit(int index) {
    additionalUnits.removeAt(index);
    product.additionalUnits = additionalUnits;
    notifyListeners();
  }

  optionValue(List<List<InventoryGoods>> data) {
    options = data;
    notifyListeners();
  }

  clearData() {
    product =
        InventoryGoods(values: [], variantSuppliers: [], quantityPrices: []);
    images = [];
    sections = [];
    values = [];
    quantityPrices = [];
    additionalUnits = [];
    variantSuppliers = [];
    sectionFieldValues = [];
    profileValidate = false;
    bannerValidate = false;
    itemTypeValidate = false;
    classificationValidate = false;
    subClassificationValidate = false;
    categoryValidate = false;
    subCategoryValidate = false;
    tagValidate = false;
    options = [];
    nameBillController.text = '';
    nameAppController.text = '';
    nameWebController.text = '';
    notifyListeners();
  }

  vatType(String value, double vatValue) {
    product.vatType = value;
    product.vatValue = vatValue;
    notifyListeners();
  }

  sectionClear() {
    sections = [];
    product.sections = sections;
    notifyListeners();
  }

  taxType(bool value, double taxValue) {
    product.hasTax = value;
    product.taxPercent = taxValue;
    notifyListeners();
  }

  sectionType(int index, String value) {
    product.sections?[index].type = value;
    notifyListeners();
  }

  sectionValues(int index, InventoryGoods data) {
    sectionFieldValues.add(data);
    product.sections?[index].values = sectionFieldValues;
    notifyListeners();
  }

  sectionRemove(int index) {
    sections.removeAt(index);
    product.sections = sections;
    notifyListeners();
  }

  clearSectionValues(int index) {
    sectionFieldValues = [];
    product.sections?[index].values = sectionFieldValues;
    notifyListeners();
  }
}

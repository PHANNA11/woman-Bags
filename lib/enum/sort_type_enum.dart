import 'package:cached_network_image/cached_network_image.dart';

enum EnumOrderByPrice { maxToMin, minToMax }

extension EnumOrderByPriceValue on EnumOrderByPrice {
  bool get apiValue {
    switch (this) {
      case EnumOrderByPrice.maxToMin:
        return true;
      case EnumOrderByPrice.minToMax:
        return false;
    }
  }
}

extension EnumOrderByPriceDisPlay on EnumOrderByPrice {
  String get apiDisplay {
    switch (this) {
      case EnumOrderByPrice.maxToMin:
        return 'Sort by Price Max->Min';
      case EnumOrderByPrice.minToMax:
        return 'Sort by Price Min->Max';
    }
  }
}

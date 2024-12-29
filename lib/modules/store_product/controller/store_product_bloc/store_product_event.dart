part of 'store_product_bloc.dart';

abstract class StoreProductEvent extends Equatable {
  const StoreProductEvent();

  @override
  List<Object?> get props => [];
}

class StoreProductEventImage extends StoreProductEvent {
  final String image;

  const StoreProductEventImage(this.image);

  @override
  List<Object?> get props => [image];
}

class StoreProductEventShortName extends StoreProductEvent {
  final String shortName;

  const StoreProductEventShortName(this.shortName);

  @override
  List<Object?> get props => [shortName];
}

class StoreProductEventName extends StoreProductEvent {
  final String name;

  const StoreProductEventName(this.name);

  @override
  List<Object?> get props => [name];
}

class StoreProductEventSlug extends StoreProductEvent {
  final String slug;

  const StoreProductEventSlug(this.slug);

  @override
  List<Object?> get props => [slug];
}

class StoreProductEventPrice extends StoreProductEvent {
  final String price;

  const StoreProductEventPrice(this.price);

  @override
  List<Object?> get props => [price];
}

class StoreProductEventOfferPrice extends StoreProductEvent {
  final String offerPrice;

  const StoreProductEventOfferPrice(this.offerPrice);

  @override
  List<Object?> get props => [offerPrice];
}

class StoreProductEventQuantity extends StoreProductEvent {
  final String quantity;

  const StoreProductEventQuantity(this.quantity);

  @override
  List<Object?> get props => [quantity];
}

class StoreProductEventWeight extends StoreProductEvent {
  final String weight;

  const StoreProductEventWeight(this.weight);

  @override
  List<Object?> get props => [weight];
}

class StoreProductEventShortDes extends StoreProductEvent {
  final String shortDescription;

  const StoreProductEventShortDes(this.shortDescription);

  @override
  List<Object?> get props => [shortDescription];
}

class StoreProductEventLongDes extends StoreProductEvent {
  final String longDescription;

  const StoreProductEventLongDes(this.longDescription);

  @override
  List<Object?> get props => [longDescription];
}

class StoreProductEventCategory extends StoreProductEvent {
  final String category;

  const StoreProductEventCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class StoreProductEventStatus extends StoreProductEvent {
  final String id;

  const StoreProductEventStatus(this.id);

  @override
  List<Object?> get props => [id];
}


class StoreProductEventTags extends StoreProductEvent {
  final String tags;

  const StoreProductEventTags(this.tags);

  @override
  List<Object?> get props => [tags];
}

class StoreProductEventSeoTitle extends StoreProductEvent {
  final String seoTitle;

  const StoreProductEventSeoTitle(this.seoTitle);

  @override
  List<Object?> get props => [seoTitle];
}

class StoreProductEventSeoDescription extends StoreProductEvent {
  final String seoDescription;

  const StoreProductEventSeoDescription(this.seoDescription);

  @override
  List<Object?> get props => [seoDescription];
}

class StoreProductEventTop extends StoreProductEvent {
  final String isTop;

  const StoreProductEventTop(this.isTop);

  @override
  List<Object?> get props => [isTop];
}

class StoreProductEventSku extends StoreProductEvent {
  final String sku;

  const StoreProductEventSku(this.sku);

  @override
  List<Object?> get props => [sku];
}

class StoreProductEventNewProduct extends StoreProductEvent {
  final String newProduct;

  const StoreProductEventNewProduct(this.newProduct);

  @override
  List<Object?> get props => [newProduct];
}
class StoreProductEventBest extends StoreProductEvent {
  final String isBest;

  const StoreProductEventBest(this.isBest);

  @override
  List<Object?> get props => [isBest];
}
class StoreProductEventFeature extends StoreProductEvent {
  final String isFeatured;

  const StoreProductEventFeature(this.isFeatured);

  @override
  List<Object?> get props => [isFeatured];
}
class StoreProductEventSpecification extends StoreProductEvent {
  final String isSpecification;

  const StoreProductEventSpecification(this.isSpecification);

  @override
  List<Object?> get props => [isSpecification];
}

class StoreProductSubmitEvent extends StoreProductEvent {}

class StoreProductUpdateStatusEvent extends StoreProductEvent {
  final String id;

  const StoreProductUpdateStatusEvent(this.id);

  @override
  List<Object?> get props => [id];
}

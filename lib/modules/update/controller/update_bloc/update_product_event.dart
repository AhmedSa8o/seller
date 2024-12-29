part of 'update_product_bloc.dart';

abstract class UpdateProductEvent extends Equatable {
  const UpdateProductEvent();

  @override
  List<Object?> get props => [];
}

class UpdateProductEventImage extends UpdateProductEvent {
  final String image;

  const UpdateProductEventImage(this.image);

  @override
  List<Object?> get props => [image];
}

class UpdateProductEventShortName extends UpdateProductEvent {
  final String shortName;

  const UpdateProductEventShortName(this.shortName);

  @override
  List<Object?> get props => [shortName];
}

class UpdateProductEventName extends UpdateProductEvent {
  final String name;

  const UpdateProductEventName(this.name);

  @override
  List<Object?> get props => [name];
}

class UpdateProductEventSlug extends UpdateProductEvent {
  final String slug;

  const UpdateProductEventSlug(this.slug);

  @override
  List<Object?> get props => [slug];
}

class UpdateProductEventPrice extends UpdateProductEvent {
  final String price;

  const UpdateProductEventPrice(this.price);

  @override
  List<Object?> get props => [price];
}

class UpdateProductEventOfferPrice extends UpdateProductEvent {
  final String offerPrice;

  const UpdateProductEventOfferPrice(this.offerPrice);

  @override
  List<Object?> get props => [offerPrice];
}

class UpdateProductEventQuantity extends UpdateProductEvent {
  final String quantity;

  const UpdateProductEventQuantity(this.quantity);

  @override
  List<Object?> get props => [quantity];
}

class UpdateProductEventWeight extends UpdateProductEvent {
  final String weight;

  const UpdateProductEventWeight(this.weight);

  @override
  List<Object?> get props => [weight];
}

class UpdateProductEventShortDes extends UpdateProductEvent {
  final String shortDescription;

  const UpdateProductEventShortDes(this.shortDescription);

  @override
  List<Object?> get props => [shortDescription];
}

class UpdateProductEventLongDes extends UpdateProductEvent {
  final String longDescription;

  const UpdateProductEventLongDes(this.longDescription);

  @override
  List<Object?> get props => [longDescription];
}

class UpdateProductEventCategory extends UpdateProductEvent {
  final String category;

  const UpdateProductEventCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class UpdateProductEventStatus extends UpdateProductEvent {
  final String id;

  const UpdateProductEventStatus(this.id);

  @override
  List<Object?> get props => [id];
}


class UpdateProductEventTopProduct extends UpdateProductEvent{
  final String isTop;
  const UpdateProductEventTopProduct(this.isTop);
  @override
  List<Object?> get props => [isTop];
}

class UpdateProductEventNewArrivalProduct extends UpdateProductEvent{
  final String newArrival;
  const UpdateProductEventNewArrivalProduct(this.newArrival);
  @override
  List<Object?> get props => [newArrival];
}


class UpdateProductEventBestProduct extends UpdateProductEvent{
  final String isBest;
  const UpdateProductEventBestProduct(this.isBest);
  @override
  List<Object?> get props => [isBest];
}

class UpdateProductEventFeatured extends UpdateProductEvent{
  final String isFeatured;
  const UpdateProductEventFeatured(this.isFeatured);
  @override
  List<Object?> get props => [isFeatured];
}


class UpdateProductEventTags extends UpdateProductEvent {
  final String tags;

  const UpdateProductEventTags(this.tags);

  @override
  List<Object?> get props => [tags];
}

class UpdateProductEventSeoTitle extends UpdateProductEvent {
  final String seoTitle;

  const UpdateProductEventSeoTitle(this.seoTitle);

  @override
  List<Object?> get props => [seoTitle];
}

class UpdateProductEventSeoDescription extends UpdateProductEvent {
  final String seoDescription;

  const UpdateProductEventSeoDescription(this.seoDescription);

  @override
  List<Object?> get props => [seoDescription];
}

class UpdateProductEventTop extends UpdateProductEvent {
  final String isTop;

  const UpdateProductEventTop(this.isTop);

  @override
  List<Object?> get props => [isTop];
}

class UpdateProductEventSku extends UpdateProductEvent {
  final String sku;

  const UpdateProductEventSku(this.sku);

  @override
  List<Object?> get props => [sku];
}

class UpdateProductEventNewProduct extends UpdateProductEvent {
  final String newProduct;

  const UpdateProductEventNewProduct(this.newProduct);

  @override
  List<Object?> get props => [newProduct];
}
class UpdateProductEventBest extends UpdateProductEvent {
  final String isBest;

  const UpdateProductEventBest(this.isBest);

  @override
  List<Object?> get props => [isBest];
}
class UpdateProductEventFeature extends UpdateProductEvent {
  final String isFeatured;

  const UpdateProductEventFeature(this.isFeatured);

  @override
  List<Object?> get props => [isFeatured];
}
class UpdateProductEventSpecification extends UpdateProductEvent {
  final String isSpecification;

  const UpdateProductEventSpecification(this.isSpecification);

  @override
  List<Object?> get props => [isSpecification];
}


class UpdateProductSubmitEvent extends UpdateProductEvent {
  final String id;

  const UpdateProductSubmitEvent(this.id);

  @override
  List<Object?> get props => [id];
}

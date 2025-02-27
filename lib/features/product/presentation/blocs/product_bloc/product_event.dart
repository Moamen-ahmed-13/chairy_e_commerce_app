import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}
class SearchProductEvent extends ProductEvent {
  final String query;

  const SearchProductEvent(this.query);

  @override
  List<Object> get props => [query];
}

class LoadProductEvent extends ProductEvent {
  
}

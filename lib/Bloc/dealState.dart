import 'package:dealsapp/models/Deals.dart';
import 'package:equatable/equatable.dart';

abstract class DealState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DealInitial extends DealState {}

class DealLoading extends DealState {}

class DealLoaded extends DealState {
  final List<Deal> deals;
  final bool hasMore;

  DealLoaded(this.deals, {this.hasMore = true});

  @override
  List<Object?> get props => [deals, hasMore];
}

class DealError extends DealState {
  final String message;

  DealError(this.message);

  @override
  List<Object?> get props => [message];
}

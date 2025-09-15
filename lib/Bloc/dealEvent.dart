import 'package:equatable/equatable.dart';

abstract class DealEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadDeals extends DealEvent {
  final String endpoint;
  final bool refresh;

  LoadDeals(this.endpoint, {this.refresh = false});

  @override
  List<Object?> get props => [endpoint, refresh];
}

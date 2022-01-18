import 'package:equatable/equatable.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';

abstract class SearchState extends Equatable {
  const SearchState();
}

class SearchEmpty extends SearchState {
  @override
  List<Object> get props => [];
}

class ClearSearch extends SearchState {
  @override
  List<Object> get props => [];
}

class SearchLoading extends SearchState {
  final List<RealEntity> oldObjectsList;
  final bool isFirstFetch;
  SearchLoading(this.oldObjectsList, {this.isFirstFetch = false});
  @override
  List<Object?> get props => [oldObjectsList];
}

class SearchLoaded extends SearchState {
  final List<RealEntity> objects;
  const SearchLoaded({required this.objects});
  @override
  List<Object> get props => [objects];
}

class SearchError extends SearchState {
  final String message;
  const SearchError({required this.message});
  @override
  List<Object> get props => [message];
}

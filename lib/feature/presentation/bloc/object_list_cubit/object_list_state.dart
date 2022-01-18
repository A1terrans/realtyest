import 'package:equatable/equatable.dart';
import 'package:realtyest/feature/domain/entities/real_entity.dart';

abstract class ObjectState extends Equatable {
  const ObjectState();
}

class ObjectEmpty extends ObjectState {
  @override
  List<Object> get props => [];
}

class ClearObject extends ObjectState {
  @override
  List<Object> get props => [];
}

class ObjectLoading extends ObjectState {
  final List<RealEntity> oldObjectsList;
  final bool isFirstFetch;

  const ObjectLoading(this.oldObjectsList, {this.isFirstFetch = false});
  @override
  List<Object> get props => [oldObjectsList];
}

class ObjectsLoaded extends ObjectState {
  final List<RealEntity> objectsList;
  const ObjectsLoaded(this.objectsList);
  @override
  List<Object> get props => [objectsList];
}

class ObjectError extends ObjectState {
  final String message;
  const ObjectError({required this.message});
  @override
  List<Object> get props => [message];
}

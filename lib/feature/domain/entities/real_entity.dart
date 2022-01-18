import 'package:equatable/equatable.dart';

class RealEntity extends Equatable {
  final String? ID;
  final String? pageNow;
  final String? pagesAll;
  final String? Types;
  final String? Region;
  final String? District;
  final String? Address;
  final String? Lat;
  final String? Lon;
  final String? Metro;
  final String? MetroTime;
  final String? Price;
  final String? BasePrice;
  final String? AllS;
  final String? LiveS;
  final String? KitchenS;
  final String? TypeTwo;
  final String? TypeThree;
  final String? FloorN;
  final String? AllFloors;
  final String? Rooms;
  final String? Apart;
  final String? Stud;
  final String? Year;
  final String? Queye;
  final String? BuildType;
  final String? BuildSection;
  final String? Contacts;
  final String? RoomsArea;
  final String? Image;

  const RealEntity({
    required this.ID,
    required this.pageNow,
    required this.pagesAll,
    required this.Types,
    required this.Region,
    required this.District,
    required this.Address,
    required this.Lat,
    required this.Lon,
    required this.Metro,
    required this.MetroTime,
    required this.Price,
    required this.BasePrice,
    required this.AllS,
    required this.LiveS,
    required this.KitchenS,
    required this.TypeTwo,
    required this.TypeThree,
    required this.FloorN,
    required this.AllFloors,
    required this.Rooms,
    required this.Apart,
    required this.Stud,
    required this.Year,
    required this.Queye,
    required this.BuildType,
    required this.BuildSection,
    required this.Contacts,
    required this.RoomsArea,
    required this.Image,
  });

  @override
  List<Object?> get props => [
        ID,
        pageNow,
        pagesAll,
        Types,
        Region,
        District,
        Address,
        Lat,
        Lon,
        Metro,
        MetroTime,
        Price,
        BasePrice,
        AllS,
        LiveS,
        KitchenS,
        TypeTwo,
        TypeThree,
        FloorN,
        AllFloors,
        Rooms,
        Apart,
        Stud,
        Year,
        Queye,
        BuildType,
        BuildSection,
        Contacts,
        RoomsArea,
        Image,
      ];
}

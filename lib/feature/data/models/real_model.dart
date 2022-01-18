import 'package:realtyest/feature/domain/entities/real_entity.dart';

class RealObjModel extends RealEntity {
  const RealObjModel({
    required ID,
    required pageNow,
    required pagesAll,
    required Types,
    required Region,
    required District,
    required Address,
    required Lat,
    required Lon,
    required Metro,
    required MetroTime,
    required Price,
    required BasePrice,
    required AllS,
    required LiveS,
    required KitchenS,
    required TypeTwo,
    required TypeThree,
    required FloorN,
    required AllFloors,
    required Rooms,
    required Apart,
    required Stud,
    required Year,
    required Queye,
    required BuildType,
    required BuildSection,
    required Contacts,
    required RoomsArea,
    required Image,
  }) : super(
            ID: ID,
            pageNow: pageNow,
            pagesAll: pagesAll,
            Types: Types,
            Region: Region,
            District: District,
            Address: Address,
            Lat: Lat,
            Lon: Lon,
            Metro: Metro,
            MetroTime: MetroTime,
            Price: Price,
            BasePrice: BasePrice,
            AllS: AllS,
            LiveS: LiveS,
            KitchenS: KitchenS,
            TypeTwo: TypeTwo,
            TypeThree: TypeThree,
            FloorN: FloorN,
            AllFloors: AllFloors,
            Rooms: Rooms,
            Apart: Apart,
            Stud: Stud,
            Year: Year,
            Queye: Queye,
            BuildType: BuildType,
            BuildSection: BuildSection,
            Contacts: Contacts,
            RoomsArea: RoomsArea,
            Image: Image);
  factory RealObjModel.fromJson(Map<String, dynamic> json) {
    return RealObjModel(
        ID: json["ID"]?.toString(),
        pageNow: json["pageNow"].toString(),
        pagesAll: json["pagesAll"].toString(),
        Types: json["Types"]?.toString(),
        Region: json["Region"]?.toString(),
        District: json["District"]?.toString(),
        Address: json["Address"]?.toString(),
        Lat: json["Lat"]?.toString(),
        Lon: json["Lon"]?.toString(),
        Metro: json["Metro"]?.toString(),
        MetroTime: json["MetroTime"]?.toString(),
        Price: json["Price"]?.toString(),
        BasePrice: json["BasePrice"]?.toString(),
        AllS: json["AllS"]?.toString(),
        LiveS: json["LiveS"]?.toString(),
        KitchenS: json["KitchenS"]?.toString(),
        TypeTwo: json["TypeTwo"]?.toString(),
        TypeThree: json["TypeThree"]?.toString(),
        FloorN: json["FloorN"]?.toString(),
        AllFloors: json["AllFloors"]?.toString(),
        Rooms: json["Rooms"]?.toString(),
        Apart: json["Apart"]?.toString(),
        Stud: json["Stud"]?.toString(),
        Year: json["Year"]?.toString(),
        Queye: json["Queye"]?.toString(),
        BuildType: json["BuildType"]?.toString(),
        BuildSection: json["BuildSection"]?.toString(),
        Contacts: json["Contacts"]?.toString(),
        RoomsArea: json["RoomsArea"]?.toString(),
        Image: json["Image"]?.toString());
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data["ID"] = ID;
    data["pageNow"] = pageNow;
    data["pagesAll"] = pagesAll;
    data["Types"] = Types;
    data["Region"] = Region;
    data["District"] = District;
    data["Address"] = Address;
    data["Lat"] = Lat;
    data["Lon"] = Lon;
    data["Metro"] = Metro;
    data["MetroTime"] = MetroTime;
    data["Price"] = Price;
    data["BasePrice"] = BasePrice;
    data["AllS"] = AllS;
    data["LiveS"] = LiveS;
    data["KitchenS"] = KitchenS;
    data["TypeTwo"] = TypeTwo;
    data["TypeThree"] = TypeThree;
    data["FloorN"] = FloorN;
    data["AllFloors"] = AllFloors;
    data["Rooms"] = Rooms;
    data["Apart"] = Apart;
    data["Stud"] = Stud;
    data["Year"] = Year;
    data["Queye"] = Queye;
    data["BuildType"] = BuildType;
    data["BuildSection"] = BuildSection;
    data["Contacts"] = Contacts;
    data["RoomsArea"] = RoomsArea;
    data["Image"] = Image;
    return data;
  }
}

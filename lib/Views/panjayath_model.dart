class PanjayathModel{
  String district;
  String assembly;
  String panjayath;

  PanjayathModel(this.district,this.assembly,this.panjayath);
}
class AssemblyModel{
  String district;
  String assembly;

  AssemblyModel(this.district,this.assembly);
}
class MandalamModel{
  String district;
  String assembly;
  String block;
  String mandalam;

  MandalamModel(this.district,this.assembly,this.block,this.mandalam);
}
class BlockModel{
  String district;
  String assembly;
  String block;

  BlockModel(this.district,this.assembly,this.block);
}
class BoothModel{
  String district;
  String assembly;
  String block;
  String mandalam;
  String booth;

  BoothModel(this.district,this.assembly,this.block,this.mandalam,this.booth);
}
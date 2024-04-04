class DistrictReportModel{
  String district;
  double districtAmount;
  double transactionCount;
  DistrictReportModel(this.district,this.districtAmount,this.transactionCount);
}

class AssemblyReportModel{
  String assembly;
  String district;
  double assemblyAmount;
  double transactionCount;
  AssemblyReportModel(this.assembly,this.district,this.assemblyAmount,this.transactionCount);
}

class TopAssemblyModel{
  String assembly;
  String district;
  double assemblyAmount;
  double transactionCount;
  TopAssemblyModel(this.assembly,this.district,this.assemblyAmount,this.transactionCount);
}

class TopPanchayathModel{
  String panchayath;
  String district;
  double panchayathAmount;
  double transactionCount;
  TopPanchayathModel(this.panchayath,this.district,this.panchayathAmount,this.transactionCount);
}
class TopWardModel{
  String ward;
  String panchayath;
  String district;
  double panchayathAmount;
  double transactionCount;
  TopWardModel(this.ward,this.panchayath,this.district,this.panchayathAmount,this.transactionCount);
}
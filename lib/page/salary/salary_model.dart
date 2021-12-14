class SalarySlipModel {
  int id;
  // String status;
  // String dept;
  // String subGroup;
  // String period;
  int mainSalary;
  int position;
  int family;
  int discipline;
  int transport;
  int shift;
  int lunchBenefit;
  int overtime;
  int otherBenefit;
  int assurance;
  int JHT;
  int JP;
  int BPJSMedic;
  int SPSI;
  int lunchReduction;
  int otherReduction;

  SalarySlipModel(
      {required this.id,
      // required this.status,
      // required this.dept,
      // required this.subGroup,
      // required this.period,
      required this.mainSalary,
      required this.position,
      required this.family,
      required this.discipline,
      required this.transport,
      required this.shift,
      required this.lunchBenefit,
      required this.overtime,
      required this.otherBenefit,
      required this.assurance,
      required this.JHT,
      required this.JP,
      required this.BPJSMedic,
      required this.SPSI,
      required this.lunchReduction,
      required this.otherReduction});

  factory SalarySlipModel.fromJson(Map<String, dynamic> jsonData) =>
      SalarySlipModel(
        id: int.parse(jsonData['id']),
        // status: jsonData['status'],
        // dept: jsonData['dept'],
        // subGroup: jsonData['sub_group'],
        // period: jsonData['period'],
        mainSalary: int.parse(jsonData['gp']),
        position: int.parse(jsonData['jabatan']),
        family: int.parse(jsonData['keluarga']),
        discipline: int.parse(jsonData['disiplin']),
        transport: int.parse(jsonData['transport']),
        shift: int.parse(jsonData['shift']),
        lunchBenefit: int.parse(jsonData['t_makan']),
        overtime: int.parse(jsonData['lembur']),
        otherBenefit: int.parse(jsonData['lain']),
        assurance: int.parse(jsonData['asuransi']),
        JHT: int.parse(jsonData['jht']),
        JP: int.parse(jsonData['jp']),
        BPJSMedic: int.parse(jsonData['medic']),
        SPSI: int.parse(jsonData['spsi']),
        lunchReduction: int.parse(jsonData['p_makan']),
        otherReduction: int.parse(jsonData['p_lain']),
      );
}

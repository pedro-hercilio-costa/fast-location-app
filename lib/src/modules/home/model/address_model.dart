class AddressModel {
  late String cep;
  late String logradouro;
  late String complemento;
  late String bairro;
  late String localidade;
  late String uf;
  late String ibge;
  late String gia;
  late String ddd;
  late String siafi;

  AddressModel({
    required this.cep,
    required this.logradouro,
    required this.complemento,
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge,
    required this.gia,
    required this.ddd,
    required this.siafi,
  });

  AddressModel.fromJson(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'] ?? '';
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
  }

  AddressModel.fromJsonLocal(Map<String, dynamic> json) {
    cep = json['cep'];
    logradouro = json['logradouro'];
    complemento = json['complemento'] ?? '';
    bairro = json['bairro'];
    localidade = json['localidade'];
    uf = json['uf'];
    ibge = json['ibge'];
    gia = json['gia'];
    ddd = json['ddd'];
    siafi = json['siafi'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['cep'] = cep;
    json['logradouro'] = logradouro;
    json['complemento'] = complemento;
    json['bairro'] = bairro;
    json['localidade'] = localidade;
    json['uf'] = uf;
    json['ibge'] = ibge;
    json['gia'] = gia;
    json['ddd'] = ddd;
    json['siafi'] = siafi;

    return json;
  }
}

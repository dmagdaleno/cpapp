namespace sap.ui.riskmanagement;

using {managed} from '@sap/cds/common';

entity Risks : managed {
  key ID          : UUID @(Core.Computed : true);
      title       : String(100);
      prio        : String(5);
      descr       : String;
      miti        : Association to Mitigations;
      impact      : Integer;
      criticality : Integer;
}

entity Mitigations : managed {
  key ID          : UUID @(Core.Computed : true);
      description : String;
      owner       : String;
      timeline    : String;
      risks       : Association to many Risks
                      on risks.miti = $self;
}

using {API_BUSINESS_PARTNER as bupa} from '../srv/external/API_BUSINESS_PARTNER';

entity Suppliers    as projection on bupa.A_BusinessPartner {
  key BusinessPartner          as ID,
      BusinessPartnerFullName  as fullName,
      BusinessPartnerIsBlocked as isBlocked,
}

using { Challenge.SAP.API as csa } from '../srv/external/CHALLENGE_SAP_API';

type Lote: {
  noLote: Integer;
  noPagamento: Integer;
  valorPagamento: String;
  agencia: Integer;
  conta: Integer;
  digito: Integer;
  CNPJ: String;
  eParcelado: Integer;
  noParcela: Integer;
  qtdParcela: Integer;
  valorParcela: String;
}

entity EnviaLote: managed {
  status: Integer;
  lotes: many Lote;
}
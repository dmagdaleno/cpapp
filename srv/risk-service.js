const cds = require('@sap/cds')

/**
 * Implementation for Risk Management service defined in ./risk-service.cds
 */
module.exports = cds.service.impl(async function () {

    const bupa = await cds.connect.to('API_BUSINESS_PARTNER');

    this.on('READ', 'Suppliers', async req => {
        return bupa.run(req.query);
    });

    this.after('READ', 'Risks', risksData => {
        const risks = Array.isArray(risksData) ? risksData : [risksData];
        risks.forEach(risk => {
            if (risk.impact >= 100000) {
                risk.criticality = 1;
            } else {
                risk.criticality = 2;
            }
        });
    });

    const api = await cds.connect.to('Challenge.SAP.API');

    this.on('READ', 'EnviaLote', async req => {
        const lotes = await api.get('/challengeSap/sap/enviaLote');
        console.log(lotes);
        return lotes;
    });
});
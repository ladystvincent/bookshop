const cds = require('@sap/cds');

module.exports = cds.service.impl(async function() {

    const bupa = await cds.connect.to("API_BUSINESS_PARTNER");

    this.on("READ", 'Suppliers', async (req) => {
        req.query.where("SupplierName <> ''");

        return await bupa.transaction(req).send({
            query: req.query,
            headers: {
                apikey: process.env.apikey,
            },
        });
    });

    this.on("READ", 'Books', async (req, next) => {
        if (!req.query.SELECT.columns) return next();
        const expandIndex = req.query.SELECT.columns.findIndex(
            ({ expand, ref }) => expand && ref[0] === "supplier"
        );
        if (expandIndex < 0) return next();

        // Remove expand from query
        req.query.SELECT.columns.splice(expandIndex, 1);

        // Make sure supplier_ID will be returned
        if (!req.query.SELECT.columns.indexOf('*') >= 0 &&
            !req.query.SELECT.columns.find(
                column => column.ref && column.ref.find((ref) => ref == "supplier_ID"))
        ) {
            req.query.SELECT.columns.push({ ref: ["supplier_ID"] });
        }

        const books = await next();

        const asArray = x => Array.isArray(x) ? x : [ x ];

        // Request all associated suppliers
        const supplierIds = asArray(books).map(book => book.supplier_ID);
        const suppliers = await bupa.send({
            query: SELECT.from('AdminService.Suppliers').where({ ID: supplierIds}),
            headers: {
                apikey: process.env.apikey,
            },
        });

        // Convert in a map for easier lookup
        const suppliersMap = {};
        for (const supplier of suppliers)
            suppliersMap[supplier.ID] = supplier;

        // Add suppliers to result
        for (const note of asArray(books)) {
            note.supplier = suppliersMap[note.supplier_ID];
        }
        return books;
    });

});
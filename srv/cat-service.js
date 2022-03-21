const cds = require('@sap/cds')
/**
 * Implementation for Catalog  service defined in ./cat-service.cds
 */
module.exports = cds.service.impl(async function() {
    this.after('READ', 'Books', booksData => {
        const books = Array.isArray(booksData) ? booksData : [booksData];
        books.forEach(book => {
            if (book.stock < 10) {
                book.lowstock = 1;
            } else {
                if (book.stock < 100) {
                    book.lowstock = 2;
                } else {
                    book.lowstock = 3;
                };
            }
        });
    });

    this.on("error",(err,req)=>{
        switch(err.message){
          case"UNIQUE_CONSTRAINT_VIOLATION":
            err.message="The entry already exists.";
            break;
    
          default:
            err.message=
              "An error occured. Please retry. Technical error message: "+
              err.message;
          break;
        }
      });
});
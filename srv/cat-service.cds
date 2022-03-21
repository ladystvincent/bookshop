using { my.bookshop as my } from '../db/schema';

service CatalogService @(path:'/browse') {

   /** For displaying lists of Books */
  @readonly entity ListOfBooks as projection on Books
  excluding { descr };

  /** For display in details pages */
  @readonly entity Books @(restrict : [
      {
          grant : [ 'READ' ],
          to : [ 'BookshopCustomer' ]
      },
      {
          grant : [ '*' ],
          to : [ 'BookshopAdmin' ]
      }
  ]) as projection on my.Books { *,
    author.name as author
  } excluding { supplier, createdBy, modifiedBy };

  //@requires: 'authenticated-user'
  action submitOrder ( book: Books:ID, quantity: Integer ) returns { stock: Integer };
  event OrderedBook : { book: Books:ID; quantity: Integer; buyer: String };
}
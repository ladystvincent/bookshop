using { my.bookshop as my } from '../db/schema';

service AdminService @(path:'/admin'){
  entity Books @(restrict : [
      {
          grant : [ 'READ' ],
          to : [ 'BookshopAuditor' ]
      },
      {
          grant : [ '*' ],
          to : [ 'BookshopAdmin' ]
      }
  ]) as projection on my.Books;
    annotate Books with @odata.draft.enabled;
  entity Authors @(restrict : [
      {
          grant : [ 'READ' ],
          to : [ 'BookshopAuditor' ]
      },
      {
          grant : [ '*' ],
          to : [ 'BookshopAdmin' ]
      }
  ]) as projection on my.Authors;
    annotate Authors with @odata.draft.enabled;
  @readonly entity Suppliers as projection on my.Suppliers;
}

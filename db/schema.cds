using { Currency, managed, sap } from '@sap/cds/common';
namespace my.bookshop;

entity Books : managed {
  key ID : UUID;
  title  : localized String(111);
  descr  : localized String(1111);
  author : Association to Authors;
  genre  : Association to Genres;
  stock  : Integer;
  price  : Decimal(9,2);
  currency : Currency  @assert.integrity: false;
  lowstock : Integer;
  supplier : Association to Suppliers;
}

entity Authors : managed {
  key ID : UUID;
  name   : String(111);
  dateOfBirth  : Date;
  dateOfDeath  : Date;
  placeOfBirth : String;
  placeOfDeath : String;
  books  : Association to many Books on books.author = $self;
}

/** Hierarchically organized Code List for Genres */
entity Genres : sap.common.CodeList {
  key ID   : Integer;
  parent   : Association to Genres;
  children : Composition of many Genres on children.parent = $self;
}

using { API_BUSINESS_PARTNER as bupa } from '../srv/external/API_BUSINESS_PARTNER';

entity Suppliers as projection on bupa.A_Supplier {

    key Supplier as ID,
    SupplierName as suppName,
    PurchasingIsBlocked as isBlocked,
};

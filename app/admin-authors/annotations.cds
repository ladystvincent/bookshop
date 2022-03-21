using AdminService as adserv from '../../srv/admin-service';
using from '../common';


////////////////////////////////////////////////////////////////////////////
//
//	Authors Object Page
//
annotate adserv.Authors with @(UI : {
  HeaderInfo : {
    TypeName : 'Author',
    TypeNamePlural : 'Authors',
  },
  Facets : [
    {
      $Type : 'UI.ReferenceFacet',
      Label : '{i18n>Details}',
      Target : '@UI.FieldGroup#Details'
    },
    {
      $Type : 'UI.ReferenceFacet',
      Label : '{i18n>Books}',
      Target : 'books/@UI.LineItem'
    },
  ],
  FieldGroup #Details : {Data : [
    {Value : placeOfBirth},
    {Value : placeOfDeath},
    {Value : dateOfBirth},
    {Value : dateOfDeath},
  ]},
});
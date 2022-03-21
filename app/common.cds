/*
 Common Annotations shared by all apps
*/
using { my.bookshop as my } from '../db/schema';

//Annotation for labels
annotate my.Books with {
  ID        @title : 'ID';
  title     @title : 'Title';
  author    @title : 'Author' @Common : { 
      Text : author.name,
      TextArrangement : #TextOnly
   };
  genre     @title : 'Genre' @Common : { 
      Text : genre.name,
      TextArrangement : #TextOnly
   };
  price     @title : 'Price' @Measures.ISOCurrency : currency_code;
  stock     @title : 'Stock';
  descr     @title : 'Description' @UI.MultiLineText;
  supplier  @title: 'Supplier' @Common : {
        Text: supplier.suppName,
        TextArrangement: #TextOnly
  };
};

//Annotation for book table
annotate my.Books with @(
    Common.SemanticKey : [ID],
    UI                 :{
        Identification  : [
            {Value : title}
        ],
        SelectionFields  : [
            ID,
            author_ID,
            genre_ID,
            supplier_ID
        ],
        LineItem  : [
            {
                Value : ID,
                Label : 'Title',
                ![@HTML5.CssDefaults] : {width : '100%'}
            },
            {
                Value : author.ID,
                Label : 'Author'
            },
            {Value : genre.name},
            {Value : stock},
            {Value : price},
        ]
    }
){
    ID @Common : { 
        SemanticObject : 'Books',
        Text : title,
        TextArrangement : #TextOnly
     };
     author @(
         Common: {
             ValueList : {
                 Label: 'Authors',
                 CollectionPath : 'Authors',
                 Parameters: [
                    { $Type: 'Common.ValueListParameterInOut',
                        LocalDataProperty: author_ID,
                        ValueListProperty: 'ID'
                    },
                    { $Type: 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty: 'name'
                    }
                 ]
             },
         }
     );
     supplier @(
        Common.ValueList: {
            Label: 'Suppliers',
            CollectionPath: 'Suppliers',
            Parameters: [
                { $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: supplier_ID,
                    ValueListProperty: 'ID'
                },
                { $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'suppName'
                }
            ]
        }
    );
};

//Annotation for book details header
annotate my.Books with @(UI : {HeaderInfo  : {
    $Type : 'UI.HeaderInfoType',
    TypeName : 'Book',
    TypeNamePlural : 'Books',
    Title : {Value : title},
    Description : {Value : author.name}
},
});

//Annotation for Genre
annotate my.Genres with {
    ID   @title : '{i18n>ID}';
    name @title : '{i18n>Genre}';
}

//Annotation for authors (Labels etc.)
annotate my.Authors with {
    ID           @title : '{i18n>ID}';
    name         @title : '{i18n>Name}';
    dateOfBirth  @title : '{i18n>Date Of Birth}';
    dateOfDeath  @title : '{i18n>Date Of Death}';
    placeOfBirth @title : '{i18n>Place Of Birth}';
    placeOfDeath @title : '{i18n>Place Of Death}';
}

//Annotation for Author list
annotate my.Authors with @(
    Common.SemanticKey : [ID],
    UI                 : {
        Identification  : [{Value : name}],
        SelectionFields : [name],
        LineItem        : [
            {
                Value : ID,
                Label : 'Name',
                ![@HTML5.CssDefaults] : {width : '100%'}
            },
            {Value : dateOfBirth},
            {Value : dateOfDeath},
            {Value : placeOfBirth},
            {Value : placeOfDeath},
        ],
    }
) {
    ID  @Common: {
        SemanticObject : 'Authors',
        Text: name,
        TextArrangement : #TextOnly,
    };
};

//Annotation for Author details
annotate my.Authors with @(UI : {
    HeaderInfo : {
        TypeName       : '{i18n>Author}',
        TypeNamePlural : '{i18n>Authors}',
        Title          : {Value : name},
    },
    Facets     : [{
        $Type  : 'UI.ReferenceFacet',
        Target : 'books/@UI.LineItem'
    }, ],
});

//Annotation for Supplier (Labels etc.)
annotate my.Suppliers with {
    ID          @title: 'ID';
    suppName    @title: 'Name';
    isBlocked   @title: 'Supplier Blocked';
}

annotate my.Suppliers with @Capabilities.SearchRestrictions.Searchable : false;
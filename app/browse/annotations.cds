using CatalogService as catserv from '../../srv/cat-service';
using from '../common';

////////////////////////////////////////////////////////////////////////////
//
//	Books Object Page
//
annotate catserv.Books with @(UI : {
    HeaderInfo        : {
        TypeName       : 'Book',
        TypeNamePlural : 'Books',
        Description    : {Value : author}
    },
    HeaderFacets      : [{
        $Type  : 'UI.ReferenceFacet',
        Target : '@UI.FieldGroup#Genre'
    }, ],
    
    Facets            : [
        {$Type  : 'UI.ReferenceFacet', Label  : '{i18n>Details}', Target : '@UI.FieldGroup#Main'}, 
        ],
    FieldGroup #Main : {
        Data : [
            {Value : descr},
            {Value : price}
        ]
    },
    FieldGroup #Genre : {
        $Type : 'UI.FieldGroupType',
        Data : [{Value : genre_ID}]
    },
});

annotate catserv.Books with @(
    Common.SemanticKey : [ID],
    UI                 :{
        Identification  : [
            {Value : title}
        ],
        SelectionFields  : [
            ID,
            author,
            genre_ID
        ],
        LineItem  : [
            {
                Value : ID,
                Label : 'Title',
                ![@HTML5.CssDefaults] : {width : '100%'}
            },
            {
                Value : author,
                Label : 'Author'
            },
            {Value : genre.name},
            {
                Value : stock,
                Criticality : lowstock
            },
            {Value : price},
        ]
    }
){
    ID @Common : { 
        SemanticObject : 'Books',
        Text : title,
        TextArrangement : #TextOnly
     };
};


@EndUserText.label: 'Consumption - Sales Order Header'
@AccessControl.authorizationCheck: #NOT_REQUIRED

@Metadata.allowExtensions: true
@Search.searchable: true
@ObjectModel.semanticKey: [ 'Id' ]

define root view entity ZC_HEADER_1405
provider contract transactional_query
as projection on ZI_HEADER_1405
{
    key Id,
        @Search.defaultSearchElement: true
        Email,
        @Search.defaultSearchElement: true
        FirstName,
        @Search.defaultSearchElement: true
        LastName,
        Country,
        CreatedOn,
        DeliveryDate,
        OrderStatus,
        @Semantics.imageUrl: true
        @UI.textArrangement: #TEXT_ONLY
        ImageUrl,
        
        /* Associations */
        _Item: redirected to composition child ZC_ITEM_1405
}

@EndUserText.label: 'RAP Issue - Adobe Form Rendering'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_RAP_ISSUE_ADOBE_FORMS'

define root custom entity ZCE_RAP_Issue_AdobeForm
{
      @ObjectModel.text.element: ['ProductName']
//      @UI.lineItem: [{ position: 10 }]
//      @UI.selectionField: [{ position: 10 }]
      @EndUserText.label: 'Product'
  key Product     : abap.char(10);

//      @UI.lineItem: [{ position: 20 }]
      @Semantics.text: true
      @EndUserText.label: 'Product Name'
      ProductName : abap.sstring(50);

}

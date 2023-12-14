@EndUserText.label: 'Demo Product: Print'
define abstract entity ZD_RAP_Issue_GetPDFResult
{
  @Semantics.mimeType: true
  @EndUserText.label: 'Mime Type'
  MimeType : abap.sstring(200);

//  @Semantics.largeObject: {
//    contentDispositionPreference: #ATTACHMENT,
//    mimeType: 'MimeType',
//    fileName: 'Filename'
//  }
  @EndUserText.label : 'Image'
  PDF      : abap.rawstring(0);

  @EndUserText.label : 'Filename'
  Filename : abap.sstring(100);
}

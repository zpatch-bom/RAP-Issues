*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations
CLASS lcl_mock DEFINITION CREATE PRIVATE.

  PUBLIC SECTION.
    CLASS-DATA:
      form_templete TYPE xstring READ-ONLY,
      xml_data      TYPE xstring READ-ONLY,
      entity_data   TYPE zcl_rap_issue_adobe_forms=>tt_entities READ-ONLY.

    CLASS-METHODS class_constructor.
  PROTECTED SECTION.
  PRIVATE SECTION.

ENDCLASS.

CLASS lcl_mock IMPLEMENTATION.

  METHOD class_constructor.
    entity_data = VALUE #( ( Product = '1000000001' ProductName = 'ABC' )
                           ( Product = '1000000002' ProductName = 'DEF' )
                           ( Product = '1000000003' ProductName = 'GHI' ) ).
  ENDMETHOD.

ENDCLASS.

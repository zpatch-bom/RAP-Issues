CLASS zcl_rap_issue_adobe_forms DEFINITION
  PUBLIC
  INHERITING FROM cl_xco_cp_adt_simple_classrun
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS get_form_template
      RETURNING
        value(rv_xdp) TYPE xstring.
    CLASS-METHODS get_xml_data
      RETURNING
        value(rv_xml) TYPE xstring.

  PROTECTED SECTION.
    METHODS: main REDEFINITION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcl_rap_issue_adobe_forms IMPLEMENTATION.

  METHOD main.
    get_form_template( ).
  ENDMETHOD.


  METHOD get_form_template.

  ENDMETHOD.

  METHOD get_xml_data.

  ENDMETHOD.

ENDCLASS.

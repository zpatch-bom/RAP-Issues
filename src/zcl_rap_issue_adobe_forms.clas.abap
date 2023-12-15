CLASS zcl_rap_issue_adobe_forms DEFINITION
  PUBLIC
  INHERITING FROM cl_xco_cp_adt_simple_classrun
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
*    For Custom Entity
    INTERFACES:
      if_rap_query_provider.

    TYPES:
      ty_entity   TYPE ZCE_RAP_Issue_AdobeForm,
      tt_entities TYPE SORTED TABLE OF ty_entity WITH UNIQUE KEY Product.

    CLASS-METHODS get_form_template
      RETURNING
        VALUE(rv_xdp) TYPE xstring.

    CLASS-METHODS generate_xml_data
      IMPORTING
        is_entity     TYPE ty_entity
      RETURNING
        VALUE(rv_xml) TYPE xstring.

    CLASS-METHODS get_all_entities
      RETURNING
        VALUE(rt_data) TYPE tt_entities.


  PROTECTED SECTION.
    METHODS: main REDEFINITION.


  PRIVATE SECTION.

    METHODS: __console_write
      IMPORTING
        i_value TYPE any.
ENDCLASS.



CLASS zcl_rap_issue_adobe_forms IMPLEMENTATION.

  METHOD main.
    __console_write( |Entity mock data:| ).
    __console_write( lcl_mock=>entity_data ).
    __console_write( |Form Template: { get_form_template( ) }| ).
    __console_write( |XML Data: { xco_cp=>xstring( generate_xml_data( lcl_mock=>entity_data[ 1 ] )
                                  )->as_string( xco_cp_character=>code_page->utf_8
                                  )->value }| ).

*  DATA(lo_ft) = ycl_sde_adobe_form_template=>create( ).
*  DATA(lv_xdp) =
*    lo_ft->get_template_by_name(
*      iv_get_binary    = abap_true
*      iv_form_name     = 'RAP_Issue'
*      iv_template_name = 'A5'
*    )-xdp_template.
  ENDMETHOD.

  METHOD get_all_entities.
    rt_data = lcl_mock=>entity_data.
  ENDMETHOD.

  METHOD get_form_template.
    rv_xdp = lcl_mock=>form_templete.
  ENDMETHOD.

  METHOD generate_xml_data.
    CALL TRANSFORMATION ztf_rap_issue_adobe_forms
      SOURCE content = is_entity
      RESULT XML rv_xml.
  ENDMETHOD.

  METHOD if_rap_query_provider~select.

    IF NOT io_request->is_data_requested(  ).
      RETURN.
    ENDIF.

    IF io_request->get_entity_id( ) <> 'ZCE_RAP_ISSUE_ADOBEFORM'.
      RETURN.
    ENDIF.

    DATA(lv_offset) = io_request->get_paging( )->get_offset( ).
    DATA(lv_page_size) = io_request->get_paging( )->get_page_size( ).
    DATA(lv_where) = io_request->get_filter( )->get_as_sql_string( ).

    SELECT FROM @lcl_mock=>entity_data AS a
      FIELDS
        a~*
      WHERE (lv_where)
      ORDER BY
        a~Product
      INTO TABLE @DATA(lt_data)
      UP TO @lv_page_size ROWS
      OFFSET @lv_offset.
    IF sy-subrc <> 0.
      RETURN.
    ENDIF.

    io_response->set_data( lt_data ).
    io_response->set_total_number_of_records( lines( lt_data ) ).

  ENDMETHOD.

  METHOD __console_write.
    IF out IS BOUND.
      out->write( i_value ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.

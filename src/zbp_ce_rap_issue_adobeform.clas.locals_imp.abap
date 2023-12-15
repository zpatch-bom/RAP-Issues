CLASS lhc_I1 DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR i1 RESULT result.

    METHODS read FOR READ
      IMPORTING keys FOR READ i1 RESULT result.

    METHODS lock FOR LOCK
      IMPORTING keys FOR LOCK i1.

    METHODS GetPDF FOR MODIFY
      IMPORTING keys FOR ACTION i1~GetPDF RESULT result.



ENDCLASS.

CLASS lhc_I1 IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD lock.
  ENDMETHOD.

  METHOD read.
    DATA lt_result TYPE zcl_rap_issue_adobe_forms=>tt_entities.
    IF keys IS NOT INITIAL.
      lt_result = CORRESPONDING #( zcl_rap_issue_adobe_forms=>get_all_entities( )
                    FROM keys USING KEY entity Product = Product ).
      result = CORRESPONDING #( lt_result ).
    ENDIF.
  ENDMETHOD.

  METHOD GetPDF.
    READ ENTITIES OF ZCE_RAP_Issue_AdobeForm IN LOCAL MODE
      ENTITY i1
      ALL FIELDS WITH CORRESPONDING #( keys )
      RESULT DATA(lt_bo).

    DATA(lv_form_template) = zcl_rap_issue_adobe_forms=>get_form_template( ).

    LOOP AT lt_bo ASSIGNING FIELD-SYMBOL(<ls_bo>).
      DATA(lv_xml_data) = zcl_rap_issue_adobe_forms=>generate_xml_data( CORRESPONDING #( <ls_bo> ) ).

**********************************************************************
* Calling CL_FP_ADS_UTIL in RAP Actions
* RAP BO strict(2)
**********************************************************************
* Sample short-dump
*
* Statement:      "INSERT " is not allowed with this status.
* Runtime Error:  BEHAVIOR_ILLEGAL_STATEMENT
* ...
* In the source code, the termination point is in line 107 of include
* "CL_PROXY_DATA=================CM011".
* include "CL_PROXY_DATA=================CM011".
* ...
*  if with_operation_entry = sprx_true.
*    lt_sproxsig = sproxsig_entry_if_meth_missing(
*                    exporting
*                      object = object
*                      obj_name = obj_name
*                    changing
*                      ct_sproxsig = ct_sproxsig
*                  ).
*    insert sproxsig from table lt_sproxsig.                          <<<<<<<<<<<<<=========== HERE
*  endif.
**********************************************************************
* If the issue is related to the proxy,
* here is the information I can provide.
*
* - Web Service Configuration 'CO_FP_ADS_CONNECT'       - No Proxy
* - RFC Destination for ADS                             - No Proxy
* -- OAuth for the RFC to ADS service on BTP            - Using Proxy
**********************************************************************
      TRY.
          cl_fp_ads_util=>render_pdf(
            EXPORTING
              iv_xml_data   = lv_xml_data
              iv_xdp_layout = lv_form_template
              iv_locale     = 'en_US'
            IMPORTING
              ev_pdf        = DATA(lv_pdf)
          ).

          result = VALUE #( BASE result
            ( %pky = <ls_bo>-%pky
              %param = VALUE #( MimeType = 'application/pdf'
                                pdf      = lv_pdf
                                Filename = |{ <ls_bo>-Product }.pdf| ) ) ).

        CATCH cx_fp_ads_util INTO DATA(lx_error).

          failed-i1 = VALUE #( BASE failed-i1
            ( %fail-cause = if_abap_behv=>cause-unspecific ) ).

          reported-i1 = VALUE #( BASE reported-i1
            ( %msg = CAST #( lx_error ) ) ).
      ENDTRY.
    ENDLOOP.

  ENDMETHOD.


ENDCLASS.

CLASS lsc_ZCE_RAP_ISSUE_ADOBEFORM DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZCE_RAP_ISSUE_ADOBEFORM IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.

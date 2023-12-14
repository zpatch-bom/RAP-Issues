CLASS lhc_ZCE_RAP_Issue_AdobeForm DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS read FOR READ
      IMPORTING keys FOR READ ZCE_RAP_Issue_AdobeForm RESULT result.

    METHODS GetPDF FOR MODIFY
      IMPORTING keys FOR ACTION ZCE_RAP_Issue_AdobeForm~GetPDF RESULT result.

    METHODS PrintPDF FOR MODIFY
      IMPORTING keys FOR ACTION ZCE_RAP_Issue_AdobeForm~PrintPDF.

ENDCLASS.

CLASS lhc_ZCE_RAP_Issue_AdobeForm IMPLEMENTATION.

  METHOD read.
  ENDMETHOD.

  METHOD GetPDF.
  ENDMETHOD.

  METHOD PrintPDF.
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

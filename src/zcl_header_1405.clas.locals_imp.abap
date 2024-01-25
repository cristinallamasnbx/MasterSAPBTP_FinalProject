CLASS lhc_Header DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    CONSTANTS :
      BEGIN OF header_status,
        received   TYPE n LENGTH 1 VALUE 1, " Received
        processing TYPE n LENGTH 1 VALUE 2, " Processing
        shipped    TYPE n LENGTH 1 VALUE 3, " Shipped
        delivered  TYPE n LENGTH 1 VALUE 4, " Delivered
        canceled   TYPE n LENGTH 1 VALUE 5, " Canceled
      END OF header_status,

      BEGIN OF unit_of_measure,
        m  TYPE c LENGTH 2 VALUE 'm',  " millimeters
        cm TYPE c LENGTH 2 VALUE 'cm', " centimeters
        mm TYPE c LENGTH 2 VALUE 'mm', " meters
      END OF unit_of_measure.

    TYPES:
      t_entities_create TYPE TABLE FOR CREATE zr_header_1405\\Header,
      t_entities_update TYPE TABLE FOR UPDATE zr_header_1405\\Header,
      t_failed_Header   TYPE TABLE FOR FAILED EARLY zr_header_1405\\Header,
      t_reported_Header TYPE TABLE FOR REPORTED EARLY zr_header_1405\\Header.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR Header RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR Header RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR Header RESULT result.

    METHODS precheck_create FOR PRECHECK
      IMPORTING entities FOR CREATE Header.

    METHODS precheck_update FOR PRECHECK
      IMPORTING entities FOR UPDATE Header.

ENDCLASS.

CLASS lhc_Header IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF zr_header_1405 IN LOCAL MODE
         ENTITY Header
         FIELDS ( OrderStatus )
         WITH CORRESPONDING #( keys )
    RESULT DATA(lt_headers)
    FAILED failed.

    result = VALUE #(  FOR ls_header IN lt_headers (
        %tky         = ls_header-%tky
        %assoc-_Item = COND #( WHEN ls_header-OrderStatus = header_status-canceled
                               THEN if_abap_behv=>fc-o-disabled
                               ELSE if_abap_behv=>fc-o-enabled )
                             )
    ).
  ENDMETHOD.

  METHOD get_instance_authorizations.
    DATA: lv_update_requested TYPE abap_boolean,
          lv_delete_requested TYPE abap_boolean,
          lv_update_granted   TYPE abap_boolean,
          lv_delete_granted   TYPE abap_boolean.

    READ ENTITIES OF zr_header_1405 IN LOCAL MODE
         ENTITY Header
         ALL FIELDS
         WITH CORRESPONDING #( keys )
         RESULT DATA(lt_headers)
         FAILED failed.

    " TO DO, FIRST DO GLOBAL!
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD precheck_create.
  ENDMETHOD.

  METHOD precheck_update.
  ENDMETHOD.

ENDCLASS.

*"* use this source file for the definition and implementation of
*"* local helper classes, interface definitions and type
*"* declarations

CLASS lhc_travel DEFINITION INHERITING FROM cl_abap_behavior_handler.

  PRIVATE SECTION.

    TYPES tt_travel_update TYPE TABLE FOR UPDATE zi_travel_m_xxx.

    METHODS validate_customer          FOR VALIDATE ON SAVE IMPORTING keys FOR travel~validateCustomer.
    METHODS validate_dates             FOR VALIDATE ON SAVE IMPORTING keys FOR travel~validateDates.
    METHODS validate_agency            FOR VALIDATE ON SAVE IMPORTING keys FOR travel~validateAgency.

    METHODS set_status_completed       FOR MODIFY IMPORTING   keys FOR ACTION travel~acceptTravel              RESULT result.
    METHODS get_features               FOR FEATURES IMPORTING keys REQUEST    requested_features FOR travel    RESULT result.

    METHODS CalculateTravelKey         FOR DETERMINE ON MODIFY IMPORTING keys FOR Travel~CalculateTravelKey.


ENDCLASS.

CLASS lhc_travel IMPLEMENTATION.

********************************************************************************
*
* Implements the dynamic feature handling for travel instances
*
********************************************************************************
  METHOD get_features.

    "%control-<fieldname> specifies which fields are read from the entities

    READ ENTITY zi_travel_m_xxx FROM VALUE #( FOR keyval IN keys
                                                      (  %key                    = keyval-%key
                                                       "  %control-travel_id      = if_abap_behv=>mk-on
                                                         %control-overall_status = if_abap_behv=>mk-on
                                                        ) )
                                RESULT DATA(lt_travel_result).


    result = VALUE #( FOR ls_travel IN lt_travel_result
                       ( %key                           = ls_travel-%key
                         %features-%action-acceptTravel = COND #( WHEN ls_travel-overall_status = 'A'
                                                                    THEN if_abap_behv=>fc-o-disabled ELSE if_abap_behv=>fc-o-enabled   )
                      ) ).

  ENDMETHOD.

  METHOD validate_agency.

    READ ENTITY zi_travel_m_124\\Travel FROM VALUE #(
        FOR <root_key> IN keys ( %key-travel_uuid     = <root_key>-travel_uuid
                                 %control = VALUE #( agency_id = if_abap_behv=>mk-on ) ) )
        RESULT DATA(lt_travel).

    DATA lt_agency TYPE SORTED TABLE OF /dmo/agency WITH UNIQUE KEY agency_id.

    " Optimization of DB select: extract distinct non-initial customer IDs
    lt_agency = CORRESPONDING #( lt_travel DISCARDING DUPLICATES MAPPING agency_id = agency_id EXCEPT * ).
    DELETE lt_agency WHERE agency_id IS INITIAL.
    CHECK lt_agency IS NOT INITIAL.

    " Check if customer ID exist
    SELECT FROM /dmo/agency FIELDS agency_id
      FOR ALL ENTRIES IN @lt_agency
      WHERE agency_id = @lt_agency-agency_id
      INTO TABLE @DATA(lt_agency_db).

    " Raise msg for non existing customer id
    LOOP AT lt_travel INTO DATA(ls_travel).
      IF ls_travel-agency_id IS NOT INITIAL AND NOT line_exists( lt_agency_db[ agency_id = ls_travel-agency_id ] ).
        APPEND VALUE #(  travel_uuid = ls_travel-travel_uuid ) TO failed-travel.
        APPEND VALUE #(  travel_uuid = ls_travel-travel_uuid
                         %msg      = new_message( id       = /dmo/cx_flight_legacy=>agency_unkown-msgid
                                                  number   = /dmo/cx_flight_legacy=>agency_unkown-msgno
                                                  v1       = ls_travel-agency_id
                                                  severity = if_abap_behv_message=>severity-error )
                         %element-agency_id = if_abap_behv=>mk-on ) TO reported-travel.
      ENDIF.

    ENDLOOP.


  ENDMETHOD.

  METHOD calculatetravelkey.

  ENDMETHOD.

  METHOD set_status_completed.

  ENDMETHOD.

  METHOD validate_customer.

  ENDMETHOD.

  METHOD validate_dates.

  ENDMETHOD.

ENDCLASS.

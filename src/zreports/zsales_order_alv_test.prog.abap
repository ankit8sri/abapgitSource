*&---------------------------------------------------------------------*
*& Report ZSALES_ORDER_ALV_TEST
*&---------------------------------------------------------------------*
*& Sales Order ALV Report with Conditional Coloring
*&---------------------------------------------------------------------*
REPORT zsales_order_alv_test.

TABLES: zsflight_test.

TYPES: BEGIN OF ty_flight_data,
         carrid TYPE zsflight_test-carrid,
         connid TYPE zsflight_test-connid,
         fldate TYPE zsflight_test-fldate,
         price TYPE zsflight_test-price,
         currency TYPE zsflight_test-currency,
         seatsmax TYPE zsflight_test-seatsmax,
         seatsocc TYPE zsflight_test-seatsocc,
         color TYPE char4,
       END OF ty_flight_data.

DATA: gt_flight_data TYPE TABLE OF ty_flight_data,
      gs_flight_data TYPE ty_flight_data,
      go_alv TYPE REF TO cl_salv_table.

SELECTION-SCREEN BEGIN OF BLOCK b1 WITH FRAME TITLE TEXT-001.
SELECT-OPTIONS: s_carrid FOR zsflight_test-carrid,
                s_fldate FOR zsflight_test-fldate.
SELECTION-SCREEN END OF BLOCK b1.

START-OF-SELECTION.
  PERFORM get_data.
  PERFORM display_alv.

*&---------------------------------------------------------------------*
*& Form GET_DATA
*&---------------------------------------------------------------------*
FORM get_data.
  SELECT carrid, connid, fldate, price, currency, seatsmax, seatsocc
    FROM zsflight_test
    INTO CORRESPONDING FIELDS OF TABLE gt_flight_data
    WHERE carrid IN s_carrid
      AND fldate IN s_fldate.

  " Set colors based on price
  LOOP AT gt_flight_data INTO gs_flight_data.
    IF gs_flight_data-price < 500.
      gs_flight_data-color = 'C510'.  " Green
    ELSEIF gs_flight_data-price >= 500 AND gs_flight_data-price < 1000.
      gs_flight_data-color = 'C630'.  " Orange
    ELSE.
      gs_flight_data-color = 'C610'.  " Red
    ENDIF.
    MODIFY gt_flight_data FROM gs_flight_data.
  ENDLOOP.
ENDFORM.

*&---------------------------------------------------------------------*
*& Form DISPLAY_ALV
*&---------------------------------------------------------------------*
FORM display_alv.
  DATA: lo_columns TYPE REF TO cl_salv_columns_table,
        lo_column TYPE REF TO cl_salv_column_table,
        lo_color TYPE REF TO cl_salv_colors_table.

  TRY.
      cl_salv_table=>factory(
        IMPORTING r_salv_table = go_alv
        CHANGING t_table = gt_flight_data ).

      " Get columns object
      lo_columns = go_alv->get_columns( ).
      lo_columns->set_optimize( 'X' ).

      " Set column texts
      lo_column ?= lo_columns->get_column( 'CARRID' ).
      lo_column->set_short_text( 'Airline' ).
      lo_column->set_medium_text( 'Airline Code' ).

      lo_column ?= lo_columns->get_column( 'CONNID' ).
      lo_column->set_short_text( 'Connection' ).
      lo_column->set_medium_text( 'Connection ID' ).

      lo_column ?= lo_columns->get_column( 'FLDATE' ).
      lo_column->set_short_text( 'Date' ).
      lo_column->set_medium_text( 'Flight Date' ).

      lo_column ?= lo_columns->get_column( 'PRICE' ).
      lo_column->set_short_text( 'Price' ).
      lo_column->set_medium_text( 'Flight Price' ).

      lo_column ?= lo_columns->get_column( 'CURRENCY' ).
      lo_column->set_short_text( 'Currency' ).
      lo_column->set_medium_text( 'Currency' ).

      lo_column ?= lo_columns->get_column( 'SEATSMAX' ).
      lo_column->set_short_text( 'Max Seats' ).
      lo_column->set_medium_text( 'Maximum Seats' ).

      lo_column ?= lo_columns->get_column( 'SEATSOCC' ).
      lo_column->set_short_text( 'Occupied' ).
      lo_column->set_medium_text( 'Occupied Seats' ).

      " Hide color column
      lo_column ?= lo_columns->get_column( 'COLOR' ).
      lo_column->set_visible( if_salv_c_bool_sap=>false ).

      " Set color column
      lo_color = go_alv->get_colors( ).
      lo_color->set_color_column( 'COLOR' ).

      " Display ALV
      go_alv->display( ).

    CATCH cx_salv_msg.
      MESSAGE 'Error displaying ALV' TYPE 'E'.
  ENDTRY.
ENDFORM.
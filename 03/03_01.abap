*&---------------------------------------------------------------------*
*& Report zmg_aoc_202403
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zmg_aoc_202403.
DATA it_puzzle_input TYPE STANDARD TABLE OF string.

START-OF-SELECTION.
  CALL FUNCTION 'TERM_CONTROL_EDIT'
    EXPORTING  titel          = |Puzzle input|
               langu          = sy-langu
    TABLES     textlines      = it_puzzle_input
    EXCEPTIONS user_cancelled = 1
               OTHERS         = 2.

  DATA(lv_inp_str) = concat_lines_of( table = it_puzzle_input
                                      sep   = '' ).
  DATA lv_sum TYPE sybbigint.
  lv_sum = 0.
  DATA(lo_matcher) = cl_abap_matcher=>create( pattern     = 'mul\([0-9]{1,3},[0-9]{1,3}\)'
                                              text        = lv_inp_str
                                              ignore_case = abap_true ).

  WHILE abap_true = lo_matcher->find_next( ).
    DATA(lv_match) = lo_matcher->get_submatch( 0 ).

    DATA lv_prod TYPE sybbigint.
    lv_prod = 1.
    DATA(lo_matcher_2) = cl_abap_matcher=>create( pattern     = '[0-9]{1,3}'
                                                  text        = lv_match
                                                  ignore_case = abap_true ).
    WHILE abap_true = lo_matcher_2->find_next( ).
      DATA lv_num TYPE i.
      lv_num = lo_matcher_2->get_submatch( 0 ).
      lv_prod *= lv_num.
    ENDWHILE.
    lv_sum += lv_prod.
  ENDWHILE.
  WRITE lv_sum.
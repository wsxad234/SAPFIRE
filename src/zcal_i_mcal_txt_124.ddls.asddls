@EndUserText.label: 'Holiday text'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.dataCategory: #TEXT
define view entity zcal_i_mcal_txt_124
  as select from zcal_holtxt_124
  association        to parent zcal_i_mcal_124 as _Public_Holiday on $projection.Holiday = _Public_Holiday.Holiday
  association [0..*] to I_LanguageText         as _LanguageText   on $projection.Language = _LanguageText.LanguageCode
  association [1..1] to zcal_i_mcal_all_124    as _HolidayAll     on $projection.HolidayAllID = _HolidayAll.HolidayAllID
{
      @Semantics.language: true
  key spras            as Language,
  key holiday_id       as Holiday,
      1                as HolidayAllID,
      @Semantics.text: true
      fcal_description as HolidayDescription,
      _Public_Holiday,
      _LanguageText,
      _HolidayAll
}

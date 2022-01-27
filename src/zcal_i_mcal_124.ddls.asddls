@EndUserText.label: 'Public Holiday'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@ObjectModel.semanticKey: ['Holiday']
define view entity zcal_i_mcal_124
  as select from zcal_holiday_124
  composition [0..*] of zcal_i_mcal_txt_124 as _HolidayTxt
  association to parent zcal_i_mcal_all_124 as _HolidayAll on $projection.HolidayAllID = _HolidayAll.HolidayAllID
{
  key holiday_id       as Holiday,
      1                as HolidayAllID,
      month_of_holiday as HolidayMonth,
      day_of_holiday   as HolidayDay,
      _HolidayTxt,
      _HolidayAll
}

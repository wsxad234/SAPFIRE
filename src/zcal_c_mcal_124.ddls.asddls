@EndUserText.label: 'Projection Holiday'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity ZCAL_C_MCAL_124
  as projection on zcal_i_mcal_124
{
  key Holiday,
      HolidayAllID,
      HolidayMonth,
      HolidayDay,
      _HolidayTxt.HolidayDescription as HolidayDescription : localized,
      /* Associations */
      _HolidayTxt : redirected to composition child ZCAL_C_MCAL_TXT_124,
      _HolidayAll : redirected to parent ZCAL_C_MCAL_ALL_124
}

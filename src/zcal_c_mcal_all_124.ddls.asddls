@EndUserText.label: 'Projection singleton'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@ObjectModel.semanticKey: ['HolidayAllID']
define root view entity ZCAL_C_MCAL_ALL_124
  provider contract transactional_query
  as projection on ZCAL_I_MCAL_ALL_124
{
  key HolidayAllID,
      LastChangedAtMax,
      LocalLastChangedAtMax,
      Request,
      HideTransport,
      /* Associations */
      _Holiday : redirected to composition child zcal_c_mcal_124
}

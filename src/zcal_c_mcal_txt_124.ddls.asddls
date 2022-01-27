@EndUserText.label: 'Projection Holiday Text'
@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
define view entity ZCAL_C_MCAL_TXT_124
  as projection on ZCAL_I_MCAL_TXT_124
{
      @Consumption.valueHelpDefinition: [{entity:{name:'I_Language',element: 'Language'} }]
      @ObjectModel.text.element: ['LanguageDescription']
  key Language,
  key Holiday,
      @Consumption.hidden: true
      HolidayAllID,
      HolidayDescription,
      _LanguageText.LanguageName as LanguageDescription : localized,
      /* Associations */
      _HolidayAll     : redirected to zcal_c_mcal_all_124,
      _Public_Holiday : redirected to parent zcal_c_mcal_124
}

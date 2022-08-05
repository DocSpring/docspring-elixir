# NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
# https://openapi-generator.tech
# Do not edit the class manually.

defmodule Docspring.Model.TemplatestemplateIdaddFieldsFields do
  @moduledoc """
  
  """

  @derive [Poison.Encoder]
  defstruct [
    :"backgroundColorFieldName",
    :"uppercase",
    :"metadata",
    :"barcodeSymbology",
    :"minLength",
    :"integer",
    :"type",
    :"required",
    :"combValueOffset",
    :"imageGravity",
    :"overflow",
    :"qrcodeColor",
    :"colorFieldRequired",
    :"backgroundColorFieldRequired",
    :"id",
    :"imageScaleType",
    :"exclusiveMinimum",
    :"height",
    :"numberConditionRangeExclusiveMax",
    :"invertBooleanCondition",
    :"shapeFillColorFieldName",
    :"static",
    :"shapeBorderColorFieldName",
    :"vAlignment",
    :"bold",
    :"shapeBorderWidth",
    :"combNumberOfCells",
    :"shapeBorderColor",
    :"comb",
    :"typeface",
    :"shapeType",
    :"condition",
    :"displayType",
    :"checkColor",
    :"multilineLines",
    :"multiline",
    :"trueText",
    :"name",
    :"fontSize",
    :"page",
    :"alignment",
    :"maxLength",
    :"autoCalculateMaxLength",
    :"colorFieldName",
    :"qrcodeColorFieldName",
    :"numberConditionRangeMin",
    :"color",
    :"hidden",
    :"checkColorFieldRequired",
    :"combinedFieldFormat",
    :"description",
    :"shapeBorderColorFieldRequired",
    :"combinedFieldNames",
    :"title",
    :"numberConditionRangeExclusiveMin",
    :"combinedFieldSeparator",
    :"exclusiveMaximum",
    :"default",
    :"combinedFieldType",
    :"dateTimeFormat",
    :"qrcodeColorFieldRequired",
    :"currency",
    :"falseText",
    :"placeholder",
    :"strikethrough",
    :"characterSpacing",
    :"numberConditionRangeMax",
    :"backgroundColor",
    :"checkColorFieldName",
    :"checkCharacter",
    :"rotation",
    :"optionList",
    :"shapeFillColor",
    :"stringConditionType",
    :"shapeFillColorFieldRequired",
    :"decimalPlaces",
    :"includeTime",
    :"width",
    :"x",
    :"maximum",
    :"y",
    :"signatureAllowDraw",
    :"numberConditionType",
    :"opacity",
    :"minimum",
    :"signatureAllowType"
  ]

  @type t :: %__MODULE__{
    :"backgroundColorFieldName" => String.t,
    :"uppercase" => boolean(),
    :"metadata" => String.t,
    :"barcodeSymbology" => String.t,
    :"minLength" => float(),
    :"integer" => boolean(),
    :"type" => String.t,
    :"required" => boolean(),
    :"combValueOffset" => float(),
    :"imageGravity" => String.t,
    :"overflow" => String.t,
    :"qrcodeColor" => String.t,
    :"colorFieldRequired" => boolean(),
    :"backgroundColorFieldRequired" => boolean(),
    :"id" => float(),
    :"imageScaleType" => String.t,
    :"exclusiveMinimum" => boolean(),
    :"height" => float(),
    :"numberConditionRangeExclusiveMax" => boolean(),
    :"invertBooleanCondition" => boolean(),
    :"shapeFillColorFieldName" => String.t,
    :"static" => boolean(),
    :"shapeBorderColorFieldName" => String.t,
    :"vAlignment" => String.t,
    :"bold" => boolean(),
    :"shapeBorderWidth" => float(),
    :"combNumberOfCells" => float(),
    :"shapeBorderColor" => String.t,
    :"comb" => boolean(),
    :"typeface" => String.t,
    :"shapeType" => String.t,
    :"condition" => String.t,
    :"displayType" => String.t,
    :"checkColor" => String.t,
    :"multilineLines" => float(),
    :"multiline" => boolean(),
    :"trueText" => String.t,
    :"name" => String.t,
    :"fontSize" => float(),
    :"page" => float(),
    :"alignment" => String.t,
    :"maxLength" => float(),
    :"autoCalculateMaxLength" => boolean(),
    :"colorFieldName" => String.t,
    :"qrcodeColorFieldName" => String.t,
    :"numberConditionRangeMin" => float(),
    :"color" => String.t,
    :"hidden" => boolean(),
    :"checkColorFieldRequired" => boolean(),
    :"combinedFieldFormat" => String.t,
    :"description" => String.t,
    :"shapeBorderColorFieldRequired" => boolean(),
    :"combinedFieldNames" => String.t,
    :"title" => String.t,
    :"numberConditionRangeExclusiveMin" => boolean(),
    :"combinedFieldSeparator" => String.t,
    :"exclusiveMaximum" => boolean(),
    :"default" => String.t,
    :"combinedFieldType" => String.t,
    :"dateTimeFormat" => String.t,
    :"qrcodeColorFieldRequired" => boolean(),
    :"currency" => boolean(),
    :"falseText" => String.t,
    :"placeholder" => String.t,
    :"strikethrough" => boolean(),
    :"characterSpacing" => float(),
    :"numberConditionRangeMax" => float(),
    :"backgroundColor" => String.t,
    :"checkColorFieldName" => String.t,
    :"checkCharacter" => String.t,
    :"rotation" => float(),
    :"optionList" => String.t,
    :"shapeFillColor" => String.t,
    :"stringConditionType" => String.t,
    :"shapeFillColorFieldRequired" => boolean(),
    :"decimalPlaces" => float(),
    :"includeTime" => boolean(),
    :"width" => float(),
    :"x" => float(),
    :"maximum" => float(),
    :"y" => float(),
    :"signatureAllowDraw" => boolean(),
    :"numberConditionType" => String.t,
    :"opacity" => float(),
    :"minimum" => float(),
    :"signatureAllowType" => boolean()
  }
end

defimpl Poison.Decoder, for: Docspring.Model.TemplatestemplateIdaddFieldsFields do
  def decode(value, _options) do
    value
  end
end


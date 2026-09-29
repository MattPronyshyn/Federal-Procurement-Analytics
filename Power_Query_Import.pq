// Query: FactContracts
let
    Source = Csv.Document(
        File.Contents(DataFolder & "\FactContracts.csv"),
        [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]
    ),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    ChangedTypes = Table.TransformColumnTypes(
        PromotedHeaders,
        {
            {"RecordKey", type text}, {"ReferenceNumber", type text}, {"ProcurementID", type text},
            {"ContractDateKey", type date}, {"ContractPeriodStart", type datetime}, {"DeliveryDate", type datetime},
            {"FiscalYear", type text}, {"FiscalQuarter", type text}, {"ReportingPeriod", type text},
            {"VendorKey", type text}, {"OrganizationKey", type text}, {"CategoryKey", type text},
            {"EconomicObjectCode", type text}, {"InstrumentType", type text}, {"SourcingMethod", type text},
            {"VendorCountry", type text}, {"IndigenousProcurement", type text},
            {"IsCompetitive", type logical}, {"IsNonCompetitive", type logical},
            {"IsDomesticVendor", type logical}, {"IsIndigenousProcurement", type logical},
            {"ReportedTotalContractValue", Currency.Type}, {"ReportedOriginalValue", Currency.Type},
            {"ReportedAmendmentValue", Currency.Type}, {"ActivityValue", Currency.Type},
            {"NewContractValue", Currency.Type}, {"AmendmentValue", Currency.Type},
            {"AbsoluteAmendmentValue", Currency.Type}, {"NumberOfBids", Int64.Type},
            {"AwardCriteriaCode", type text}, {"ContractDurationDays", Int64.Type},
            {"ContractingEntity", type text}, {"MissingVendor", type logical},
            {"MissingContractDate", type logical}, {"MissingSolicitation", type logical},
            {"MissingDescription", type logical}
        },
        "en-CA"
        ),
    DatesOnly = Table.TransformColumns(
        ChangedTypes,
        {
            {"ContractPeriodStart", DateTime.Date, type date},
            {"DeliveryDate", DateTime.Date, type date}
        }
    )
in
    DatesOnly

// Query: DimVendor
let
    Source = Csv.Document(File.Contents(DataFolder & "\DimVendor.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    ChangedTypes = Table.TransformColumnTypes(PromotedHeaders, {{"VendorKey", type text}, {"VendorName", type text}, {"VendorNameSource", type text}, {"VendorCountry", type text}, {"VendorPostalCode", type text}}, "en-CA")
in
    ChangedTypes

// Query: DimOrganization
let
    Source = Csv.Document(File.Contents(DataFolder & "\DimOrganization.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    ChangedTypes = Table.TransformColumnTypes(PromotedHeaders, {{"OrganizationKey", type text}, {"OrganizationCode", type text}, {"OrganizationName", type text}}, "en-CA")
in
    ChangedTypes

// Query: DimCategory
let
    Source = Csv.Document(File.Contents(DataFolder & "\DimCategory.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    ChangedTypes = Table.TransformColumnTypes(PromotedHeaders, {{"CategoryKey", type text}, {"CommodityTypeCode", type text}, {"CommodityCode", type text}, {"CategoryDescription", type text}, {"CommodityType", type text}}, "en-CA")
in
    ChangedTypes

// Query: DimDate
let
    Source = Csv.Document(File.Contents(DataFolder & "\DimDate.csv"), [Delimiter = ",", Encoding = 65001, QuoteStyle = QuoteStyle.Csv]),
    PromotedHeaders = Table.PromoteHeaders(Source, [PromoteAllScalars = true]),
    ChangedTypes = Table.TransformColumnTypes(PromotedHeaders, {{"Date", type date}, {"Year", Int64.Type}, {"MonthNumber", Int64.Type}, {"Month", type text}, {"MonthYear", type text}, {"Quarter", type text}, {"FiscalYear", type text}, {"FiscalQuarter", type text}, {"FiscalYearQuarter", type text}, {"MonthSort", Int64.Type}}, "en-CA")
in
    ChangedTypes

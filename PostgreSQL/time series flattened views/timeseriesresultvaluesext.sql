-- View: odm2extra.timeseriesresultvaluesext

-- DROP MATERIALIZED VIEW odm2extra.timeseriesresultvaluesext;

CREATE MATERIALIZED VIEW odm2extra.timeseriesresultvaluesext AS 
 SELECT timeseriesresultvalues.valueid,
    timeseriesresultvalues.datavalue,
    timeseriesresultvalues.valuedatetime,
    timeseriesresultvalues.valuedatetimeutcoffset,
    timeseriesresultvalues.censorcodecv,
    timeseriesresultvalues.qualitycodecv,
    timeseriesresultvalues.timeaggregationinterval,
    timeseriesresultvalues.timeaggregationintervalunitsid,
    samplingfeatures.samplingfeaturename,
    samplingfeatures.samplingfeaturetypecv,
    processinglevels.processinglevelcode,
    variables.variablecode,
    units.unitsabbreviation,
    timeseriesresultvalues.resultid,
    cv_aggregationstatistic.name AS aggregationstatisticname
   FROM odm2.timeseriesresultvalues,
    odm2.timeseriesresults,
    odm2.results,
    odm2.featureactions,
    odm2.samplingfeatures,
    odm2.processinglevels,
    odm2.variables,
    odm2.units,
    odm2.cv_aggregationstatistic
  WHERE timeseriesresultvalues.resultid = timeseriesresults.resultid AND timeseriesresults.resultid = results.resultid AND timeseriesresults.aggregationstatisticcv::text = cv_aggregationstatistic.name::text AND results.featureactionid = featureactions.featureactionid AND results.processinglevelid = processinglevels.processinglevelid AND results.variableid = variables.variableid AND results.unitsid = units.unitsid AND featureactions.samplingfeatureid = samplingfeatures.samplingfeatureid
  ORDER BY timeseriesresultvalues.datavalue DESC;

ALTER TABLE odm2extra.timeseriesresultvaluesext
  OWNER TO postgres;
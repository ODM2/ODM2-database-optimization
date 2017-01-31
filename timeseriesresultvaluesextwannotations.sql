-- View: odm2extra.timeseriesresultvaluesextwannotations

-- DROP VIEW odm2extra.timeseriesresultvaluesextwannotations;

CREATE OR REPLACE VIEW odm2extra.timeseriesresultvaluesextwannotations AS 
 SELECT tsrv.valueid,
    tsrv.datavalue,
    tsrv.valuedatetime,
    tsrv.valuedatetimeutcoffset,
    tsrv.censorcodecv,
    tsrv.qualitycodecv,
    tsrv.timeaggregationinterval,
    tsrv.timeaggregationintervalunitsid,
    samplingfeatures.samplingfeaturename,
    samplingfeatures.samplingfeaturetypecv,
    processinglevels.processinglevelcode,
    variables.variablecode,
    units.unitsabbreviation,
    tsrv.resultid,
    cv_aggregationstatistic.name AS aggregationstatisticname,
    annotations.annotationtext
   FROM odm2.timeseriesresultvalues tsrv
     LEFT JOIN odm2.timeseriesresultvalueannotations a ON tsrv.valueid = a.valueid
     LEFT JOIN odm2.annotations b ON a.annotationid = b.annotationid,
    odm2.results,
    odm2.timeseriesresults,
    odm2.featureactions,
    odm2.samplingfeatures,
    odm2.processinglevels,
    odm2.variables,
    odm2.units,
    odm2.cv_aggregationstatistic,
    odm2.annotations
  WHERE tsrv.resultid = timeseriesresults.resultid AND timeseriesresults.resultid = results.resultid AND timeseriesresults.aggregationstatisticcv::text = cv_aggregationstatistic.name::text AND results.featureactionid = featureactions.featureactionid AND results.processinglevelid = processinglevels.processinglevelid AND results.variableid = variables.variableid AND results.unitsid = units.unitsid AND featureactions.samplingfeatureid = samplingfeatures.samplingfeatureid
  ORDER BY tsrv.datavalue DESC;

ALTER TABLE odm2extra.timeseriesresultvaluesextwannotations
  OWNER TO postgres;

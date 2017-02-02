CREATE VIEW timeseriesresultvaluesextwannotations AS 
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
    b.annotationtext
   FROM timeseriesresultvalues tsrv
     LEFT JOIN timeseriesresultvalueannotations a ON tsrv.valueid = a.valueid
     LEFT JOIN annotations b ON a.annotationid = b.annotationid,
    results,
    timeseriesresults,
    featureactions,
    samplingfeatures,
    processinglevels,
    variables,
    units,
    cv_aggregationstatistic
  WHERE tsrv.resultid = timeseriesresults.resultid AND timeseriesresults.resultid = results.resultid AND timeseriesresults.aggregationstatisticcv = cv_aggregationstatistic.name AND results.featureactionid = featureactions.featureactionid AND results.processinglevelid = processinglevels.processinglevelid AND results.variableid = variables.variableid AND results.unitsid = units.unitsid AND featureactions.samplingfeatureid = samplingfeatures.samplingfeatureid
  ORDER BY tsrv.datavalue DESC;
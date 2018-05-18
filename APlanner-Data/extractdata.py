
# API details: https://classes.cornell.edu/content/FA17/api-details
# https://<HOST>/api/<VERSION>/<method>.<responseFormat>?parameters 
# 

import urllib2
import json
import csv
from datetime import timedelta, date
import sys
import codecs
# This is the api to get historical weather qualities
path = 'https://classes.cornell.edu/api/2.0/search/classes.json?roster=FA17&subject=CS'
f = urllib2.urlopen(path)
json_string = f.read()
parsed_json = json.loads(json_string)
# parsed_json
classes = parsed_json["data"]["classes"]

writer = csv.writer(open("CUCSFA17.csv","w"))
writer.writerow(["subject","crseId","catalogDistr","crseOfferNbr","catalogWhenOffered","catalogComments","catalogCourseSubfield" ,"titleShort","catalogForbiddenOverlaps","description","acadCareer","catalogPrereqCoreq","gradingBasis","unitsMinimum" ,"classSections","sessionCode" ,"sessionLong" ,"componentsOptional" ,"catalogNbr" ,"acadGroup" ,"catalogPermission" ,"titleLong" ,"catalogBreadth" ,"catalogLang"])

for cl in classes:
	catalogFee = cl['catalogFee']
	catalogAttribute = cl['catalogAttribute']
	catalogSatisfiesReq = cl['catalogSatisfiesReq']
	catalogOutcomes = cl['catalogOutcomes']
	subject = cl['subject']
	crseId = cl['crseId']
	catalogDistr = cl['catalogDistr']
	crseOfferNbr = cl['crseOfferNbr']
	catalogWhenOffered = cl['catalogWhenOffered']
	if not cl['catalogComments']:
		catalogComments = ""
	else: catalogComments = cl['catalogComments'].encode('utf-8')
	catalogCourseSubfield = cl['catalogCourseSubfield']
	titleShort = cl['titleShort']
	if not cl['catalogForbiddenOverlaps']: catalogForbiddenOverlaps = ""
	else: catalogForbiddenOverlaps = cl['catalogForbiddenOverlaps'].encode('utf-8')
	if not cl['description'] :
		description = ""
	else:
		description = cl['description'].encode('utf-8')
	acadCareer = cl['acadCareer']
	if not cl['catalogPrereqCoreq']: catalogPrereqCoreq = ""
	else:catalogPrereqCoreq = cl['catalogPrereqCoreq'].encode('utf-8')
	enrollGroups = cl['enrollGroups'][0]
	gradingBasisLong = enrollGroups['gradingBasisLong']
	gradingBasisShort = enrollGroups['gradingBasisShort']
	sessionBeginDt = enrollGroups['unitsMaximum']
	simpleCombinations = enrollGroups['simpleCombinations']
	componentsRequired = enrollGroups['componentsRequired']
	gradingBasis = enrollGroups['gradingBasis']
	unitsMinimum = enrollGroups['unitsMinimum']
	classSections = enrollGroups['classSections']
	sessionCode = enrollGroups['sessionCode']
	sessionLong = enrollGroups['sessionLong']
	componentsOptional = enrollGroups['componentsOptional']
	catalogNbr = cl['catalogNbr']
	acadGroup = cl['acadGroup']
	if not cl['catalogPermission']: catalogPermission = ""
	else:catalogPermission = cl['catalogPermission'].encode('utf-8')
	strm = cl['strm']
	titleLong = cl['titleLong']
	catalogBreadth = cl['catalogBreadth']
	catalogLang = cl['catalogLang']
	writer.writerow([subject,crseId,catalogDistr,crseOfferNbr,catalogWhenOffered,catalogComments,catalogCourseSubfield ,titleShort,catalogForbiddenOverlaps,description,acadCareer,catalogPrereqCoreq,gradingBasis,unitsMinimum,classSections,sessionCode,sessionLong,componentsOptional,catalogNbr ,acadGroup,catalogPermission,titleLong ,catalogBreadth ,catalogLang])
	
#[u'catalogFee', u'catalogAttribute', u'catalogSatisfiesReq', u'catalogOutcomes', u'subject', u'crseId', u'catalogDistr', u'crseOfferNbr', 
#u'catalogWhenOffered', u'catalogComments', u'catalogCourseSubfield', u'titleShort', u'catalogForbiddenOverlaps', u'description', u'acadCareer', 
#u'catalogPrereqCoreq', u'enrollGroups', u'catalogNbr', u'acadGroup', u'catalogPermission', u'strm', u'titleLong', u'catalogBreadth', u'catalogLang']

	
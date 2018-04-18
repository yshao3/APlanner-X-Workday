
import urllib2
import json
import unicodedata
import csv
from datetime import timedelta, date
import sys
import codecs
from pymongo import MongoClient
import json

def importcourse(db,data):
	data1 = []
	data2 = set()
	writer = csv.writer(open("CUcleaned.csv","w"))
	for d in data:
		subject = d[0].lower()
		number = d[18].lower()
		if subject + " " + number in data1:
			continue
		else:
			data2.add(subject + " " + number)
		title = d[21].lower()
		total = d[11].lower()

		when_offer = []
		offer = d[4].lower().replace(".","").split(",")
		for i in offer:
			when_offer.append(i.strip())
		min_unit = int(d[13])
		description = d[9].decode('unicode_escape').encode('ascii','ignore')
		tags = d[24].split(",")
		dic = {}
		prerequisite = []
		corequisite =[]
		notcur =[]
		preorcor = []
		try:
			dic["pre"] = total.index("prerequisite:")
		except:
			dic["pre"] = -1
		try:
			try:
				if total.index("prerequisite or corequisite:") < total.index("corequisite:"):
					dic["core"] = -1
				else:
					dic["core"] = total.index("corequisite:")
			except:
				dic["core"] = total.index("corequisite:")
		except:
			dic["core"] = -1
		
		if dic["pre"] != -1 and dic["core"] != -1:
			r = total[dic["pre"]+13:dic["core"]]
			res = r.split("and")
			r = ";".join(res)
			res = r.split(";")
			for i in res:
				tmp = i.split(",")
				j = "or".join(tmp)
				tmp = j.split("or")
				array = []
				for t in tmp:
					s = t.strip()
					array.append(s)
				prerequisite.append(",".join(array))
		try:
			dic["preorcor"] = total.index("prerequisite or corequisite:")
		except:
			dic["preorcor"] = -1
		if dic["preorcor"] != -1:
			if dic["core"] != -1:
				r = total[dic["core"]+12:dic["preorcor"]]
				res = r.split("and")
				r = ";".join(res)
				res = r.split(";")
				for i in res:
					tmp = i.split(",")
					j = "or".join(tmp)
					tmp = j.split("or")
					array = []
					for t in tmp:
						s = t.strip()
						array.append(s)
					corequisite.append(",".join(array))
			elif dic["pre"] != -1:
				r = total[dic["pre"]+13:dic["preorcor"]]
				res = r.split("and")
				r = ";".join(res)
				res = r.split(";")
				for i in res:
					tmp = i.split(",")
					j = "or".join(tmp)
					tmp = j.split("or")
					array = [] 
					for t in tmp:
						s = t.strip()
						array.append(s)
					prerequisite.append(",".join(array))

		try:
			dic["notcur"] = total.index("not concurrently:")
		except:
			dic["notcur"] = -1
		
		if dic["notcur"] != -1:
			r = total[dic["notcur"]+len("not concurrently:"):]
			res = r.split("and")
			r = ";".join(res)
			res = r.split(";")
			for i in res:
				tmp = i.split(",")
				j = "or".join(tmp)
				tmp = j.split("or")
				array = []
				for t in tmp:
					s = t.strip()
					array.append(s)
				notcur.append(",".join(array))
			if dic["preorcor"] != -1:
				r = total[dic["preorcor"]+len("prerequisite or corequisite:"):dic["notcur"]]
				res = r.split("and")
				r = ";".join(res)
				res = r.split(";")
				for i in res:
					tmp = i.split(",")
					j = "or".join(tmp)
					tmp = j.split("or")
					array = []
					for t in tmp:
						s = t.strip()
						array.append(s)
					corequisite.append(",".join(array))
			elif dic["core"] != -1:
				r = total[dic["core"]+12:dic["notcur"]]
				res = r.split("and")
				r = ";".join(res)
				res = r.split(";")
				for i in res:
					tmp = i.split(",")
					j = "or".join(tmp)
					tmp = j.split("or")
					array = []
					for t in tmp:
						s = t.strip()
						array.append(s)
					corequisite.append(",".join(array))
			elif dic["pre"] != -1:
				r = total[dic["pre"]+13:dic["notcur"]]
				res = r.split("and")
				r = ";".join(res)
				res = r.split(";")
				for i in res:
					tmp = i.split(",")
					j = "or".join(tmp)
					tmp = j.split("or")
					array = []
					for t in tmp:
						s = t.strip()
						array.append(s)
					prerequisite.append(",".join(array))
		else:
			if dic["preorcor"] != -1:
				r = total[dic["preorcor"]+len("prerequisite or corequisite:"):]
				res = r.split("and")
				r = ";".join(res)
				res = r.split(";")
				for i in res:
					tmp = i.split(",")
					j = "or".join(tmp)
					tmp = j.split("or")
					array = []
					for t in tmp:
						s = t.strip()
						array.append(s)
					corequisite.append(",".join(array))
			elif dic["core"] != -1:
				r = total[dic["core"]+12:]
				res = r.split("and")
				r = ";".join(res)
				res = r.split(";")
				for i in res:
					tmp = i.split(",")
					j = "or".join(tmp)
					tmp = j.split("or")
					array = []
					for t in tmp:
						s = t.strip()
						array.append(s)
					corequisite.append(",".join(array))
			elif dic["pre"] != -1:
				r = total[dic["pre"]+len("prerequisite:"):]
				res = r.split("and")
				r = ";".join(res)
				res = r.split(";")
				for i in res:
					tmp = i.split(",")
					j = "or".join(tmp)
					tmp = j.split("or")
					array = []
					for t in tmp:
						s = t.strip()
						array.append(s)
					prerequisite.append(",".join(array))
		
		# print [subject+" "+number,title,description,",".join(when_offer),",".join(tags),";".join(prerequisite), ";".join(notcur)]
		# data1.append([subject+" "+number,title,description,",".join(when_offer),",".join(tags),";".join(prerequisite), ";".join(notcur)])
		
		db.courses.insert({"subject":subject, "number":number, "title":title, "prerequisite":prerequisite, "corequisite":corequisite, "notcur":notcur, "preorcor":preorcor, "tags":tags, "when_offer": when_offer,"description":description})
	# data1[subject+" "+ number] = prerequisite
	# print data1
	# with open('data.json', 'w') as fp:
	# 	json.dump(data1, fp)
		



			

		



		




reader = csv.reader(open("CUCSFA17-cleaned.csv","r"))
reader.next()
data = []
for row in reader:
	data.append(row)
# print len(data[0])
# for i in range(0, 24):
# 	print (i, data[8][i])

client = MongoClient("127.0.0.1:27017")
db = client["test"]
# for i in  db.courses.find({}):
# 	print i
importcourse(db, data)

# d = dict((db, [collection for collection in client[db].collection_names()]) for db in client.database_names())

# print json.dumps(d["mydb"])
# db=client.admin


# Issue the serverStatus command and print the results
# serverStatusResult=db.command("serverStatus")
# pprint(db.collection_names(include_system_collections=True))
# pprint(serverStatusResult)
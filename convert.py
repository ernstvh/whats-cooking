import json
import codecs


f = codecs.open('train.json', 'r', 'utf-8')
csv = codecs.open('train.csv', 'w', 'utf-8')

data = json.load(f)

csv.write("recipe,cuisine,ingredient\n")
for d in data:
	for i in d['ingredients']:
		csv.write(str(d['id']))
		csv.write(",")
		csv.write(d['cuisine'])
		csv.write(",")
		csv.write(i)
		csv.write("\n")

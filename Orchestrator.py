from nlp import nlp
from pyswip import *

p = Prolog()
p.consult("dialogue_manager.pl")
assertz = Functor("assertz", 1)
retract = Functor("retract", 1)
ans = Functor("ans", 1)
greetings = ["Hi", "Hello", "Good morning", "Good afternoon", "Good evening"]
how = ["How are you?", "How are you doing?", "How is it going?"] 
thank = ["Thank you", "Thanks", "Thank you very much", "Thanks a lot"]
bye = ["Bye", "See you"]
vrb =''
obj = ''
frm = ''
to = ''

def parse(m):
	prs = nlp(m)
	return(prs['sentences'][0]['parse'])

def process(m):
	#Counting number of verbs, nouns and prepositions
	nmb_vb = 0
	indxfrom = 0
	indxto = 0
	indexvb = []
	vrb=""
	obj=""
	frm=""
	to=""
	for i in range(len(m)-2):
		if m[i]+m[i+1] == ('VB'): 
			nmb_vb += 1
			indexvb.append(i)
	indexvb.append(len(m)-6)
	if nmb_vb == 0 :
		for j in range(len(m)-6):
			if m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4]+m[j+5]+m[j+6] == ('IN from'):
				indxfrom=j
			elif (m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4] == ('TO to')) or (m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4] == ('IN in')) or (m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4] == ('IN on')) or (m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4]+m[j+5]+m[j+6] == ('RB here'))or (m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4]+m[j+5]+m[j+6] == ('EX ther')):
				indxto=j

		if indxfrom != 0 and indxto != 0:
			for n in range(indxfrom):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
			for n in range(indxfrom, indxto):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1] == ('EX'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1] == ('RB'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
			for n in range(indxto, len(m)-2):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1] == ('EX'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1] == ('RB'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
		if indxfrom != 0 and indxto == 0:
			for n in range(indxfrom):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
			for n in range(indxfrom, len(m)-2):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1] == ('EX'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1] == ('RB'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'

		if indxfrom == 0 and indxto != 0:
			for n in range(indxto):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
			for n in range(indxto, len(m)-2):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1] == ('EX'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1] == ('RB'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
		if indxfrom == 0 and indxto == 0:
			for n in range(len(m)-2):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'	
	for k in range(0,nmb_vb):
		vrb=""
		obj=""
		frm=""
		to=""
		indxfrom=0
		indxto=0
		for j in range(indexvb[k], indexvb[k+1]):
			if m[j]+m[j+1] == ('VB'):
				l = j+3
				while (m[l] != ')'):
					vrb+=str(m[l])
					l+=1
			elif m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4]+m[j+5]+m[j+6] == ('IN from'):
				indxfrom=j
			elif (m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4] == ('TO to')) or (m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4] == ('IN in')) or (m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4] == ('IN on')) or (m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4]+m[j+5]+m[j+6] == ('RB here'))or (m[j]+m[j+1]+m[j+2]+m[j+3]+m[j+4]+m[j+5]+m[j+6] == ('EX ther')):
				indxto=j

		if indxfrom != 0 and indxto != 0:
			for n in range(indexvb[k], indxfrom):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
			for n in range(indxfrom, indxto):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1] == ('EX'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1] == ('RB'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
			for n in range(indxto, indexvb[k+1]):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1] == ('EX'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1] == ('RB'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
		if indxfrom != 0 and indxto == 0:
			for n in range(indexvb[k], indxfrom):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
			for n in range(indxfrom, indexvb[k+1]):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1] == ('EX'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'
				if m[n]+m[n+1] == ('RB'):
					l = n+3
					while (m[l] != ')'):
						frm+=str(m[l])
						l+=1
					frm+='_'

		if indxfrom == 0 and indxto != 0:
			for n in range(indexvb[k], indxto):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
			for n in range(indxto, indexvb[k+1]):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1] == ('EX'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
				if m[n]+m[n+1] == ('RB'):
					l = n+3
					while (m[l] != ')'):
						to+=str(m[l])
						l+=1
					to+='_'
		if indxfrom == 0 and indxto == 0:
			for n in range(indexvb[k], indexvb[k+1]):
				if m[n]+m[n+1] == ('NN'):
					l = n+3
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'
				if m[n]+m[n+1]+m[n+2] == ('PRP'):
					l = n+4
					while (m[l] != ')'):
						obj+=str(m[l])
						l+=1
					obj+='_'	

	obj = obj[:-1]
	frm = frm[:-1]		
	to = to[:-1]
	if vrb == "":
		vrb = 'none'
	if obj == "" :
		obj = 'none'
	if frm == "" :
		frm = 'none'
	if to == "" :
		to = 'none'
	p.query(retract("ans(t)"))
	list(p.query(('{}({}, {}, {})'.format(vrb, obj, frm, to))))
	p.query('check(t)')

quit = False
print('Welcome')
while quit == False:
	txt = raw_input()
	if txt in greetings : print("Hi")
	elif txt in how : print("I am fine, thanks for asking")
	elif txt in thank : print("You're welcome")
	elif txt in bye : 
		print("Bye")
		quit = True
	else:
		pm = parse(txt)
		process(pm)

#去除tab与回车符链接字符串
polya_file = open('/home/workstation/polya_1000line_demo','r')
line = polya_file.readlines()
str_new = ''
for str in line:
	str_tmp = str.replace('\t','\\t')
	str_tmp = str_tmp.replace('\n','\\n')
	str_new += str_tmp
'''
def strcpy(str1,str2):
	str1 += str2
	return str1
output = reduce(strcpy,line)
'''
#output = ''.join(line)
output_file = file('/home/workstation/output','w+')
output_file.write(str_new)
output_file.close()
#print str_new

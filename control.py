import urllib.request


path= '/proc/asound/card0/pcm0p/sub0/status'
with open(path, 'r') as file:  
	data = file.read() 
	print(data)

if (data == "closed"):
	page1 = urllib.request.urlopen("http://192.168.1.72/VCR1")
	print("hello world is closed")

else:
	page = urllib.request.urlopen("http://192.168.1.72/VCR2")
	print("hello world is open yyyyayayayayaay")

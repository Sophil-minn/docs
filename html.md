multipart/form-data：既可以上传文件等二进制数据,也可以上传表单键值对,只是最后会转化为一条信息. 
x-www-form-urlencoded：只能上传键值对,并且键值对都是间隔分开的.
binary相当于Content-Type:application/octet-stream,从字面意思得知,只可以上传二进制数据,通常用来上传文件,由于没有键值,所以一次只能上传一个文件。
raw
可以上传任意格式的文本,可以上传text、json、xml、html等
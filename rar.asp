<%
dim dbfile,fso,sql
mdbfile="pop.mdb" '�������������ݿ�����
dbfile=server.MapPath(mdbfile)
Set FSO = CreateObject("Scripting.FileSystemObject")
'������ݿ���ھ�ɾ��ԭ������
if fso.FileExists(dbfile) then
fso.DeleteFile(dbfile)
end if
set fso=nothing
'��ʼ�������ݿ�
set cat=server.CreateObject("ADOX.Catalog")
'����access2000�����ݿ�
cat.Create "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & dbfile
set cat=nothing
if err.number=0 then
Response.Write "���ݿ� " & dbfile & " �����ɹ�<br> "
else
Response.Write "���ݿⴴ��ʧ�ܣ�ԭ�� " & err.description
Response.End
end if
'��ʼ����
Set Conn = Server.CreateObject("ADODB.Connection")
Conn.Open "Provider=Microsoft.Jet.OLEDB.4.0; Data Source=" & dbfile
'������
sql="Create TABLE filedata([id] counter PRIMARY KEY,[path] Memo,[file] General)"
conn.execute(sql)
Set rs = CreateObject("ADODB.RecordSet")
rs.Open "FileData", conn, 1, 3
set obj=server.createobject("scripting.filesystemobject")
'�����վ��Ŀ¼
set objfolder=obj.getfolder(server.mappath("/"))
'��ʼ�����ļ�
search objfolder
response.write("������ToBa�����,������")
'�ļ���������
function search(objfolder)
dim objsubfolder
for each objfile in objfolder.files
Set objStream = Server.CreateObject("ADODB.Stream")
a=a+1
objStream.Type = 1
objStream.Open
response.write a &"<br>"
response.write objfile.path &"<br>"
'�������ݿⱾ���.LDB�ļ�
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
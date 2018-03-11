using System;
using System.Web;
using QianZhu.Model;
using QianZhu.Utility;

public partial class plugin_ueditor_dialogs_attachment_attachment : System.Web.UI.Page
{
    public FilespecModel filespec = null;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        filespec = new QianZhu.BLL.Filespec().GetModelByCode(Request.QueryString["code"]);
        if (filespec == null) Response.End();
    }
}
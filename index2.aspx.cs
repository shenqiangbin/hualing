using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;
public partial class index2 : System.Web.UI.Page
{
    private GlobalConfig bll_config = new GlobalConfig();
    protected void Page_Load(object sender, EventArgs e)
    {
        bll_config.Load(new string[] { "pageTitle", "keywords", "descn", "video" });
        //Title
        Page.Title = bll_config["pageTitle"];
        //KeyWord
        WebUtility.CreateMeta(Page, "keywords", bll_config["keywords"]);
        //Description
        WebUtility.CreateMeta(Page, "description", bll_config["descn"]);
    }
}

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_filespecManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Filespec bll_filespec = new Filespec();

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        
        if (!Page.IsPostBack)
        {
            Action();
            BindInfo();
        }
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        //搜索控件
        MyTitle.Value = Request.QueryString["title"];
        Code.Value = Request.QueryString["code"];
        
        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(FilespecModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(FilespecModel.CODE, SqlWhere.Oper.Equal, Request.QueryString["code"]));
        List<FilespecModel> filespecList = bll_filespec.GetList(sqlWhereList);

        //绑定
        if (filespecList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = filespecList;
        Repeater1.DataBind();
    }

    /// <summary>
    /// 执行操作的方法
    /// </summary>
    private void Action()
    {
        string cmd = Request["cmd"];
        if (String.IsNullOrEmpty(cmd)) return;
        string ids = Request.QueryString["ids"];

        if (cmd == "del") bll_filespec.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        FilespecModel filespec = (FilespecModel)e.Item.DataItem;
        if (filespec.Filesize > 0) ((HtmlTableCell)e.Item.FindControl("Eval_Size")).InnerHtml = filespec.Filesize.ToString() + " KB";
        else ((HtmlTableCell)e.Item.FindControl("Eval_Size")).InnerHtml = "不限制";

        string nameFormat = filespec.NameFormat;
        if (String.IsNullOrEmpty(nameFormat)) nameFormat = "原名";
        ((HtmlTableCell)e.Item.FindControl("Eval_Path")).InnerHtml = filespec.SavePath + nameFormat + ".*";
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        httpHelper.AddUrlParm("code", Code.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}
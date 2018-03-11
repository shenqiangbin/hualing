using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_categoryGroupManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Category bll_category = new Category();

    public string param = WebUtility.GetUrlParams("&", true);
    private int total = 0;
    
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
        WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);
        
        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(CategoryModel.ILEVEL, SqlWhere.Oper.Equal, 1));
        sqlWhereList.Add(new SqlWhere(CategoryModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(CategoryModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));
        List<CategoryModel> categoryList = bll_category.GetList(sqlWhereList);
        total = categoryList.Count;

        //绑定
        if (categoryList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = categoryList;
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

        if (cmd == "moveup") bll_category.MoveUp(ids);
        else if (cmd == "movedown") bll_category.MoveDown(ids);
        else if (cmd == "enab") bll_category.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_category.Delete(ids, true);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        CategoryModel category = (CategoryModel)e.Item.DataItem;
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_category.GetStatus(category, "enab");
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(category.CreateTime);

        if (e.Item.ItemIndex == 0) ((HtmlGenericControl)e.Item.FindControl("Eval_MoveUp")).InnerHtml = "<a class=\"icon icon_empty\"></a>";
        else ((HtmlGenericControl)e.Item.FindControl("Eval_MoveUp")).InnerHtml = "<a href=\"javascript:;\" onclick=\"operate('moveup'," + category.Pkid.ToString() + ",null);\" class=\"icon icon_moveup\" title=\"上移\"></a>";

        if (e.Item.ItemIndex == total - 1) ((HtmlGenericControl)e.Item.FindControl("Eval_MoveDown")).InnerHtml = "<a class=\"icon icon_empty\"></a>";
        else ((HtmlGenericControl)e.Item.FindControl("Eval_MoveDown")).InnerHtml = "<a href=\"javascript:;\" onclick=\"operate('movedown'," + category.Pkid.ToString() + ",null);\" class=\"icon icon_movedown\" title=\"下移\"></a>";
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}
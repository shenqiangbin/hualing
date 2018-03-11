using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_productManage2 : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Category bll_category = new Category();
    private Product bll_product = new Product();
    protected string cid = "3";
    //设置页面大小
    int iPageSize = 20;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("景点管理")) WebUtility.ShowError(WebUtility.ERROR101);
        cid = Request.QueryString["cid"];
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
        //CategoryId.Value = Request.QueryString["cid"];
        WebUtility.BindHtmlSelectByBool(IsTop, "--置顶--", "已置顶", "未置顶", Request.QueryString["top"]);
        WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);
        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(ProductModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(ProductModel.ISTOP, SqlWhere.Oper.Equal, Request.QueryString["top"]));
        sqlWhereList.Add(new SqlWhere(ProductModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));
        sqlWhereList.Add(new SqlWhere(ProductModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds(Request.QueryString["cid"])));
        //SystemHelper.PrintEnd(bll_category.GetIds(Request.QueryString["cid"]));
        //读取分页数据
        int iRecordsTotal = bll_product.DoCount();
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<ProductModel> productList = bll_product.GetList(pagination.PageIndex, iPageSize, null, sqlWhereList, null);

        //绑定
        if (productList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = productList;
        Repeater1.DataBind();
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        ProductModel product = (ProductModel)e.Item.DataItem;
        string url = bll_product.GetUrl(product);

        string title = product.Title + "<br />";
        //title += "<label>价格：</label><span class=\"price\">" + StringHelper.MoneyFormat(product.Price1, "C", "no price") + "</span>";

        //((HtmlGenericControl)e.Item.FindControl("Eval_Pic")).InnerHtml = "<a href=\"" + url + "\" target=\"_blank\"><img src=\"" + product.Pic + "\" /></a>";
        ((HtmlTableCell)e.Item.FindControl("Eval_Title")).InnerHtml = title;
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_product.GetStatus(product, "enab");
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(product.CreateTime);
    }
    /// <summary>
    /// 执行操作的方法
    /// </summary>
    private void Action()
    {
        string cmd = Request["cmd"];
        if (String.IsNullOrEmpty(cmd)) return;
        string ids = Request.QueryString["ids"];

        
        if (cmd == "top") bll_product.UpdateStatus(ids, "top");
        else if (cmd == "enab") bll_product.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_product.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }
    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        //httpHelper.AddUrlParm("cid", CategoryId.Value);
        httpHelper.AddUrlParm("top", IsTop.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}
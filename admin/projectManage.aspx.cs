using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_projectManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Area bll_area = new Area();
    private Category bll_category = new Category();
    private Project bll_project = new Project();
    public string groupName = String.Empty;

    //设置页面大小
    int iPageSize = 20;

    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        CategoryModel group = bll_category.GetModel(Request.QueryString["gid"]);
        if (group == null) WebUtility.ShowError(WebUtility.ERROR102);
        groupName = group.Title.Replace("类别", "");

        if (!bll_admin.RuleAuth("项目_" + groupName + "管理")) WebUtility.ShowError(WebUtility.ERROR101);
        
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
        CategoryId.Value = Request.QueryString["cid"];
        AreaId.Value = Request.QueryString["area"];
        WebUtility.BindHtmlSelectByBool(IsTop, "--置顶--", "已置顶", "未置顶", Request.QueryString["top"]);
        WebUtility.BindHtmlSelectByBool(IsTop, "--推荐--", "已推荐", "未推荐", Request.QueryString["hot"]);
        WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(ProjectModel.CATEGORYID, SqlWhere.Oper.Join, CategoryModel.PKID));
        sqlWhereList.Add(new SqlWhere(CategoryModel.FATHERID, SqlWhere.Oper.Equal, Request.QueryString["gid"]));
        sqlWhereList.Add(new SqlWhere(ProjectModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
        sqlWhereList.Add(new SqlWhere(ProjectModel.ISTOP, SqlWhere.Oper.Equal, Request.QueryString["top"]));
        sqlWhereList.Add(new SqlWhere(ProjectModel.ISHOT, SqlWhere.Oper.Equal, Request.QueryString["hot"]));
        sqlWhereList.Add(new SqlWhere(ProjectModel.ENABLED, SqlWhere.Oper.Equal, Request.QueryString["enab"]));
        sqlWhereList.Add(new SqlWhere(ProjectModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds(Request.QueryString["gid"])));
        sqlWhereList.Add(new SqlWhere(ProjectModel.CATEGORYID, SqlWhere.Oper.In, bll_category.GetIds(Request.QueryString["cid"])));
        sqlWhereList.Add(new SqlWhere(ProjectModel.AREAID, SqlWhere.Oper.In, bll_area.GetIds(Request.QueryString["area"])));

        //读取分页数据
        int iRecordsTotal = bll_project.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<ProjectModel> projectList = bll_project.GetList(pagination.PageIndex, iPageSize, sqlWhereList);

        //绑定
        if (projectList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = projectList;
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

        if (cmd == "top") bll_project.UpdateStatus(ids, "top");
        else if (cmd == "hot") bll_project.UpdateStatus(ids, "hot");
        else if (cmd == "enab") bll_project.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_project.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        ProjectModel project = (ProjectModel)e.Item.DataItem;
        string url = bll_project.GetUrl(project);

        string title = "<a href=\"" + url + "\" target=\"_blank\">" + project.Title + "</a><br />";
        title += "<label>类别：</label>" + bll_category.GetNav(project.CategoryId, "<u>-</u>", false) + "<br />";
        title += "<label>地区：</label>" + bll_area.GetNav(project.AreaId, "<u>-</u>");

        ((HtmlGenericControl)e.Item.FindControl("Eval_Pic")).InnerHtml = "<a href=\"" + url + "\" target=\"_blank\"><img src=\"" + project.Pic + "\" /></a>";
        ((HtmlTableCell)e.Item.FindControl("Eval_Title")).InnerHtml = title;
        ((HtmlTableCell)e.Item.FindControl("Eval_Status")).InnerHtml = bll_project.GetStatus(project, "top") + "<u>|</u>" + bll_project.GetStatus(project, "hot") + "<u>|</u>" + bll_project.GetStatus(project, "enab");
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(project.CreateTime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        httpHelper.AddUrlParm("cid", CategoryId.Value);
        httpHelper.AddUrlParm("area", AreaId.Value);
        httpHelper.AddUrlParm("top", IsTop.Value);
        httpHelper.AddUrlParm("hot", IsHot.Value);
        httpHelper.AddUrlParm("enab", Enabled.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}
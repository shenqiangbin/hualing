using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_songManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Song bll_article = new Song();
    //设置页面大小
    int iPageSize = 20;
    public string cid = "";
    public string param = WebUtility.GetUrlParams("&", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
       
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("量房管理")) WebUtility.ShowError(WebUtility.ERROR101);
       
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
        //WebUtility.BindHtmlSelectByBool(IsHead, "--头条--", "是", "否", Request.QueryString["p1"]);
        //WebUtility.BindHtmlSelectByBool(IsTop, "--置顶--", "已置顶", "未置顶", Request.QueryString["top"]);
        //WebUtility.BindHtmlSelectByBool(Enabled, "--状态--", "上线", "下线", Request.QueryString["enab"]);

        //查询字段
        List<string> fieldList = new List<string>();
        fieldList.Add(SongModel.PKID);
        fieldList.Add(SongModel.TITLE);
        fieldList.Add(SongModel.SEX);
        fieldList.Add(SongModel.TEL);
        fieldList.Add(SongModel.EMAIL);
        fieldList.Add(SongModel.ISTOP);
        fieldList.Add(SongModel.ENABLED);
        fieldList.Add(SongModel.CREATETIME);

        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(SongModel.TITLE, SqlWhere.Oper.Like, Request.QueryString["title"]));
       

        //读取分页数据
        int iRecordsTotal = bll_article.DoCount(sqlWhereList);
        QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "?page=$p" + WebUtility.GetUrlParams("&", false), true);
        pagination.HAlign = QianZhu.Utility.Pagination.Align.Right;
        Paging.InnerHtml = pagination.Show();
        List<SongModel> articleList = bll_article.GetList(pagination.PageIndex, iPageSize, fieldList, sqlWhereList, null);

        //绑定
        if (articleList.Count == 0) NoDataRow.Visible = true;
        Repeater1.DataSource = articleList;
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

        if (cmd == "top") bll_article.UpdateStatus(ids, "top");
        else if (cmd == "enab") bll_article.UpdateStatus(ids, "enab");
        else if (cmd == "del") bll_article.Delete(ids);

        Response.Redirect(Request.Url.AbsolutePath + WebUtility.GetUrlParams("?", true));
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        SongModel article = (SongModel)e.Item.DataItem;
        string url = bll_article.GetUrl(article);

        ((HtmlTableCell)e.Item.FindControl("Eval_Title")).InnerHtml =  article.Title;
        string sex = "女";
        if (article.Sex==1)
        {
            sex = "男";
        }
        ((HtmlTableCell)e.Item.FindControl("Eval_Sex")).InnerHtml = sex;
        ((HtmlTableCell)e.Item.FindControl("Eval_CreateTime")).InnerText = DateHelper.ToShortDate(article.CreateTime);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("page", "1");
        httpHelper.AddUrlParm("title", MyTitle.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}
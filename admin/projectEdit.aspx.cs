using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_projectEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Category bll_category = new Category();
    private Options bll_options = new Options();
    private Project bll_project = new Project();
    private ProjectContent bll_projectContent = new ProjectContent();
    private ProjectModel project = null;
    private List<OptionsModel> optionsList = null;
    public FilespecModel thumSpec = null, imageSpec = null;
    public string myhead = String.Empty, groupName = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        CategoryModel group = bll_category.GetModel(Request.QueryString["gid"]);
        if (group == null) WebUtility.ShowError(WebUtility.ERROR102);
        groupName = group.Title.Replace("类别", "");

        thumSpec = new Filespec().GetModelByCode("thum");
        imageSpec = new Filespec().GetModelByCode("image");
        if (thumSpec == null || imageSpec == null) WebUtility.ShowError(WebUtility.ERROR103);

        project = bll_project.GetModel(Request.QueryString["pkid"]);
        if (project == null) project = new ProjectModel();

        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(OptionsModel.FATHERID, SqlWhere.Oper.Equal, group.Pkid - 8));
        sqlWhereList.Add(new SqlWhere(OptionsModel.ENABLED, SqlWhere.Oper.Equal, true));
        optionsList = bll_options.GetList(0, 0, sqlWhereList, null);

        if (!Page.IsPostBack)
        {
            BindInfo();
        }
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        ScenicPanel.Visible = Request.QueryString["gid"].Equals("11");
        SelfdrivePanel.Visible = Request.QueryString["gid"].Equals("13");
        
        bll_options.BindDropDownList(1, Topic, project.Topic.ToString(), "--请选择--");
        bll_options.BindDropDownList(2, Level, project.ILevel.ToString(), "--请选择--");
        
        if (project.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = project.Title;
            CategoryId.Value = project.CategoryId.ToString();
            AreaId.Value = project.AreaId.ToString();
            Keywords.Value = project.Keywords;
            Descn.Value = project.Descn;
            Pic.Value = project.Pic;
            Pictures.Value = project.Pictures;
            TopPic.Value = project.TopPic;
            EventDate.Value = project.EventDate;
            EventTheme.Value = project.EventTheme;
            Ticket.Value = project.Ticket;
            MySingle.Value = project.Single;
            People.Value = project.People;
            Together.Value = project.Together;
            Tel.Value = project.Tel;
            Address.Value = project.Address;
            Pubdate.Value = DateHelper.ToShortDate(project.Pubdate);
            IsTop.Checked = project.IsTop;
            IsHot.Checked = project.IsHot;
            Sort.Value = project.ISort.ToString();
        }
        else myhead = "新增";

        //内容
        Repeater1.DataSource = optionsList;
        Repeater1.DataBind();
        Repeater2.DataSource = optionsList;
        Repeater2.DataBind();
    }

    protected void Repeater2_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        OptionsModel options = (OptionsModel)e.Item.DataItem;

        string content = String.Empty;
        if (project.Pkid > 0) content = bll_projectContent.GetContent(project.Pkid, options.Pkid);

        e.Item.Controls.Add(new LiteralControl("<textarea id='content" + options.Pkid.ToString() + "' name='content" + options.Pkid.ToString() + "' class='hide'>" + content + "</textarea>"));
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(CategoryId.Value)) WebUtility.ShowAlertMessage("请选择所属类别！", null);
            if (!StringHelper.IsNumber(Sort.Value)) Sort.Value = "1";

            project.Title = MyTitle.Value;
            project.CategoryId = Convert.ToInt32(CategoryId.Value);
            if (StringHelper.IsNumber(AreaId.Value)) project.AreaId = Convert.ToInt32(AreaId.Value);
            else project.AreaId = 0;
            if (!String.IsNullOrEmpty(Keywords.Value)) project.Keywords = Keywords.Value.Replace("，", ",");
            else project.Keywords = Keywords.Value;
            project.Descn = Descn.Value;
            project.Pic = Pic.Value;
            project.Pictures = Pictures.Value;
            project.TopPic = TopPic.Value;
            if (StringHelper.IsNumber(Topic.Value)) project.Topic = Convert.ToInt32(Topic.Value);
            if (StringHelper.IsNumber(Level.Value)) project.ILevel = Convert.ToInt32(Level.Value);
            project.EventDate = EventDate.Value;
            project.EventTheme = EventTheme.Value;
            project.Ticket = Ticket.Value;
            project.Single = MySingle.Value;
            project.People = People.Value;
            project.Together = Together.Value;
            project.Tel = Tel.Value;
            project.Address = Address.Value;
            project.ISort = Convert.ToInt32(Sort.Value);
            project.IsTop = IsTop.Checked;
            project.IsHot = IsHot.Checked;

            if (project.Pkid > 0)
            {
                //更改
                if (DateHelper.ToShortDate(project.Pubdate) != Pubdate.Value) project.Pubdate = Pubdate.Value;
                bll_project.Update(project);
                SetContent();
                WebUtility.ShowAlertMessage("保存成功！", "projectManage.aspx" + param);
            }
            else
            {
                //增加
                project.Enabled = true;
                if (String.IsNullOrEmpty(Pubdate.Value)) project.Pubdate = DateTime.Now.ToString();
                else project.Pubdate = Pubdate.Value;
                project.Creator = Convert.ToInt32(bll_admin.CookieId);
                project.CreateTime = DateTime.Now.ToString();
                bll_project.Insert(project);
                SetContent();
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }

    /// <summary>
    /// 保存详细内容
    /// </summary>
    private void SetContent()
    {
        //内容
        foreach (OptionsModel option in optionsList)
        {
            ProjectContentModel projectContent = new ProjectContentModel();
            projectContent.ProId = project.Pkid;
            projectContent.OptionId = option.Pkid;
            projectContent.Content = Request.Form["content" + option.Pkid.ToString()];
            bll_projectContent.Update(projectContent);
        }
    }
}
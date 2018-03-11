using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_articleEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Category bll_category = new Category();
    private Course bll_course = new Course();
    private CourseModel courses = null;
    public FilespecModel filespec = null;
    public FilespecModel filespec2 = null;
    public string myhead = String.Empty;
    public string cid = "1";
    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
       
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("课程")) WebUtility.ShowError(WebUtility.ERROR101);

        filespec = new Filespec().GetModelByCode("thum");
        filespec2 = new Filespec().GetModelByCode("attachment");
        if (filespec == null) WebUtility.ShowError(WebUtility.ERROR103);

        courses = bll_course.GetModel(Request.QueryString["pkid"]);
        if (courses == null) courses = new CourseModel();

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
        if (courses.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = courses.Way;
            issue.Value = courses.Issue;
            Pubdate.Value = DateHelper.ToShortDate(courses.Opentime);
            city.Value= courses.City;
            pv.Value = courses.Pv.ToString();
            qq.Value = courses.Tel;
            
            IsTop.Checked = courses.IsTop;
            Sort.Value = courses.ISort.ToString();

        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            
            if (!StringHelper.IsNumber(Sort.Value)) Sort.Value = "1";

            courses.Way = MyTitle.Value;
            courses.Issue = issue.Value;
            courses.City = city.Value;
            courses.Pv = Convert.ToInt32(pv.Value);
            courses.Tel = qq.Value;


            courses.ISort = Convert.ToInt32(Sort.Value);
            courses.IsTop = IsTop.Checked;
            courses.Opentime = Pubdate.Value;
            if (courses.Pkid > 0)
            {
                //更改
                if (DateHelper.ToShortDate(courses.CreateTime) != Pubdate.Value) courses.CreateTime = Pubdate.Value;

                bll_course.Update(courses);
                WebUtility.ShowAlertMessage("保存成功！", "courseManage.aspx" + param);
            }
            else
            {
                //增加
                courses.Enabled = true;
                if (String.IsNullOrEmpty(Pubdate.Value)) courses.CreateTime = DateTime.Now.ToString();
                else courses.CreateTime = Pubdate.Value;
                courses.CreateTime = DateTime.Now.ToString();
                bll_course.Insert(courses);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}
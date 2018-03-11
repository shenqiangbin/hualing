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
    private Song bll_song = new Song();
    private SongModel songs = null;
    public FilespecModel filespec = null;
    public FilespecModel filespec2 = null;
    public string myhead = String.Empty;
    public string cid = "1";
    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
       
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("加入华领管理")) WebUtility.ShowError(WebUtility.ERROR101);

      
        songs = bll_song.GetModel(Request.QueryString["pkid"]);
        if (songs == null) songs = new SongModel();

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
        if (songs.Pkid > 0)
        {
            myhead = "查看";
            MyTitle.InnerText = songs.Title;
            if (songs.Sex == 1)
            {
                sex.InnerText = "男";
            }
            else
            {
                sex.InnerText = "女";
            }
            birtime.InnerText = songs.Birtime;
            addr.InnerText = songs.Addr;
            salary.InnerText = songs.Salary;
            tel.InnerText = songs.Tel;
            email.InnerText = songs.Email;
            address.InnerText = songs.Address;
            edu.InnerHtml = songs.Edu;
            works.InnerHtml = songs.Works;
            evaluation.InnerHtml = songs.Evaluation;
        }
        else myhead = "新增";
    }

    
}
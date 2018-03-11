using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;
using System.Collections.Generic;

public partial class join : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Song bll_song = new Song();
   
    public int sex = 1;
    public string[] str;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        banner1.kind = 33;
        Right1.kind = 6;
        Right1.menu = -2;
        Master.Index = 10;
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        //Title
        bll_config.Load(new string[] { "pageTitle","prize" });
        Page.Title = "加入华领 - " + bll_config["pageTitle"];
        
    }

    protected void SubminButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            //检测验证码
            HttpCookie acookie = Request.Cookies["2014yfkCode"];
            if (code.Value.ToUpper() != acookie.Value)
            {
                WebUtility.ShowAlertMessage("验证码输入错误！", null);
            }
            //注册会员
            SongModel songs= new SongModel();
            songs.Title = names.Value;
            songs.Sex=Convert.ToInt32(Request.Form["sex"]);   //1-男  2-女
            songs.Birtime = bristh.Value;
            songs.Addr = addr.Value;
            songs.Salary = salacy.Value;
            songs.Tel = tel.Value;
            songs.Email = Email.Value;
            songs.Address = address.Value;
            songs.Edu = edu.Value;
            songs.Works = works.Value;
            songs.Evaluation = evaluation.Value;

            songs.Enabled = true;
            songs.CreateTime = DateTime.Now.ToString();

            bll_song.Insert(songs);            
  
            WebUtility.ShowAlertMessage("信息已提交！", "/join.html");
        }
    }
  
}
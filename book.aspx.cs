using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;
using System.Collections.Generic;

public partial class book : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_config = new GlobalConfig();
    private Member bll_member = new Member();
   
    public int sex = 1;
    public string[] str;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            BindInfo();
        }
        banner1.kind = 32;
        Right1.kind = 100;
        //Right1.menu = category.Pkid;
        Master.Index = 1;
    }

    /// <summary>
    /// 绑定信息
    /// </summary>
    private void BindInfo()
    {
        //Title
        bll_config.Load(new string[] { "pageTitle","prize" });
        Page.Title = "在线报名 - " + bll_config["pageTitle"];
        
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
            MemberModel member = new MemberModel();
            member.Username = yix.Value;  //意向课程
            member.Pwd = "234fsdfsdf423d";
            member.Realname = names.Value;

            member.Sex = Request.Form["sex"];   //1-男  2-女
            member.Pic = bristh.Value;
            member.Nickname = unit.Value;
            member.Tel = zw.Value;
            member.Mobi = tel.Value;
            member.Email = Email.Value;
            member.Address = bz.Value;
            try
            {
                member.CityId = member.CityId = Convert.ToInt32(AreaId.Value);
            }
            catch (Exception)
            {
                member.CityId = 0;
            }
            
           

            member.Enabled = true;
            member.CreateTime = DateTime.Now.ToString();

            bll_member.Insert(member);            
  
            WebUtility.ShowAlertMessage("信息已提交！", "/book.html");
        }
    }
  
}
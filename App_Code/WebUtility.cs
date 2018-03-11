using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

/// <summary>
/// Web公共方法集合
/// </summary>
public class WebUtility
{
    public const string ERROR101 = "您没有权限操作此项服务！";
    public const string ERROR102 = "没有找到相关数据！";
    public const string ERROR103 = "没有找到文件规格！";
    
    /// <summary>
    /// 组合URL参数(重载1)
    /// <param name="code">URL参数链接符:?/&</param>
    /// <param name="withPage">是否带页索引参数</param>
    /// </summary>
    public static string GetUrlParams(string code, bool withPage)
    {
        string ignoreParams = null;
        if (!withPage) ignoreParams = "page";
        return GetUrlParams(code, ignoreParams);
    }

    /// <summary>
    /// 组合URL参数(重载2)
    /// <param name="code">URL参数链接符:?/&</param>
    /// <param name="ignoreParams">忽略的参数</param>
    /// </summary>
    public static string GetUrlParams(string code, string ignoreParams)
    {
        HttpRequest myRequest = HttpContext.Current.Request;
        if (String.IsNullOrEmpty(code)) code = String.Empty;
        if (String.IsNullOrEmpty(ignoreParams)) ignoreParams = String.Empty;
        ignoreParams = "," + ignoreParams + ",";

        HttpHelper httpHelper = new HttpHelper();
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",page,") < 0) httpHelper.AddUrlParm("page", myRequest["page"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",title,") < 0) httpHelper.AddUrlParm("title", myRequest["title"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",uid,") < 0) httpHelper.AddUrlParm("uid", myRequest["uid"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",cid,") < 0) httpHelper.AddUrlParm("cid", myRequest["cid"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",gid,") < 0) httpHelper.AddUrlParm("gid", myRequest["gid"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",area,") < 0) httpHelper.AddUrlParm("area", myRequest["area"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",fkid,") < 0) httpHelper.AddUrlParm("fkid", myRequest["fkid"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",top,") < 0) httpHelper.AddUrlParm("top", myRequest["top"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",hot,") < 0) httpHelper.AddUrlParm("hot", myRequest["hot"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",stat,") < 0) httpHelper.AddUrlParm("stat", myRequest["stat"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",enab,") < 0) httpHelper.AddUrlParm("enab", myRequest["enab"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",date1,") < 0) httpHelper.AddUrlParm("date1", myRequest["date1"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",date2,") < 0) httpHelper.AddUrlParm("date2", myRequest["date2"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",city,") < 0) httpHelper.AddUrlParm("city", myRequest["city"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",topic,") < 0) httpHelper.AddUrlParm("topic", myRequest["topic"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",level,") < 0) httpHelper.AddUrlParm("level", myRequest["level"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",keys,") < 0) httpHelper.AddUrlParm("keys", myRequest["keys"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",order,") < 0) httpHelper.AddUrlParm("order", myRequest["order"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",p1,") < 0) httpHelper.AddUrlParm("p1", myRequest["p1"]);
        if (String.IsNullOrEmpty(ignoreParams) || ignoreParams.IndexOf(",p2,") < 0) httpHelper.AddUrlParm("p2", myRequest["p2"]);

        if (String.IsNullOrEmpty(httpHelper.UrlParm)) return String.Empty;
        return code + httpHelper.UrlParm;
    }

    /// <summary>
    /// 为页面添加Meta标签
    /// <param name="page">页面对象</param>
    /// <param name="name">标签名</param>
    /// <param name="content">标签内容</param>
    /// </summary>
    public static void CreateMeta(Page page, string name, string content)
    {
        HtmlMeta meta = new HtmlMeta();
        meta.Name = name;
        meta.Content = content;
        page.Header.Controls.Add(meta);
    }

    /// <summary>
    /// 绑定布尔值到下拉列表
    /// <param name="hs">下拉列表</param>
    /// <param name="head">头部选项</param>
    /// <param name="trueText">True文本</param>
    /// <param name="falseText">False文本</param>
    /// <param name="selectVal">选中值</param>
    /// </summary>
    public static void BindHtmlSelectByBool(HtmlSelect hs, string head, string trueText, string falseText, string selectVal)
    {
        if (!String.IsNullOrEmpty(head)) hs.Items.Add(new ListItem(head, String.Empty));
        if (!String.IsNullOrEmpty(trueText)) hs.Items.Add(new ListItem(trueText, "1"));
        if (!String.IsNullOrEmpty(falseText)) hs.Items.Add(new ListItem(falseText, "0"));

        if (!String.IsNullOrEmpty(selectVal))
        {
            ListItem item = hs.Items.FindByValue(selectVal);
            if (item != null) item.Selected = true;
        }
    }

    /// <summary>
    /// 显示对话框信息
    /// <param name="message">信息内容</param>
    /// <param name="returnPage">返回页面</param>
    /// </summary>
    public static void ShowAlertMessage(string message, string returnPage)
    {
        if (String.IsNullOrEmpty(returnPage))
            HttpContext.Current.Response.Write("<script>alert('" + message + "'); window.history.back();</script>");
        else
            HttpContext.Current.Response.Write("<script>alert('" + message + "'); window.location.href='" + returnPage + "';</script>");
        HttpContext.Current.Response.End();
    }

    /// <summary>
    /// 错误页跳转
    /// <param name="errorMessage">错误信息</param>
    /// </summary>
    public static void ShowError(string errorMessage)
    {
        HttpContext.Current.Response.Redirect("error.aspx?errmsg=" + errorMessage);
        HttpContext.Current.Response.End();
    }

    /// <summary>
    /// 跳转至404页面
    /// </summary>
    public static void Goto404()
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.StatusCode = 404;
        string content = FileHelper.FileReader(FileHelper.AppPhyRoot + "error/404.html");
        HttpContext.Current.Response.Write(content);
        HttpContext.Current.Response.End();
    }

    /// <summary>
    /// 301重定向
    /// </summary>
    public static void Goto301(string url)
    {
        HttpContext.Current.Response.Clear();
        HttpContext.Current.Response.StatusCode = 301;
        HttpContext.Current.Response.Status = "301 MovedPermanently";
        HttpContext.Current.Response.AddHeader("Location", url);
        HttpContext.Current.Response.End();
    }

    /// <summary>
    /// 检测验证码
    /// <param name="checkCode">验证码</param>
    /// <param name="returnPage">返回页面</param>
    /// </summary>
    public static void CheckCode(string code, string returnPage)
    {
        if (String.IsNullOrEmpty(code) || HttpContext.Current.Request.Cookies[ImageHelper.COOKIES_CODE_INFO] == null)
        {
            ShowAlertMessage("验证码输入错误！", returnPage);
            HttpContext.Current.Response.End();
        }

        string cookieCode = HttpContext.Current.Request.Cookies[ImageHelper.COOKIES_CODE_INFO].Values[ImageHelper.COOKIE_CODE_NAME];
        if (String.IsNullOrEmpty(cookieCode) || cookieCode.ToLower() != code.ToLower())
        {
            ShowAlertMessage("验证码输入错误！", returnPage);
            HttpContext.Current.Response.End();
        }
    }

    /// <summary>
    /// 管理员登录认证
    /// </summary>
    public static void AdminLoginAuth()
    {
        Admin bll_admin = new Admin();
        if (!bll_admin.IdentityAuth()) HttpContext.Current.Response.Redirect("exit.ashx");
    }

    /// <summary>
    /// 会员登录认证
    /// </summary>
    public static void MemberLoginAuth()
    {
        Member bll_member = new Member();
        if (!bll_member.IdentityAuth()) HttpContext.Current.Response.Redirect("/login/?reurl=" + HttpContext.Current.Request.RawUrl);
    }

    /// <summary>
    /// 取复选框组值
    /// </summary>
    public static string GetValuesCBL(CheckBoxList cbl)
    {
        string vals = String.Empty;

        foreach (ListItem li in cbl.Items)
        {
            if (li.Selected) vals += li.Value + ",";
        }

        if (!String.IsNullOrEmpty(vals)) vals = vals.Substring(0, vals.Length - 1);

        return vals;
    }
}
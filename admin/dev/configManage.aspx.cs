using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_configManage : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private GlobalConfig bll_globalConfig = new GlobalConfig();
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        //执行操作
        Action();

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
        //搜索控件
        KeyName.Value = Request.QueryString["title"];
        
        //组合查询条件
        List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        sqlWhereList.Add(new SqlWhere(GlobalConfigModel.KEYNAME, SqlWhere.Oper.Like, Request.QueryString["title"]));

        //读取数据
        List<GlobalConfigModel> globalConfigList = bll_globalConfig.GetList(sqlWhereList);
        Repeater1.DataSource = globalConfigList;
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

        if (cmd == "del") bll_globalConfig.Delete(ids);
        else if (cmd == "updateall")
        {
            foreach (string key in Request.Form.AllKeys)
            {
                if (key.StartsWith("key"))
                {
                    string keyName = Request.Form[key];
                    if (String.IsNullOrEmpty(keyName)) continue;

                    string valuePc = Request.Form[key.Replace("key", "valPc")];
                    string valueMobi = Request.Form[key.Replace("key", "valMobi")];

                    if (key.IndexOf("#") > 0)
                    {
                        GlobalConfigModel globalConfig = new GlobalConfigModel();
                        globalConfig.KeyName = keyName;
                        globalConfig.ValuePc = valuePc;
                        globalConfig.ValueMobi = valueMobi;
                        bll_globalConfig.Insert(globalConfig);
                    }
                    else
                    {
                        string id = key.Replace("key", "");
                        GlobalConfigModel globalConfig = bll_globalConfig.GetModel(id);
                        if (globalConfig == null) continue;
                        globalConfig.KeyName = keyName;
                        globalConfig.ValuePc = valuePc;
                        globalConfig.ValueMobi = valueMobi;
                        bll_globalConfig.Update(globalConfig);
                    }
                }
            }

            WebUtility.ShowAlertMessage("全部保存成功！", Request.RawUrl);
        }

        Response.Redirect(Request.Url.AbsolutePath);
    }

    protected void SearchButton_Click(object sender, ImageClickEventArgs e)
    {
        HttpHelper httpHelper = new HttpHelper();
        httpHelper.AddUrlParm("title", KeyName.Value);
        Response.Redirect(Request.Url.AbsolutePath + "?" + httpHelper.UrlParm);
    }
}
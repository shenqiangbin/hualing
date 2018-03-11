using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_areaEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Area bll_area = new Area();
    public AreaModel area = null;

    public string myhead = String.Empty;
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("全局_地区管理")) WebUtility.ShowError(WebUtility.ERROR101);
        
        area = bll_area.GetModel(Request.QueryString["pkid"]);
        if (area == null) area = new AreaModel();

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
        if (area.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = area.Title;
            MyCode.Value = area.Code;
            FatherId.Value = area.FatherId.ToString();
            IsHot.Checked = area.IsHot;
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!String.IsNullOrEmpty(MyCode.Value) && area.Code != MyCode.Value)
            {
                if (bll_area.CodeExist(MyCode.Value)) WebUtility.ShowAlertMessage("代码已存在，请重新选择！", null);
                area.Code = MyCode.Value;
            }
            
            if (!StringHelper.IsNumber(FatherId.Value)) WebUtility.ShowAlertMessage("请填写父级地区ID！", null);
            
            area.Title = MyTitle.Value;
            area.Code = MyCode.Value;
            area.IsHot = IsHot.Checked;

            if (area.Pkid > 0)
            {                
                //更改
                int result = bll_area.Update(area, FatherId.Value, Request.Form["sort"]);

                if (result == 101) WebUtility.ShowAlertMessage("没有找到相关父类！", null);
                else if (result == 102) WebUtility.ShowAlertMessage("所选父类为最终类，无法添加子类别，请重新选择父类！", null);
                else if (result == 103) WebUtility.ShowAlertMessage("没有找到显示位置！", null);

                WebUtility.ShowAlertMessage("保存成功！", "areaManage.aspx");
            }
            else
            {
                //增加
                area.FatherId = Convert.ToInt32(FatherId.Value);
                int result = bll_area.Insert(area);

                if (result == 101) WebUtility.ShowAlertMessage("没有找到相关父类！", null);
                else if (result == 102) WebUtility.ShowAlertMessage("所选父类为最终类，无法添加子类别，请重新选择父类！", null);

                result = bll_area.Update(area, FatherId.Value, Request.Form["sort"]);
                if (result == 103) WebUtility.ShowAlertMessage("没有找到显示位置！", null);

                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}
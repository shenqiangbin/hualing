using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_dev_filespecEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Filespec bll_filespec = new Filespec();
    public FilespecModel filespec = null, watermarkSpec = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);
    
    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();

        filespec = bll_filespec.GetModel(Request.QueryString["pkid"]);
        if (filespec == null) filespec = new FilespecModel();

        watermarkSpec = bll_filespec.WatermarkSpec;

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
        WmSwitch.SelectedValue = SystemHelper.Var2Int(filespec.WmSwitch).ToString();
        XMLHelper.SetCtrlByXmlData(WmAlign, null, "WatermarkAlign", filespec.WmAlign.ToString());
        XMLHelper.SetCtrlByXmlData(WmTextColor, "--颜色--", "FontColor", filespec.WmTextColor);
        XMLHelper.SetCtrlByXmlData(WmTextFont, "--字体--", "FontFamily", filespec.WmTextFont);
        
        if (filespec.Pkid > 0)
        {           
            myhead = "编辑";
            MyTitle.Value = filespec.Title;
            MyCode.Value = filespec.Code;
            FileFormat.Value = filespec.FileFormat;
            Filesize.Value = filespec.Filesize.ToString();
            SavePath.Value = filespec.SavePath;
            NameFormat.Value = filespec.NameFormat;
            WmTransparent.Value = filespec.WmTransparent.ToString();
            WmText.Value = filespec.WmText;
            WmTextSize.Value = filespec.WmTextSize.ToString();
            WmImage.Value = filespec.WmImage;

            if (!String.IsNullOrEmpty(filespec.Thumbnail))
            {
                string[] arrData = filespec.Thumbnail.Split(new char[] { '|' });
                Repeater1.DataSource = arrData;
                Repeater1.DataBind();
            }
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (filespec.Code != MyCode.Value)
            {
                if (bll_filespec.CodeExist(MyCode.Value)) WebUtility.ShowAlertMessage("代码已存在，请重新选择！", null);
                filespec.Code = MyCode.Value;
            }

            if (!StringHelper.IsNumber(Filesize.Value)) Filesize.Value = "0";

            filespec.Title = MyTitle.Value;
            filespec.FileFormat = FileFormat.Value;
            filespec.Filesize = Convert.ToInt32(Filesize.Value);
            filespec.SavePath = SavePath.Value;
            filespec.NameFormat = NameFormat.Value;

            filespec.WmSwitch = Convert.ToInt32(WmSwitch.SelectedValue);
            filespec.WmAlign = Convert.ToInt32(WmAlign.Value);
            if (StringHelper.IsNumber(WmTransparent.Value)) filespec.WmTransparent = Convert.ToInt32(WmTransparent.Value);
            filespec.WmText = WmText.Value;
            if (StringHelper.IsNumber(WmTextSize.Value)) filespec.WmTextSize = Convert.ToInt32(WmTextSize.Value);
            filespec.WmTextColor = WmTextColor.Value;
            filespec.WmTextFont = WmTextFont.Value;
            filespec.WmImage = WmImage.Value;

            filespec.Thumbnail = String.Empty;

            foreach (string key in Request.Form.AllKeys)
            {
                if (key.StartsWith("thumwidth"))
                {
                    string width = Request.Form[key];
                    string height = Request.Form[key.Replace("width", "height")];
                    string watermark = Request.Form[key.Replace("width", "wm")];
                    if (!StringHelper.IsNumber(width) || !StringHelper.IsNumber(height)) continue;
                    filespec.Thumbnail += width + "," + height + "," + watermark + "|";
                }
            }

            if (!String.IsNullOrEmpty(filespec.Thumbnail))
                filespec.Thumbnail = filespec.Thumbnail.Remove(filespec.Thumbnail.Length - 1);

            if (filespec.Pkid > 0)
            {
                //更改
                bll_filespec.Update(filespec);
                WebUtility.ShowAlertMessage("保存成功！", "filespecManage.aspx" + param);
            }
            else
            {
                //增加
                bll_filespec.Insert(filespec);
                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
}

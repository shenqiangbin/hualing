using System;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class admin_productEdit : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Category bll_category = new Category();
    private Product bll_product = new Product();
    public ProductModel product = null;
    public FilespecModel thumSpec = null, imageSpec = null;
    public string myhead = String.Empty;

    public string param = WebUtility.GetUrlParams("?", true);

    protected void Page_Load(object sender, EventArgs e)
    {
        WebUtility.AdminLoginAuth();
        if (!bll_admin.RuleAuth("案例管理")) WebUtility.ShowError(WebUtility.ERROR101);

        thumSpec = new Filespec().GetModelByCode("thum");
        imageSpec = new Filespec().GetModelByCode("image");
        if (thumSpec == null || imageSpec == null) WebUtility.ShowError(WebUtility.ERROR103);

        product = bll_product.GetModel(Request.QueryString["pkid"]);
        if (product == null) product = new ProductModel();

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
        if (product.Pkid > 0)
        {
            myhead = "编辑";
            MyTitle.Value = product.Title;
            //names.Value = product.Titlename;
            CategoryId.Value = product.CategoryId.ToString();
            //summary.Value = product.Summary;
            Keywords.Value = product.Keywords;
            Descn.Value = product.Descn;
            //Pic.Value = product.Pic;
            //Pictures.Value = product.Pictures;
            //Price1.Value = product.Price1.ToString("F2");
            //Price2.Value = product.Price2.ToString("F2");
            //Stock.Value = product.Stock.ToString();
            Pubdate.Value = DateHelper.ToShortDate(product.Pubdate);
            //MyContent.Value = product.Content;
            IsTop.Checked = product.IsTop;
            Sort.Value = product.ISort.ToString();
            ishot.Checked = product.Ishot;  // -
           
        }
        else myhead = "新增";
    }

    protected void SubmitButton_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            if (!StringHelper.IsNumber(CategoryId.Value)) WebUtility.ShowAlertMessage("请选择类别！", null);
           // if (!StringHelper.IsNumber(point.Value)) WebUtility.ShowAlertMessage("请选择机型！", null);
            //if (!StringHelper.IsMoney(Price1.Value)) Price1.Value = "0";
            //if (!StringHelper.IsMoney(Price2.Value)) Price2.Value = "0";
            //if (!StringHelper.IsNumber(Stock.Value)) Stock.Value = "0";
            if (!StringHelper.IsNumber(Sort.Value)) Sort.Value = "1";

            product.Title = MyTitle.Value;
            product.Titlename = " ";
            product.CategoryId = Convert.ToInt32(CategoryId.Value);
            //product.Summary=summary.Value;
            //product.Point = Convert.ToInt32(point.Value);
            if (!String.IsNullOrEmpty(Keywords.Value)) product.Keywords = Keywords.Value.Replace("，", ",");
            else product.Keywords = Keywords.Value;
            product.Descn = Descn.Value;
            //product.Pic = Pic.Value;
            //product.Pictures = Pictures.Value;
            product.Price1 = 0;
            product.Price2 = 0;
           // product.Stock = Convert.ToInt32(Stock.Value);
           // product.Content = MyContent.Value;
            product.ISort = Convert.ToInt32(Sort.Value);
            product.IsTop = IsTop.Checked;

            //SystemHelper.PrintEnd(Request.Form["content0"] + "-" + Request.Form["content1"] + "-" + Request.Form["content2"]);
            product.Content = Request.Form["content0"];
           // product.Feature = Request.Form["content0"];   //信息
           
            product.Application = "";
            product.Ishot=ishot.Checked;  // 
          
            if (product.Pkid > 0)
            {
                //更改
                if (DateHelper.ToShortDate(product.Pubdate) != Pubdate.Value) product.Pubdate = Pubdate.Value;
                bll_product.Update(product);

                WebUtility.ShowAlertMessage("保存成功！", "productManage.aspx" + param);
            }
            else
            {
                //增加
                product.Enabled = true;
                if (String.IsNullOrEmpty(Pubdate.Value)) product.Pubdate = DateTime.Now.ToString();
                else product.Pubdate = Pubdate.Value;
                product.Creator = Convert.ToInt32(bll_admin.CookieId);
                product.CreateTime = DateTime.Now.ToString();
                bll_product.Insert(product);

                WebUtility.ShowAlertMessage("新增成功！", Request.RawUrl);
            }
        }
    }
   

}
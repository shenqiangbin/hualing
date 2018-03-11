<%@ WebHandler Language="C#" Class="initSqlData" %>

using System;
using System.Data.OleDb;
using System.Data.SqlClient;
using System.Web;
using QianZhu.BLL;
using QianZhu.DAL;
using QianZhu.Model;
using QianZhu.Utility;

public class initSqlData : IHttpHandler {

    private string strConn = @"PROVIDER=Microsoft.Jet.OLEDB.4.0;DATA Source=" + FileHelper.AppPhyRoot + @"App_Data\db.mdb";
    
    public void ProcessRequest (HttpContext context)
    {
        //GetGlobalConfig();
        //GetSystemMenu();
        //GetSiteMenu();
        //GetCategory();
        //GetAdGroup();
        //GetFilespec();
        GetArea();

        context.Response.Write(DateTime.Now.ToString());
    }

    private void GetGlobalConfig()
    {
        using (OleDbConnection conn = new OleDbConnection(strConn))
        {
            conn.Open();
            string sql = "select * from GlobalConfig";

            GlobalConfigSql dal_config = new GlobalConfigSql();
            OleDbCommand cmd = new OleDbCommand(sql, conn);

            using (OleDbDataReader sdr = cmd.ExecuteReader())
            {
                while (sdr.Read())
                {
                    GlobalConfigModel model = new GlobalConfigModel();
                    model.KeyName = sdr["keyName"].ToString();
                    model.ValuePc = sdr["valuePc"].ToString();
                    model.ValueMobi = sdr["valueMobi"].ToString();
                    dal_config.Insert(model);
                }
            }
        }
    }

    private void GetSystemMenu()
    {
        using (OleDbConnection conn = new OleDbConnection(strConn))
        {
            conn.Open();
            string sql = "select * from SystemMenu";

            SystemMenuSql dal_systemMenu = new SystemMenuSql();
            OleDbCommand cmd = new OleDbCommand(sql, conn);

            using (OleDbDataReader sdr = cmd.ExecuteReader())
            {
                while (sdr.Read())
                {
                    SystemMenuModel model = new SystemMenuModel();
                    model.Title = sdr["title"].ToString();
                    model.FatherId = Convert.ToInt32(sdr["fatherId"]);
                    model.Xpath = sdr["xpath"].ToString();
                    model.ILevel = Convert.ToInt32(sdr["iLevel"]);
                    model.ISort = Convert.ToInt32(sdr["iSort"]);
                    model.IsOpen = Convert.ToBoolean(sdr["isOpen"]);
                    model.HasChild = Convert.ToBoolean(sdr["hasChild"]);
                    model.Url = sdr["url"].ToString();
                    model.AddPageUrl = sdr["addPageUrl"].ToString();
                    model.RuleCode = sdr["ruleCode"].ToString();
                    model.Enabled = Convert.ToBoolean(sdr["enabled"]);
                    model.CreateTime = sdr["createTime"].ToString();
                    dal_systemMenu.Insert(model);
                }
            }
        }
    }

    private void GetSiteMenu()
    {
        SiteMenu bll_siteMenu = new SiteMenu();
        
        SiteMenuModel model = new SiteMenuModel();
        model.Title = "主导航";
        model.FatherId = 0;
        model.MaxLevel = 2;
        bll_siteMenu.Insert(model);

        model = new SiteMenuModel();
        model.Title = "关于CMA";
        model.FatherId = 0;
        model.MaxLevel = 2;
        bll_siteMenu.Insert(model);
        model = new SiteMenuModel();
        model.Title = "课程班型";
        model.FatherId = 0;
        model.MaxLevel = 2;
        bll_siteMenu.Insert(model);
        model = new SiteMenuModel();
        model.Title = "新闻资讯";
        model.FatherId = 0;
        model.MaxLevel = 2;
        bll_siteMenu.Insert(model);
        model = new SiteMenuModel();
        model.Title = "学员专区";
        model.FatherId = 0;
        model.MaxLevel = 2;
        bll_siteMenu.Insert(model);
        model = new SiteMenuModel();
        model.Title = "关于华领";
        model.FatherId = 0;
        model.MaxLevel = 2;
        bll_siteMenu.Insert(model);
        model.Title = "内训课程";
        model.FatherId = 0;
        model.MaxLevel = 2;
        bll_siteMenu.Insert(model);
    }

    private void GetCategory()
    {
        Category bll_category = new Category();
        
        CategoryModel model = new CategoryModel();
        model.Title = "CMA热点问题";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);

        model = new CategoryModel();
        model.Title = "CAM课程";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);

        model = new CategoryModel();
        model.Title = "新闻资讯";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);

        model = new CategoryModel();
        model.Title = "考试心得";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);

        model = new CategoryModel();
        model.Title = "管理会计俱乐部";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);

        model = new CategoryModel();
        model.Title = "职业通道";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);

        model = new CategoryModel();
        model.Title = "服务猎头";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);


        
        model = new CategoryModel();
        model.Title = "视频专区";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);

        model = new CategoryModel();
        model.Title = "图片专题";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);

        model = new CategoryModel();
        model.Title = "财务管理内训";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);
        
        model = new CategoryModel();
        model.Title = "内训案例";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);

        model = new CategoryModel();
        model.Title = "内训专家团队";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);

        model = new CategoryModel();
        model.Title = "名师团队";
        model.FatherId = 0;
        model.MaxLevel = 1;
        bll_category.Insert(model);
        
    }

    private void GetAdGroup()
    {
        using (OleDbConnection conn = new OleDbConnection(strConn))
        {
            conn.Open();
            string sql = "select * from AdGroup";

            AdGroupSql dal_adGroup = new AdGroupSql();
            OleDbCommand cmd = new OleDbCommand(sql, conn);

            using (OleDbDataReader sdr = cmd.ExecuteReader())
            {
                while (sdr.Read())
                {
                    AdGroupModel model = new AdGroupModel();
                    model.Title = sdr["title"].ToString();
                    model.Width = Convert.ToInt32(sdr["width"]);
                    model.Height = Convert.ToInt32(sdr["height"]);
                    model.Display = Convert.ToInt32(sdr["display"]);
                    model.Inbuilt = Convert.ToBoolean(sdr["inbuilt"]);
                    model.Enabled = Convert.ToBoolean(sdr["enabled"]);
                    model.CreateTime = sdr["createTime"].ToString();
                    dal_adGroup.Insert(model);
                }
            }
        }
    }

    private void GetFilespec()
    {
        using (OleDbConnection conn = new OleDbConnection(strConn))
        {
            conn.Open();
            string sql = "select * from Filespec";

            FilespecSql dal_filespec = new FilespecSql();
            OleDbCommand cmd = new OleDbCommand(sql, conn);

            using (OleDbDataReader sdr = cmd.ExecuteReader())
            {
                while (sdr.Read())
                {
                    FilespecModel model = new FilespecModel();
                    model.Title = sdr["title"].ToString();
                    model.Code = sdr["code"].ToString();
                    model.FileFormat = sdr["fileFormat"].ToString();
                    model.FileExt = sdr["fileExt"].ToString();
                    model.Filesize = Convert.ToInt32(sdr["filesize"]);
                    model.SavePath = sdr["savePath"].ToString();
                    model.NameFormat = sdr["nameFormat"].ToString();
                    model.WmSwitch = Convert.ToInt32(sdr["wmSwitch"].ToString());
                    model.WmAlign = Convert.ToInt32(sdr["wmAlign"].ToString());
                    model.WmTransparent = Convert.ToInt32(sdr["wmTransparent"].ToString());
                    model.WmText = sdr["wmText"].ToString();
                    model.WmTextSize = Convert.ToInt32(sdr["wmTextSize"].ToString());
                    model.WmTextColor = sdr["wmTextColor"].ToString();
                    model.WmTextFont = sdr["wmTextFont"].ToString();
                    model.WmImage = sdr["wmImage"].ToString();
                    model.Thumbnail = sdr["thumbnail"].ToString();
                    dal_filespec.Insert(model);
                }
            }
        }
    }

    private void GetArea()
    {
        AreaSql dal_area = new AreaSql();
        //string strConn = "server=203.158.23.55;user id=dbo10081857;password=7fv8tvau;database=db10081857;";
        string strConn = "server=203.158.23.55;user id=dbo10081856;password=db10081856;database=e6py36k1;";
        using (SqlConnection conn = new SqlConnection(strConn))
        {
            conn.Open();
            string sql = "select * from area";

            SqlCommand cmd = new SqlCommand(sql, conn);

            using (SqlDataReader sdr = cmd.ExecuteReader())
            {
                while (sdr.Read())
                {
                    AreaModel area = new AreaModel();
                    area.Title = sdr["title"].ToString();
                    area.FatherId = Convert.ToInt32(sdr["fatherId"]);
                    area.ILevel = Convert.ToInt32(sdr["iLevel"]);
                    area.ISort = Convert.ToInt32(sdr["iSort"]);
                    area.IsOpen = Convert.ToBoolean(sdr["isOpen"]);
                    area.HasChild = Convert.ToBoolean(sdr["hasChild"]);
                    area.Code = sdr["code"].ToString();
                    area.Enabled = Convert.ToBoolean(sdr["enabled"]);
                    if (area.FatherId == 0) area.IsOpen = false;
                    dal_area.Insert(area);
                }
            }
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}
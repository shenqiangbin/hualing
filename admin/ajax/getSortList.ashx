<%@ WebHandler Language="C#" Class="getSortList" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Serialization;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class getSortList : IHttpHandler {

    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    
    public void ProcessRequest (HttpContext context)
    {
        //判断用户登录权限
        if (!bll_admin.IdentityAuth()) return;

        string symbol = context.Request.QueryString["symbol"];
        string fid = context.Request.QueryString["fid"];
        if (String.IsNullOrEmpty(symbol) || !StringHelper.IsNumber(fid)) return;

        List<JsonData> jsonData = new List<JsonData>();
        symbol = symbol.ToLower();

        if (symbol == "category")
        {
            Category bll_category = new Category();

            if (fid == "0")
            {
                CategoryModel group = bll_category.GetModel(context.Request.QueryString["gid"]);
                if (group == null) return;
                fid = group.Pkid.ToString();
            }
            
            List<SqlWhere> sqlWhereList = new List<SqlWhere>();
            sqlWhereList.Add(new SqlWhere(CategoryModel.ENABLED, SqlWhere.Oper.Equal, true));
            sqlWhereList.Add(new SqlWhere(CategoryModel.FATHERID, SqlWhere.Oper.Equal, fid));
            sqlWhereList.Add(new SqlWhere(CategoryModel.PKID, SqlWhere.Oper.NotEqual, context.Request.QueryString["pkid"]));
            List<CategoryModel> categoryList = bll_category.GetList(sqlWhereList);
            if (categoryList.Count == 0) return;

            foreach (CategoryModel model in categoryList)
            {
                JsonData data = new JsonData();
                data.id = model.Pkid;
                data.title = model.Title;
                jsonData.Add(data);
            }
        }

        else if (symbol == "sitemenu")
        {
            SiteMenu bll_siteMenu = new SiteMenu();

            if (fid == "0")
            {
                SiteMenuModel group = bll_siteMenu.GetModel(context.Request.QueryString["gid"]);
                if (group == null) return;
                fid = group.Pkid.ToString();
            }
            
            List<SqlWhere> sqlWhereList = new List<SqlWhere>();
            sqlWhereList.Add(new SqlWhere(SiteMenuModel.ENABLED, SqlWhere.Oper.Equal, true));
            sqlWhereList.Add(new SqlWhere(SiteMenuModel.FATHERID, SqlWhere.Oper.Equal, fid));
            sqlWhereList.Add(new SqlWhere(SiteMenuModel.PKID, SqlWhere.Oper.NotEqual, context.Request.QueryString["pkid"]));
            List<SiteMenuModel> siteMenuList = bll_siteMenu.GetList(sqlWhereList);
            if (siteMenuList.Count == 0) return;

            foreach (SiteMenuModel model in siteMenuList)
            {
                JsonData data = new JsonData();
                data.id = model.Pkid;
                data.title = model.Title;
                jsonData.Add(data);
            }
        }

        else if (symbol == "forummenu")
        {
            ForumMenu bll_forumMenu = new ForumMenu();

            List<SqlWhere> sqlWhereList = new List<SqlWhere>();
            sqlWhereList.Add(new SqlWhere(ForumMenuModel.FATHERID, SqlWhere.Oper.Equal, fid));
            sqlWhereList.Add(new SqlWhere(ForumMenuModel.PKID, SqlWhere.Oper.NotEqual, context.Request.QueryString["pkid"]));
            List<ForumMenuModel> forumMenuList = bll_forumMenu.GetList(sqlWhereList);
            if (forumMenuList.Count == 0) return;

            foreach (ForumMenuModel model in forumMenuList)
            {
                JsonData data = new JsonData();
                data.id = model.Pkid;
                data.title = model.Title;
                jsonData.Add(data);
            }
        }

        else if (symbol == "area")
        {
            Area bll_area = new Area();

            List<SqlWhere> sqlWhereList = new List<SqlWhere>();
            sqlWhereList.Add(new SqlWhere(AreaModel.FATHERID, SqlWhere.Oper.Equal, fid));
            sqlWhereList.Add(new SqlWhere(AreaModel.PKID, SqlWhere.Oper.NotEqual, context.Request.QueryString["pkid"]));
            List<AreaModel> areaList = bll_area.GetList(sqlWhereList);
            if (areaList.Count == 0) return;

            foreach (AreaModel model in areaList)
            {
                JsonData data = new JsonData();
                data.id = model.Pkid;
                data.title = model.Title;
                jsonData.Add(data);
            }
        }

        else if (symbol == "sysmenu")
        {
            SystemMenu bll_systemMenu = new SystemMenu();
            
            List<SqlWhere> sqlWhereList = new List<SqlWhere>();
            sqlWhereList.Add(new SqlWhere(SystemMenuModel.FATHERID, SqlWhere.Oper.Equal, fid));
            sqlWhereList.Add(new SqlWhere(SystemMenuModel.PKID, SqlWhere.Oper.NotEqual, context.Request.QueryString["pkid"]));
            List<SystemMenuModel> systemMenuList = bll_systemMenu.GetList(sqlWhereList);
            if (systemMenuList.Count == 0) return;

            foreach (SystemMenuModel model in systemMenuList)
            {
                JsonData data = new JsonData();
                data.id = model.Pkid;
                data.title = model.Title;
                jsonData.Add(data);
            }
        }

        //序列化
        JavaScriptSerializer objSerializer = new JavaScriptSerializer();
        context.Response.Write(objSerializer.Serialize(jsonData));
    }

    private class JsonData
    {
        public int id { get; set; }
        public string title { get; set; }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}
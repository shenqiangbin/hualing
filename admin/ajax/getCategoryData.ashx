<%@ WebHandler Language="C#" Class="getCategoryData" %>

using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class getCategoryData : IHttpHandler {

    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private Category bll_category = new Category();

    public void ProcessRequest(HttpContext context)
    {
        //判断用户登录权限
        if (!bll_admin.IdentityAuth()) return;
        
        //判断父类是否存在
        string fid = context.Request.QueryString["fid"];
        CategoryModel father = bll_category.GetModel(fid);
        if (father == null) return;

        //获取Json数据
        if (context.Request.QueryString["data"] == "json")
        {
            List<SqlWhere> sqlWhereList = new List<SqlWhere>();
            sqlWhereList.Add(new SqlWhere(CategoryModel.FATHERID, SqlWhere.Oper.Equal, fid));
            sqlWhereList.Add(new SqlWhere(CategoryModel.ENABLED, SqlWhere.Oper.Equal, true));
            List<CategoryModel> categoryList = bll_category.GetList(sqlWhereList);
            if (categoryList.Count == 0) return;

            List<JsonData> jsonData = new List<JsonData>();
            foreach (CategoryModel model in categoryList)
            {
                JsonData data = new JsonData();
                data.id = model.Pkid;
                data.title = model.Title;
                jsonData.Add(data);
            }

            //序列化
            JavaScriptSerializer objSerializer = new JavaScriptSerializer();
            context.Response.Write(objSerializer.Serialize(jsonData));
        }

        //分析选中值
        else
        {
            string selectVal = context.Request.QueryString["selectVal"];
            CategoryModel category = bll_category.GetModel(selectVal);
            if (category == null || String.IsNullOrEmpty(category.Xpath) || category.Xpath.Trim() == "/") return;

            if (fid == "0") context.Response.Write(category.Xpath.Substring(1) + selectVal);
            else
            {
                Regex rx = new Regex(@"^[/\d]*/" + fid + @"/((\d+/)*)$", RegexOptions.IgnoreCase);
                Match m = rx.Match(category.Xpath.Trim());

                if (String.IsNullOrEmpty(m.Groups[1].Value)) return;
                context.Response.Write(m.Groups[1].Value + selectVal);
            }
        }
    }

    private class JsonData {
        public int id { get; set; }
        public string title { get; set; }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}
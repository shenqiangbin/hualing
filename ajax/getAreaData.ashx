<%@ WebHandler Language="C#" Class="getAreaData" %>

using System;
using System.Collections.Generic;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Script.Serialization;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class getAreaData : IHttpHandler {

    //建立业务逻辑层实例
    private Area bll_area = new Area();

    public void ProcessRequest(HttpContext context)
    {
        HttpHelper.CheckUrlReferrer(null);
        
        string fid = context.Request.QueryString["fid"];
        if (!StringHelper.IsNumber(fid)) return;

        //获取Json数据
        if (context.Request.QueryString["data"] == "json")
        {
            List<SqlWhere> sqlWhereList = new List<SqlWhere>();
            sqlWhereList.Add(new SqlWhere(AreaModel.FATHERID, SqlWhere.Oper.Equal, fid));
            sqlWhereList.Add(new SqlWhere(AreaModel.ENABLED, SqlWhere.Oper.Equal, true));
            List<AreaModel> areaList = bll_area.GetList(sqlWhereList);
            if (areaList.Count == 0) return;

            List<JsonData> jsonData = new List<JsonData>();
            foreach (AreaModel model in areaList)
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
            AreaModel area = bll_area.GetModel(selectVal);
            if (area == null || String.IsNullOrEmpty(area.Xpath)) return;

            if (fid == "0") context.Response.Write(area.Xpath.Substring(1) + selectVal);
            else
            {
                Regex rx = new Regex(@"^[/\d]*/" + fid + @"/((\d+/)*)$", RegexOptions.IgnoreCase);
                Match m = rx.Match(area.Xpath.Trim());

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
<%@ WebHandler Language="C#" Class="getMultipleData" %>

using System;
using System.Collections.Generic;
using System.Web;
using System.Web.Script.Serialization;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class getMultipleData : IHttpHandler {

    //建立业务逻辑层实例
    private Area bll_area = new Area();
    
    public void ProcessRequest (HttpContext context)
    {
        HttpHelper.CheckUrlReferrer(null);
        
        string index = context.Request.QueryString["index"];
        string fid = context.Request.QueryString["fid"];
        if (!StringHelper.IsNumber(index) || !StringHelper.IsNumber(fid)) return;

        List<JsonData> jsonData = new List<JsonData>();
        
        if (index == "1")
        {
            List<SqlWhere> sqlWhereList = new List<SqlWhere>();
            sqlWhereList.Add(new SqlWhere(AreaModel.FATHERID, SqlWhere.Oper.Equal, fid));
            sqlWhereList.Add(new SqlWhere(AreaModel.ENABLED, SqlWhere.Oper.Equal, true));
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

        else if (index == "2")
        {
            List<SqlWhere> sqlWhereList = new List<SqlWhere>();
            sqlWhereList.Add(new SqlWhere(AreaModel.FATHERID, SqlWhere.Oper.Equal, fid));
            sqlWhereList.Add(new SqlWhere(AreaModel.ENABLED, SqlWhere.Oper.Equal, true));
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
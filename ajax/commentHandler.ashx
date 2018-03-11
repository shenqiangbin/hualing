<%@ WebHandler Language="C#" Class="commentHandler" %>

using System;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class commentHandler : IHttpHandler {

    Comment bll_comment = new Comment();
    Member bll_member = new Member();
    
    public void ProcessRequest (HttpContext context)
    {
        string action = context.Request.QueryString["action"];
        string pkid = context.Request.QueryString["pkid"];

        if (action == "add")
        {
            string sumbol = context.Request.QueryString["sumbol"];
            string fkid = context.Request.QueryString["fkid"];
            string point = context.Request.QueryString["point"];
            string nickname = context.Request.QueryString["nickname"];
            string content = HttpUtility.UrlDecode(context.Request.QueryString["content"]);
            
            if (!StringHelper.IsNumber(fkid)) fkid = "0";
            if (!StringHelper.IsNumber(point)) point = "2";

            CommentModel comment = new CommentModel();
            comment.Relation = sumbol;
            comment.RelationId = Convert.ToInt32(fkid);
            comment.Nickname = nickname;
            comment.Point = Convert.ToInt32(point);
            comment.Content = content;
            comment.Enabled = true;
            if (StringHelper.IsNumber(bll_member.CookieId)) comment.Creator = Convert.ToInt32(bll_member.CookieId);
            comment.CreateTime = DateTime.Now.ToString();
            bll_comment.Insert(comment);
            
            context.Response.Write("感谢您的评价");
        }

        else if (action == "agree")
        {
            if (bll_comment.AgreeOrOppose(pkid, true)) context.Response.Write("评价成功！");
            else context.Response.Write("您已经对该评论表明过态度了，谢谢！");
        }

        else if (action == "oppose")
        {
            if (bll_comment.AgreeOrOppose(pkid, false)) context.Response.Write("评价成功！");
            else context.Response.Write("您已经对该评论表明过态度了，谢谢！");
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}
<%@ WebHandler Language="C#" Class="friendHandler" %>

using System;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class friendHandler : IHttpHandler {

    Member bll_member = new Member();
    MemberRelation bll_memberRelation = new MemberRelation();
    
    public void ProcessRequest (HttpContext context)
    {
        if (!bll_member.IdentityAuth()) return;
        int myId = Convert.ToInt32(bll_member.CookieId);

        MemberModel friend = bll_member.GetModel(context.Request.QueryString["uid"]);
        if (friend == null) { context.Response.Write("101"); return; }

        MemberRelationModel memberRelation = bll_memberRelation.GetModelByFriendId(myId, friend.Pkid);
        if (memberRelation == null)
        {
            memberRelation = new MemberRelationModel();
            memberRelation.MemberId = myId;
            memberRelation.FriendId = friend.Pkid;
            memberRelation.Enabled = true;
        }
        else
        {
            memberRelation.Enabled = !memberRelation.Enabled;
        }

        bll_memberRelation.Update(memberRelation);
        context.Response.Write(memberRelation.Enabled.ToString().ToLower());
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }

}
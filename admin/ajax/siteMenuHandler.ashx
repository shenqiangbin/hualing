<%@ WebHandler Language="C#" Class="siteMenuHandler" %>

using System;
using System.Collections.Generic;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public class siteMenuHandler : IHttpHandler {

    //建立业务逻辑层实例
    private Admin bll_admin = new Admin();
    private SiteMenu bll_siteMenu = new SiteMenu();
    private Category bll_category = new Category();
    private OnePage bll_onePage = new OnePage();
    private ForumMenu bll_forumMenu = new ForumMenu();
    
    public void ProcessRequest (HttpContext context)
    {
        //判断用户登录权限
        if (!bll_admin.IdentityAuth()) return;
        if (!bll_admin.RuleAuth("全局_导航菜单")) return;

        string action = context.Request.QueryString["action"];
        string pkid = context.Request.QueryString["pkid"];
        string fatherId = context.Request.QueryString["fid"];
        string target = context.Request.QueryString["target"];

        if (String.IsNullOrEmpty(action)) return;
        action = action.ToLower();

        if (action == "gettitle")
        {
            SiteMenuModel menu = bll_siteMenu.GetModel(pkid);
            if (menu == null) context.Response.Write("!N");
            else context.Response.Write(menu.Title);
        }

        else if (action == "add")
        {
            string title = context.Request.QueryString["title"];
            string url = context.Request.QueryString["url"];

            SiteMenuModel father = bll_siteMenu.GetModel(fatherId);
            if (father == null) return;
            
            if (String.IsNullOrEmpty(title)) return;

            SiteMenuModel siteMenu = new SiteMenuModel();
            siteMenu.FatherId = father.Pkid;
            siteMenu.Title = context.Server.UrlDecode(title);
            siteMenu.Url = context.Server.UrlDecode(url);
            siteMenu.Target = target;
            bll_siteMenu.Insert(siteMenu);
            context.Response.Write("1");
        }

        else if (action == "addpage")
        {
            SiteMenuModel father = bll_siteMenu.GetModel(fatherId);
            if (father == null) return;
            
            OnePageModel onePage = bll_onePage.GetModel(context.Request.QueryString["pageId"]);
            if (onePage == null) return;

            SiteMenuModel siteMenu = new SiteMenuModel();
            siteMenu.FatherId = father.Pkid;
            siteMenu.Title = onePage.Title;
            siteMenu.Url = onePage.Url;
            siteMenu.Target = target;
            siteMenu.Relation = OnePageModel._SYMBOL;
            siteMenu.RelationId = onePage.Pkid;
            bll_siteMenu.Insert(siteMenu);
            context.Response.Write("1");
        }

        else if (action == "addcat")
        {
            SiteMenuModel father = bll_siteMenu.GetModel(fatherId);
            if (father == null) return;
            
            CategoryModel category = bll_category.GetModel(pkid);
            if (category == null) return;

            string pattern = context.Request.QueryString["pattern"];

            if (pattern == "self")
            {
                SiteMenuModel siteMenu = new SiteMenuModel();
                siteMenu.FatherId = father.Pkid;
                siteMenu.Title = category.Title;
                siteMenu.Url = category.Url;
                siteMenu.Target = target;
                siteMenu.Relation = CategoryModel._SYMBOL;
                siteMenu.RelationId = category.Pkid;
                bll_siteMenu.Insert(siteMenu);
            }
            else if (pattern == "all")
            {
                AddChildren(category, father.Pkid, target);
            }

            context.Response.Write("1");
        }

        else if (action == "addbbs")
        {
            SiteMenuModel father = bll_siteMenu.GetModel(fatherId);
            if (father == null) return;

            ForumMenuModel forumMenu = bll_forumMenu.GetModel(pkid);
            if (forumMenu == null) return;

            string pattern = context.Request.QueryString["pattern"];

            if (pattern == "self")
            {
                SiteMenuModel siteMenu = new SiteMenuModel();
                siteMenu.FatherId = father.Pkid;
                siteMenu.Title = forumMenu.Title;
                siteMenu.Url = forumMenu.Url;
                siteMenu.Target = target;
                siteMenu.Relation = CategoryModel._SYMBOL;
                siteMenu.RelationId = forumMenu.Pkid;
                bll_siteMenu.Insert(siteMenu);
            }
            else if (pattern == "all")
            {
                AddChildren(forumMenu, father.Pkid, target);
            }

            context.Response.Write("1");
        }

        else if (action == "onoff") bll_siteMenu.UpdateStatus(pkid, "onoff");
        else if (action == "moveup") bll_siteMenu.MoveUp(pkid);
        else if (action == "movedown") bll_siteMenu.MoveDown(pkid);
        else if (action == "enab") bll_siteMenu.UpdateStatus(pkid, "enab");
        else if (action == "target") bll_siteMenu.UpdateStatus(pkid, "target");
        else if (action == "del") bll_siteMenu.Delete(pkid);
        else if (action == "onoff_cat") bll_category.UpdateStatus(pkid, "onoff");
        else if (action == "onoff_bbs") bll_forumMenu.UpdateStatus(pkid, "onoff");
    }

    private void AddChildren(CategoryModel category, int fid, string target)
    {
        SiteMenuModel siteMenu = new SiteMenuModel();
        siteMenu.FatherId = fid;
        siteMenu.Title = category.Title;
        siteMenu.Url = category.Url;
        siteMenu.Target = target;
        siteMenu.Relation = CategoryModel._SYMBOL;
        siteMenu.RelationId = category.Pkid;
        bll_siteMenu.Insert(siteMenu);

        if (category.HasChild)
        {
            List<CategoryModel> categoryList = bll_category.GetListByFatherId(category.Pkid);
            foreach (CategoryModel model in categoryList) AddChildren(model, siteMenu.Pkid, target);
        }
    }

    private void AddChildren(ForumMenuModel forumMenu, int fid, string target)
    {
        SiteMenuModel siteMenu = new SiteMenuModel();
        siteMenu.FatherId = fid;
        siteMenu.Title = forumMenu.Title;
        siteMenu.Url = forumMenu.Url;
        siteMenu.Target = target;
        siteMenu.Relation = ForumMenuModel._SYMBOL;
        siteMenu.RelationId = forumMenu.Pkid;
        bll_siteMenu.Insert(siteMenu);

        if (forumMenu.HasChild)
        {
            List<ForumMenuModel> forumMenuList = bll_forumMenu.GetListByFatherId(forumMenu.Pkid);
            foreach (ForumMenuModel model in forumMenuList) AddChildren(model, siteMenu.Pkid, target);
        }
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}
using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using QianZhu.Model;
using QianZhu.Utility;

public partial class ajax_message : System.Web.UI.Page
{
    //建立业务逻辑层实例
    private QianZhu.BLL.Message bll_message = new QianZhu.BLL.Message();

    //设置页面大小
    int iPageSize = 5;
    
    protected void Page_Load(object sender, EventArgs e)
    {
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
        //组合查询条件
        //List<SqlWhere> sqlWhereList = new List<SqlWhere>();
        //sqlWhereList.Add(new SqlWhere(MessageModel.GROUPNAME, SqlWhere.Oper.Equal, Request.QueryString["groupName"]));
        //sqlWhereList.Add(new SqlWhere(MessageModel.FKID, SqlWhere.Oper.Equal, Request.QueryString["fkid"]));

        ////读取分页数据
        //int iRecordsTotal = bll_message.DoCount(sqlWhereList);
        //QianZhu.Utility.Pagination pagination = new QianZhu.Utility.Pagination(Request.QueryString["page"], iRecordsTotal, iPageSize, "javascript:ajax_getMessageList('" + Request.QueryString["objId"] + "', '" + Request.QueryString["groupName"] + "', '" + Request.QueryString["fkid"] + "', $p);");
        //Paging.InnerHtml = pagination.Show();
        //List<MessageModel> messageList = bll_message.GetList(pagination.PageIndex, iPageSize, sqlWhereList, null);

        ////绑定
        //if (messageList.Count == 0) Paging.Visible = false;
        //Repeater1.DataSource = messageList;
        //Repeater1.DataBind();
    }

    protected void Repeater1_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        //MessageModel message = (MessageModel)e.Item.DataItem;
        //((HtmlGenericControl)e.Item.FindControl("Eval_Content")).InnerHtml = StringHelper.TextToHtml(message.Content);

        //if (message.IsReply)
        //{
        //    ((HtmlTableRow)e.Item.FindControl("Eval_ReplyTr")).Visible = true;
        //    ((HtmlGenericControl)e.Item.FindControl("Eval_Reply")).InnerHtml = StringHelper.TextToHtml(message.Reply);
        //}
    }
}

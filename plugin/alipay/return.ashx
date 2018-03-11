<%@ WebHandler Language="C#" Class="alipay_return" %>

using System;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Web;
using QianZhu.BLL;
using QianZhu.API.Alipay;

public class alipay_return : IHttpHandler {

    //建立业务逻辑层实例
    private Orders bll_orders = new Orders();
    
    public void ProcessRequest (HttpContext context)
    {
        SortedDictionary<string, string> sPara = GetRequestGet(context);

        if (sPara.Count > 0)//判断是否有带返回参数
        {
            Notify aliNotify = new Notify();
            bool verifyResult = aliNotify.Verify(sPara, context.Request.QueryString["notify_id"], context.Request.QueryString["sign"]);

            //验证成功
            if (verifyResult)
            {
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //请在这里加上商户的业务逻辑程序代码


                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                //获取支付宝的通知返回参数，可参考技术文档中页面跳转同步通知参数列表

                //商户订单号
                string out_trade_no = context.Request.QueryString["out_trade_no"];

                //支付宝交易号
                string trade_no = context.Request.QueryString["trade_no"];

                //交易状态
                string trade_status = context.Request.QueryString["trade_status"];

                if (trade_status == "TRADE_FINISHED" || trade_status == "TRADE_SUCCESS")
                {
                    //判断该笔订单是否在商户网站中已经做过处理
                    //如果没有做过处理，根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序
                    //如果有做过处理，不执行商户的业务程序
                    
                    //返回付款成功页面
                    context.Response.Redirect("/order/result/?trackId=" + out_trade_no);
                }
                else
                {
                    context.Response.Write("trade_status=" + trade_status);
                }

                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }

            //验证失败
            else
            {
                context.Response.Write("验证失败");
            }
        }
        else
        {
            context.Response.Write("无返回参数");
        }
    }

    /// <summary>
    /// 获取支付宝GET过来通知消息，并以“参数名=参数值”的形式组成数组
    /// </summary>
    /// <returns>request回来的信息组成的数组</returns>
    public SortedDictionary<string, string> GetRequestGet(HttpContext context)
    {
        int i = 0;
        SortedDictionary<string, string> sArray = new SortedDictionary<string, string>();
        NameValueCollection coll;
        //Load Form variables into NameValueCollection variable.
        coll = context.Request.QueryString;

        // Get names of all forms into a string array.
        String[] requestItem = coll.AllKeys;

        for (i = 0; i < requestItem.Length; i++)
        {
            sArray.Add(requestItem[i], context.Request.QueryString[requestItem[i]]);
        }

        return sArray;
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}
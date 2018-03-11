<%@ WebHandler Language="C#" Class="alipay_notify" %>

using System;
using System.Collections.Specialized;
using System.Collections.Generic;
using System.Web;
using QianZhu.BLL;
using QianZhu.API.Alipay;

public class alipay_notify : IHttpHandler {

    //建立业务逻辑层实例
    private Orders bll_orders = new Orders();
    
    public void ProcessRequest (HttpContext context)
    {        
        SortedDictionary<string, string> sPara = GetRequestPost(context);

        if (sPara.Count > 0)//判断是否有带返回参数
        {
            Notify aliNotify = new Notify();
            bool verifyResult = aliNotify.Verify(sPara, context.Request.Form["notify_id"], context.Request.Form["sign"]);

            //验证成功
            if (verifyResult)
            {
                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
                //请在这里加上商户的业务逻辑程序代码
                

                //——请根据您的业务逻辑来编写程序（以下代码仅作参考）——
                //获取支付宝的通知返回参数，可参考技术文档中服务器异步通知参数列表

                //商户订单号
                string out_trade_no = context.Request.Form["out_trade_no"];

                //支付宝交易号
                string trade_no = context.Request.Form["trade_no"];

                //交易状态
                string trade_status = context.Request.Form["trade_status"];

                if (trade_status == "TRADE_FINISHED" || trade_status == "TRADE_SUCCESS")
                {
                    //根据订单号（out_trade_no）在商户网站的订单系统中查到该笔订单的详细，并执行商户的业务程序

                    string notes = "支付宝交易号：" + trade_no;
                    bll_orders.PaymentSuccess(out_trade_no, notes);
                }
                else
                {
                }

                //——请根据您的业务逻辑来编写程序（以上代码仅作参考）——

                context.Response.Write("success");  //请不要修改或删除

                /////////////////////////////////////////////////////////////////////////////////////////////////////////////
            }

            //验证失败
            else
            {
                context.Response.Write("fail");
            }
        }
        else
        {
            context.Response.Write("无通知参数");
        }
    }

    /// <summary>
    /// 获取支付宝POST过来通知消息，并以“参数名=参数值”的形式组成数组
    /// </summary>
    /// <returns>request回来的信息组成的数组</returns>
    private SortedDictionary<string, string> GetRequestPost(HttpContext context)
    {
        int i = 0;
        SortedDictionary<string, string> sArray = new SortedDictionary<string, string>();
        NameValueCollection coll;
        //Load Form variables into NameValueCollection variable.
        coll = context.Request.Form;

        // Get names of all forms into a string array.
        String[] requestItem = coll.AllKeys;

        for (i = 0; i < requestItem.Length; i++)
        {
            sArray.Add(requestItem[i], context.Request.Form[requestItem[i]]);
        }

        return sArray;
    }
 
    public bool IsReusable {
        get {
            return false;
        }
    }
}
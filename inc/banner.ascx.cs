using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using QianZhu.BLL;
using QianZhu.Model;
using QianZhu.Utility;

public partial class inc_banner : System.Web.UI.UserControl
{
    public int kind = 11;
    private AdFixed bll_adFixed = new AdFixed();
    protected AdFixedModel ad6 = new AdFixedModel();  //
    protected void Page_Load(object sender, EventArgs e)
    {
        ad6 = bll_adFixed.GetModel(kind);
    }

}
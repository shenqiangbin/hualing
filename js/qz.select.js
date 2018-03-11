/*
* Select control plugin
*
* Copyright (c) 2013 qianzhu
* http://www.1000zhu.com/
*
*/

(function($) {

    // For single data table
    $.fn.QzSelect = function(options) {
        var defaults = {
            dataSource: "",
            fatherId: 0,
            chooseEnd: false,
            titles: "",
            cssClass: ""
        };
        var o = $.extend(defaults, options);
        var selectVal = $(this).val();

        return $(this).each(function() {
            $(this).hide().after("<input type='hidden' />");
            if (isNull(selectVal)) $.fn.QzSelect.getJsonData($(this), 0, null, o);
            else $.fn.QzSelect.setSelectValue($(this), selectVal, o);
        });
    }


    $.fn.QzSelect.getJsonData = function(item, i, selectVal, options) {
   
        // Clear selected value
        var prevObj;
        if (i > 0) {
            prevObj = item.prev();
            while (true) {
                if (prevObj.get(0).tagName == "INPUT") {
                    prevObj.val(""); break;
                }
                else prevObj = prevObj.prev();
            }
        }

        // Remove the unrelated elements
        while (true) {
            if (item.next().get(0).tagName == "INPUT") break;
            item.next().remove();
        }

        // Get data
        $.ajax({
            url: options.dataSource,
            type: "get",
            data: "data=json&fid=" + options.fatherId + "&rnd=" + Math.floor(Math.random() * 9999),
            dataType: "json",
            success: function(data) {

                // Save selected value
                if (i > 0 && (!options.chooseEnd || (options.chooseEnd && isNull(data)))) {
                    prevObj.val(options.fatherId);
                }

                if (isNull(data)) return;

                // Set first option title
                var title = "请选择";
                if (options.titles != null) {
                    var arrTitle = options.titles.split(",");
                    if (arrTitle.length > i && arrTitle[i].length > 0)
                        title = arrTitle[i];
                }

                // Append next element
                var strHtml = "<select>";
                strHtml += "<option value=''>--" + title + "--</option>";
                for (var n = 0; n < data.length; n++)
                    strHtml += "<option value='" + data[n].id + "'>" + data[n].title + "</option>";
                strHtml += "</select>";

                var select = $(strHtml);

                select.addClass(options.cssClass).change(function(e) {
                    options.fatherId = $(this).val();
                    $.fn.QzSelect.getJsonData($(this), i + 1, null, options);
                });

                item.after(select).after("\n");

                // Select Value
                if (!isNull(selectVal)) {
                    var ids = selectVal.toString().split("/");
                    if (ids.length > i) {
                        options.fatherId = ids[i];
                        select.val(options.fatherId);
                        if (options.fatherId > 0) $.fn.QzSelect.getJsonData(select, i + 1, selectVal, options);
                    }
                }
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown);
            }
        });
    }


    $.fn.QzSelect.setSelectValue = function(item, selectVal, options) {

        $.get(options.dataSource, {
            rnd: Math.floor(Math.random() * 9999),
            fid: options.fatherId,
            selectVal: selectVal
        }, function(data, textStatus) {
            if (textStatus == "success") {
                if (!isNull(data)) selectVal = data;
                $.fn.QzSelect.getJsonData(item, 0, selectVal, options);
            }
        });
    }


    // For multiple data table
    $.fn.QzMultSelect = function(options) {
        var defaults = {
            dataSource: "",
            fatherId: 0,
            index: 1
        };
        var o = $.extend(defaults, options);
        var $this = $(this);

        // Get data
        $.ajax({
            url: o.dataSource,
            type: "get",
            data: "index=" + o.index + "&fid=" + o.fatherId + "&rnd=" + Math.floor(Math.random() * 9999),
            dataType: "json",
            success: function(data) {

                // Set option title
                var optionTitle = $this.find("option:eq(0)");
                if (optionTitle != null && !isNull(optionTitle.val())) optionTitle = null;
                $this.empty();
                if (optionTitle != null) $this.append(optionTitle);

                if (isNull(data)) return;

                // Set the next select control change event
                if (!isNull($this.attr("rel"))) {
                    $this.change(function(e) {
                        var event = $("#" + $(this).attr("rel"));
                        if (!event) return;
                        event.QzMultSelect({
                            dataSource: o.dataSource,
                            fatherId: $(this).val(),
                            index: o.index + 1,
                            titles: o.titles
                        });
                    });
                }
                // Set myself data
                for (var n = 0; n < data.length; n++)
                    $this.append("<option value='" + data[n].id + "'>" + data[n].title + "</option>");

                // Set value
                if (!isNull($this.attr("val"))) $this.val($this.attr("val"));
                if (!isNull($this.val())) $this.trigger("change");
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
                alert(errorThrown);
            }
        });
    }


    function isNull(str) {
        if (str == null || str == "" || str.length < 1) return true;
        else return false;
    }

})(jQuery);
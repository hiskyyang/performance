function deleteMeasure(measureId) {
    var flag = confirm("确定删除吗？");
    if (flag == false) {
        return;
    }

    var data = {measureId: measureId};

    post("measure/delete", data, window.location, false);
}

function save() {
    if (!isValid()) {
        return false;
    }

    var data = constructData();

    var action = "performance/update";
    _post(action, data, window.location, false);
}

function constructData() {
    var performanceIds = document.getElementsByName("performanceId");
    var scores = document.getElementsByName("score");
    var array = [];
    for (var i = 0; i < performanceIds.length; i++) {
        var data = {
            performanceId: performanceIds[i].value,
            score: scores[i].value
        };
        array.push(data);
    }
    return JSON.stringify(array);
}

function isValid() {
    var performanceIds = document.getElementsByName("performanceId");
    var scores = document.getElementsByName("score");
    for (i = 0; i < performanceIds.length; i++) {
        if (null == scores[i].value || "" == scores[i].value) {
            alert("分数不能为空！");
            scores[i].focus();
            return false;
        }
        if (scores[i].value < 0 || scores[i].value > 100) {
            alert("分数需在0-100以内！");
            scores[i].focus();
            return false;
        }
    }
    return true;
}


function _post(url, data, dom, close) {
    $.ajax({
        url: url,
        type: "POST",
        data: data,
        dataType: 'json',
        contentType: "application/json",
        success: function (result) {
            if (result != 0) {
                dom.reload();

                if (close) {
                    window.close();
                }
            } else {
                alert("失败");
            }
        }
    });
}
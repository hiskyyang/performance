function deleteExam(examId) {
    var flag = confirm("确定删除吗？");
    if (flag == false) {
        return;
    }

    var data = {examId: examId};

    post("exam/delete", data, window.location, false);
}

function save() {
    if (!isValid()) {
        return false;
    }

    var data = constructData();

    var action = "" == $("#examId").val() ? "exam/add" : "exam/update";
    post(action, data, window.opener.location, true);
}

function constructData() {
    var data = {
        examId: $("#examId").val(),
        name: $("#name").val(),
        startTime: $("#startTime").val(),
        endTime: $('#endTime').val(),
        status: $('#status').val()
    };
    return data;
}

function isValid() {
    if (isEmpty("name", "请输入名称！")) {
        return false;
    }

    if (isEmpty("startTime", "请选择开始时间！")) {
        return false;
    }

    if (isEmpty("endTime", "请选择结束时间！")) {
        return false;
    }

    if (isEmpty("status", "请选择状态！")) {
        return false;
    }

    return true;
}

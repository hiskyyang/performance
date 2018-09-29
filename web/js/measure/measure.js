function deleteMeasure(measureId) {
    var flag = confirm("确定删除吗？");
    if (flag == false) {
        return;
    }

    var data = {measureId: measureId};

    post("measure/delete", data, window.location, false);
    window.location.reload();
}

function save() {
    if (!isValid()) {
        return false;
    }

    var data = constructData();

    var action = "" == $("#measureId").val() ? "measure/add" : "measure/update";
    post(action, data, window.opener.location, true);
}

function constructData() {
    var data = {
        measureId: $("#measureId").val(),
        examId: $("#examId").val(),
        name: $("#name").val(),
        description: $("#description").val(),
        weight: $('#weight').val(),
        status: $('#status').val()
    };
    return data;
}

function isValid() {
    if (isEmpty("name", "请输入名称！")) {
        return false;
    }

    if (isEmpty("weight", "请输入权重！")) {
        return false;
    }

    if($('#weight').val() < 0 || $('#weight').val() > 100){
        alert("权重需在0-100以内！");
        $('#weight').focus();
        return false;
    }

    return true;
}

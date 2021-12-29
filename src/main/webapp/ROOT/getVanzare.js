$().ready(function (){
    $("#comboTip").change(function (){
        let type = $("#comboTip").val();

        $.ajax({
            url: 'http://localhost:8080/ProiectISI_war_exploded/getvanzare',
            method: 'get',
            data: {type: type},
            success: function(data) {
                let key;
                if (type === "Piese")
                    key = "codp";
                else if (type === "Autoturisme")
                    key = "vin";

                $("#combocodp").empty();
                for(let i = 0; i<data.length; i++)
                    $('#combocodp').append('<option value="' + data[i][key] + '">' + data[i][key] + '</option>')
            },
            error: function() {
                $("#combocodp").empty();
                $('#combocodp').append('<option>Error</option>');
            },
        })
    })

    $("#combocodp").change(function (){
        let typeS = $("#comboTip").val();
        let codpS = $("#combocodp").val();

        if (typeS == null)
            typeS = "Piese";

        $.ajax({
            url: 'http://localhost:8080/ProiectISI_war_exploded/getvanzare',
            method: 'get',
            data: {typeS: typeS, codpS: codpS},
            success: function(data) {
                let den, pret, prettva;
                if (typeS === "Piese") {
                    den = "denp";
                    pret = "pretp";
                    prettva = "pretptva";
                }
                else if (typeS === "Autoturisme") {
                    den = "model";
                    pret = "preta";
                    prettva = "pretatva";
                }

                $("#produs").val(data[0][den]);
                $("#pret").val(data[0][pret]);
                $("#prettva").val(data[0][prettva]);
            },
            error: function() {
                $("#produs").val("Error");
                $("#pret").val("Error");
                $("#prettva").val("Error");
            }
        })
    })

    $("#combonumec").change(function (){
        let numec = $("#combonumec").val();
        $.ajax({
            url: 'http://localhost:8080/ProiectISI_war_exploded/getvanzare',
            method: 'get',
            data: {numec: numec},
            success: function(data) {
                $("#comboprenumec").empty();
                for(let i = 0; i<data.length; i++)
                    $('#comboprenumec').append("<option value='" + data[i]['prenumec'] + "'>" + data[i]['prenumec'] + "</option>");
            },
            error: function() {
                $("#comboprenumec").empty();
                $('#comboprenumec').append('<option>Error</option>');
            }
        })
    })
})
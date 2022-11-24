
function objectifyForm(formArray) {
	var returnArray = {};
	for (var i = 0; i < formArray.length; i++){
		returnArray[formArray[i]['name']] = formArray[i]['value'];
	}
	return returnArray;
}

function doajax(apiUrl, methodType, requData) {
	return $.ajax({
				    type: methodType,
				    url: apiUrl,
				    dataType: "json",
				    contentType: "application/json; charset=utf-8",
				    data: JSON.stringify(requData),
				    success: function (data){
						//return data.responseJSON;
				    }
				});
}

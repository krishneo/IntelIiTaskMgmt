$.fn.serializeObject = function()
{
    var o = {};
    var a = this.serializeArray();
    $.each(a, function() {
        if (o[this.name] !== undefined) {
            if (!o[this.name].push) {
                o[this.name] = [o[this.name]];
            }
            o[this.name].push(this.value || '');
        } else {
            o[this.name] = this.value || '';
        }
    });
    return o;
};


function clearMessage() {
	$('#message_holder').attr("class", "").html("") ;
}

function setInfoMessage (msg) {
	$('#message_holder').attr("class", "alert_info").html(msg) ;
}

function setErrorMessage (msg) {
	$('#message_holder').attr("class", "alert_error").html(msg) ;
}

function setSuccessMessage (msg) {
	$('#message_holder').attr("class", "alert_success").html(msg) ;
}

function getQueryVariable(variable)
{
       var query = window.location.search.substring(1);
       var vars = query.split("&");
       for (var i=0;i<vars.length;i++) {
               var pair = vars[i].split("=");
               if(pair[0] == variable){return pair[1];}
       }
       return(false);
}

$(document).ready(function() {
	 $("contact_support").click(function(){
		 	alert("YTD !!!") ;
	 }) ;
});

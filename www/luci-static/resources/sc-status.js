//charset:utf-8;
function RefreshStatus()
{
	var url;
	url=window.location.pathname;
	if(url.indexOf("scDial")==-1)
		return;
	XHR.get(url,null,function(xhr,json){
		var res=xhr.responseText;
		for(var i=0;i<2;i++){
			res=res.substr(res.indexOf("cbi-value-description"));
			res=res.substr(res.indexOf("</span>") + 8);
		}
		res=res.substring(0,res.indexOf("</div>"));
		res=res.replace(/\s/g,"");
		var d=new Date();
		var html="<span class='cbi-value-helpicon'><img src='/luci-static/resources/cbi/help.gif' alt='°ïÖú' /></span>";
		html+= d.getHours() +":" +d.getMinutes()+ ":" +d.getSeconds()+" " +res;
		var node=document.querySelectorAll(".cbi-value-description");
		node[1].innerHTML=html;
	});
}

if(window.location.pathname.indexOf("scDial")>0)
	setInterval(RefreshStatus,5000);
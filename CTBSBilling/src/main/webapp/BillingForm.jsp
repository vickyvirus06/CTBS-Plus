<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<script>
var request;

function verifyCustomer()  
{  

	document.getElementById("cust_id").innerHTML = " ";		
	document.getElementById("cust_name").innerHTML = " ";
	document.getElementById("cust_mobile_no").innerHTML = " ";
	document.getElementById("cust_reg_date").innerHTML = " ";
	document.getElementById("cust_city").innerHTML = " ";
	document.getElementById("cust_email").innerHTML = " ";
	
	document.getElementById("cust_err").innerHTML = " ";
	
	var customer_id = document.billingform.cust_id.value;
var url="http://localhost:8081/Customer/"+customer_id;  
if(window.XMLHttpRequest){  
request=new XMLHttpRequest();  
}  
else if(window.ActiveXObject){  
request=new ActiveXObject("Microsoft.XMLHTTP");  
}  
  
try{  
request.onreadystatechange=getInfo;  
request.open("GET",url,true);  
request.send();  
}catch(e){alert("Unable to connect to server");}  
}  
  
function getInfo(){  
if(request.readyState==4){
	var cust_details = request.responseText;
	
	console.log(cust_details);
	if(cust_details == null || cust_details.trim() == " " || cust_details == 'undefined' || cust_details.length == 0)
		{
		console.log("inside");
		document.getElementById("cust_err").innerHTML = "Incorect Customer Id";		
		}
	else
		{
			var cust_data  = JSON.parse(cust_details);
			console.log(cust_data.cust_id)
			if(cust_data.cust_id != null || cust_data.name!= null || cust_data.mobile_no !=null || cust_data.date_registration != null)
				{
				document.getElementById("cust_id").innerHTML = cust_data.cust_id;		
				document.getElementById("cust_name").innerHTML = cust_data.name;
				document.getElementById("cust_mobile_no").innerHTML = cust_data.mobile_no;
				document.getElementById("cust_reg_date").innerHTML = cust_data.date_of_registration;
				document.getElementById("cust_city").innerHTML = cust_data.city;
				document.getElementById("cust_email").innerHTML = cust_data.email;
				}
			
		
		}
	

}  
}  
  
  
  function calculatePrice()
  {
	  
	   var cust_id = document.billingform.cust_id.value;
	  console.log("Id  " + cust_id);
	   if(cust_id == null || cust_id == " ")
		  {
		  	alert("Enter Customer Id");
		  }
	  else
		  {
		  
		  
	  
	  
	  weight = document.billingform.weight.value;
	  pick_city = document.billingform.pick_city.value;
	  delivery_city = document.billingform.delivery_city.value;
	  type_of_good = document.billingform.type_of_good.value;
	  pick_up_type=document.billingform.pick_up_type.value;
	  transportation = document.billingform.transportation.value;
	  
	  var url = "http://localhost:8082/RateCalculation/"+weight+"/"+type_of_good+"/"+pick_city+"/"+delivery_city+"/"+pick_up_type+"/"+transportation;

	  if(window.XMLHttpRequest){  
		  request=new XMLHttpRequest();  
		  }  
		  else if(window.ActiveXObject){  
		  request=new ActiveXObject("Microsoft.XMLHTTP");  
		  }  
		    
		  try{  
		  request.onreadystatechange=calculate;  
		  request.open("GET",url,true);  
		  console.log("workings");
		  request.send();  
		  }catch(e){alert("Unable to connect to server");}  
		  
  }
  }
	 function calculate()
	 {
		 if(request.readyState==4){
				var amount_details = request.responseText;
				
						var amount_data  = JSON.parse(amount_details);
							console.log(amount_data);
							document.getElementById("base").innerHTML = amount_data.basic;		
							document.getElementById("gst").innerHTML = amount_data.gst+"%";
							document.getElementById("total").innerHTML = amount_data.total_charge;
						
						
					
					}

	 }
  
</script>  
<meta charset="ISO-8859-1">
<title>CTBS Plus</title>
</head>
<body style="background-color:lightblue;font-size:20px;">
<h1 style="color:white;background-color:gray;"><marquee>CTBS Plus System</marquee></h1>
<form name="billingform" >
<label style="font-weight: bold;color:blue;">
Customer Id  </label><input style="margin-bottom: 15px;" type="text" name="cust_id" onkeyup="verifyCustomer()"><span style="margin-left:8px;color:red;" id="cust_err"></span><br>
Name   <input type="text" name="name" >
Email  <input type="text" name="email">
Mobile No  <input type="text" name="mobile_no">
<br><br>
<label style="font-weight: bold;">Weight</label> <input type="radio" value="5" name="weight">5kg
<input type="radio" value="10" name="weight"> 5-10 kg 
<input type="radio" value="15" name="weight"> 15-25 kg 
<label style="font-weight: bold;margin-left: 30px;">Type of Good</label>
 <select name="type_of_good">
<option value="liquid">Liquid</option>
<option value="jewellery">Jewellery</option>
<option value="container">Container</option>
<option value="others">Others</option>
</select>
<label style="font-weight: bold;">Pick Up Type</label> 
<select name="pick_up_type">
<option value="door">Door Step PickUp</option>
<option value="branch">Branch Pickup</option>
<option value="office">Office PickUp</option>
</select>

<label style="font-weight: bold;">Transportation Type</label> 
<select name="transportation">
<option value="road">By Road</option>
<option value="air">Airways</option>
<option value="ship">Ship for inflammable Containers</option>
</select>
<br></br>
<label style="font-weight: bold;">Pick Up City</label> <select name="pick_city">
<option value="mumbai">Mumbai</option>
<option value="bangalore">Bangalore</option>
<option value="delhi">Delhi</option>
<option value="chennai">Chennai</option>
<option value="hyderabad">Hyderabad</option>
<option value="gujrat">Gujrat</option>
<option value="gurgaon">Gurgaon</option>
<option value="jharkand">Jharkand</option>
</select>
<label style="font-weight: bold;">Pick Up Address</label> <textarea rows="5" style="margin-top:20px;" name="pick_up_address"></textarea>
<label style="font-weight: bold;">Delivery City </label><select name="delivery_city">
<option value="mumbai">Mumbai</option>
<option value="bangalore">Bangalore</option>
<option value="delhi">Delhi</option>
<option value="chennai">Chennai</option>
<option value="hyderabad">Hyderabad</option>
<option value="gujrat">Gujrat</option>
<option value="gurgaon">Gurgaon</option>
<option value="jharkand">Jharkand</option>
</select>

<label style="font-weight: bold;">Delivery Address</label> <textarea rows="5" style="margin-top:20px;" name="delivery_address"></textarea>
<br><br>
<input style="font-size:18px;background-color: green;align:center;" type="button" value="Rate Calculate" onclick="calculatePrice()">

<table border="1" align="center">
<tr>
<td style="background-color: gray;font-weight:bold;color:white;">Base Price</td>
<td style="background-color: yellow;font-weight:bold;color:blue;"><span style="padding-right: 18px;padding-left: 28px;" id="base"></span></td>
</tr>
<tr>
<td style="background-color: gray;font-weight:bold;color:white;">G.S.T</td>
<td style="background-color: yellow;font-weight:bold;color:blue;"><span style="padding-right: 18px;padding-left: 28px;" id="gst"></span></td>
</tr>
<tr>
<td style="background-color: gray;font-weight:bold;color:white;">Total Amount</td>
<td style="background-color: yellow;font-weight:bold;color:blue;"><span style="padding-right: 18px;padding-left: 28px;" id="total"></span></td>
</tr>
</table>
<br><br>
<input style="font-size:18px;background-color: yellow;align:center;margin-left: 600px;" type="submit" value="Submit">
</form>
<br><br>
<table border=1 align=center style="font-size:26px;background-color:Lightblue;color:red;">
<tr style="background-color:blue;color:yellow;"><th >Customer Id</th><th>Name</th><th>Mobile No</th><th>Email</th><th>City</th><th>Date Of Registration</th></tr>
<tr>
<td><span id="cust_id"></span></td>
<td><span id="cust_name"></span></td>
<td><span id="cust_mobile_no"></span></td>
<td><span id="cust_email"></span></td>
<td><span id="cust_city"></span></td>
<td><span id="cust_reg_date"></span></td>

</tr>

</table>

</body>
</html>
<cfparam name="URL.catID" default="5">

<!--- Cheeky request to get city names --->
<cfscript>
	// Get the list of cities
	cities = StructNew();
	cities.ReturnFormat = 'Struct';
	cities.cmd = 'GetCities';
	cityList = CreateObject("component","controller.index").init(cities);
	
	// Get the Entries
	data = StructNew();
	data.ReturnFormat = 'struct';
	data.cmd = 'GetEntries';
	data.cID = SESSION.cID;
	obj = CreateObject("component","controller.index").init(data);
</cfscript>

<!doctype html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" type="text/css" href="public/css/global.css" />
<title>Add New Offer - Kingfisher Media</title>
<script language="javascript" type="text/javascript" src="public/js/jQuery.min.js"></script>
<script language="javascript" type="text/javascript" src="public/js/Modernizr2-custom.js"></script>
</head>

<body>
<div id="holder" class="overflow">
	<div class="overflow">
		<div id="smallLogo" class="fl"></div>
		<div class="fr">
			<h1 class="fr">Add An Offer</h1>
			<cfform name="frmSelectCity" method="post">
				<select name="cID" class="darkPink capitalise" value="cID" onChange="this.form.submit();">
					<cfoutput query="cityList.data">
						<option value="#cityList.data.cID#" <cfif SESSION.cID EQ cityList.data.cID>selected</cfif>>#cityList.data.city_name#</option>
					</cfoutput>
				</select>
				<cfinput type="hidden" name="cmd" value="SelectedCity"/>
			</cfform>
		</div>
	</div>
	<div id="entryList" class="fl">
		<cfinclude template="public/cfm/inc-nav.cfm">
	</div>
	<div id="entryForm" class="fr">
		<cfoutput>
			<h2 class="fl">Offers</h2>
			<div class="bigPinkBtnText fr"><a href="view-offers.cfm?catID=#URL.catID#" class="darkPink capitalise noUnderline">View List</a></div>
			<cfform name="frmAddOffer" method="post" class="cb greyBox overflow" enctype="multipart/form-data">
				<p>
					<cfselect name="eID" class="textInput" query="obj.data" display="title" value="eID">
						<option selected disabled>Select Entry</option>
					</cfselect>
				</p>
				<p>
					<label>Offer Code</label><br/>
					<input type="text" name="offer_code" placeholder="Offer Code (EG '2For1-May')" required class="textInput darkPink " />
				</p>
				<p>
					<label>Valid From Date</label><br/>
					<cfinput type="datefield" name="date_start" placeholder="Offer Start Date" mask="dd/mm/yyyy" required="yes" message="Please select a date for the offer to start on" class="textInput darkPink" />
				</p>
				<p class="cb">
					<label>Valid Until Date</label><br/>
					<cfinput type="datefield" name="date_finish" placeholder="Offer End Date" mask="dd/mm/yyyy" required="yes" message="Please select a date for the offer to end on" class="textInput darkPink" />
				</p>
				<p class="cb">
					<label>Offer Terms/Details</label><br/>
					<textarea name="offer_desc" class="textInput textArea darkPink " required placeholder="Offer Description"></textarea>
				</p>
				<p>
					<input type="hidden" name="APIToken" value="raiseatree12" />
					<input type="hidden" name="cmd" value="AddOffer" />
					<input type="hidden" name="cID" value="#SESSION.cID#" />
					<input type="submit" name="btnSubmit" value="Add Offer" class="fl bigPinkBtn" />
				</p>
			</cfform>
		</cfoutput>
	</div>
</div>
</body>
</html>

// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("RegisterUser", function(request, response) {
 
    var Users = Parse.Object.extend("Users");
	var user = new Users();
	var query   = new Parse.Query( Users );
	var email   = request.params.email;
	var password = request.params.passwrod;
	query.equalTo( "email", email);
	
	var self = this;
	function checkExists()
	{
		query.find(
		{
			success: function( results ) 
			{   
				 if( results.length == 0)
				 {
					 saveUser();
				 }
				 else
				 {
					 response.error( "Registration error : user email "+email+ " already registered" );
				 }
				
			},
			error: function() 
			{
				response.error( "Registration error : problem saving data " );
			}
		});	
	}
	
	
	function saveUser()
	{

		user.set("email", email);
		user.set("password", password);
		user.save(null , 
		{
			success: function(user) 
			{	
			    response.success( "should see user " + user );
			},
  			error: function(user, error) 
			{
    			response.error( "Registration error : problem saving data " );
			}	
		});
				
	}
	
	
	checkExists();
	
	
});

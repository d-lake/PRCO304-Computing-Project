<div class="container">
	<% if CurrentMember %> 
		<div id="login-form">
		    <div class="login_panel panel panel-default">
		        <div class="panel-body">
			        $LoginForm
		        </div>
			</div>
		</div>
	<% else %>
		<div id="login-form">	
			<div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">
			  <div class="login_panel panel panel-default">
			    <div class="panel-heading" role="tab" id="headingOne">
			      <h4 class="panel-title">
			        <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
			          Login
			        </a>
			      </h4>
			    </div>
			    <div id="collapseOne" class="panel-collapse collapse in" role="tabpanel" aria-labelledby="headingOne">
			      <div class="panel-body">
				      $LoginForm
			      </div>
			    </div>
			  </div>
			  <div class="register_panel panel panel-default">
			    <div class="panel-heading" role="tab" id="headingTwo">
			      <h4 class="panel-title">
			        <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
			          Register
			        </a>
			      </h4>
			    </div>
			    <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
			      <div class="panel-body">
			      $RegisterForm
			      </div>
			    </div>
			  </div>
			</div>
		</div>
	<% end_if %>
</div>
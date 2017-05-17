<div id="Profile_Bio">
	<div id="Bio_Header">
		<h3>Bio</h3>
		<% if ifMyProfile %>
			<div id="bio_dropdown" class="dropdown">
                <button id="Profile_Settings"class="btn" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                  Settings &nbsp<i class="fa fa-cog"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1">
                  <li><a id="Edit_Bio" href="#" data-toggle="modal" data-target="#Edit_Bio_Modal">Edit Bio &nbsp <i class="fa fa-pencil"></i></a></li>
                  <li><a id="Change_Password" href="#" data-toggle="modal" data-target="#Change_Password_Modal">Change Password &nbsp<i class="fa fa-key"></i></a></li>
                  
                </ul>
              </div>
		<% end_if %>

		<div class="clearfix"></div>

		<% with Member %>
			<% if $FirstName %>
				$FirstName
			<% end_if %>

			<% if $Surname %>
				$Surname
			<% end_if %>

			<% if $Bio %>
				$Bio
			<% else %>
				<div id="No-Bio" >
		            <h3>
		              <i class="fa fa-users" aria-hidden="true"></i>
		              <% if $Up.ifMyProfile %>
		              	<p>Edit your bio in the settings to let others know more about you</p>
		              <% else %>
		              	<p>This user has not updated their bio yet</p>
		              <% end_if %>
		            </h3>
		        </div>
			<% end_if %>
		<% end_with %>
	</div>

	<div class="upload modal fade" id="Change_Password_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">Change Password</h4>
	      </div>
	      <div class="modal-body">
	          $ChangePassword
	      </div>
	      <div class="modal-footer">
	        <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
	      </div>
	    </div>
	  </div>
	</div>

	<div class="upload modal fade" id="Edit_Bio_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">Edit Bio</h4>
	      </div>
	      <div class="modal-body">
	          $EditBioForm
	      </div>
	      <div class="modal-footer">
	        <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
	      </div>
	    </div>
	  </div>
	</div>
</div>
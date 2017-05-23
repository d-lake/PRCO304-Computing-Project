<div id="Profile_Bio">
	<div id="Bio_Header">
		<h3>Shop Bio</h3>
		<% if ifMyShop %>
			<div id="bio_dropdown" class="dropdown">
                <button id="Profile_Settings"class="btn" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
                  Options &nbsp<i class="fa fa-cog"></i>
                </button>
                <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1">
                  <li><a id="Edit_Bio" href="#" data-toggle="modal" data-target="#Edit_Shop_Bio_Modal">Edit Shop Bio &nbsp <i class="fa fa-pencil"></i></a></li>
                  <li><a id="Delete_Shop" href="/members/view/$CurrentMember.ID">Delete Shop &nbsp<i class="fa fa-trash"></i></a></li>
                  
                </ul>
              </div>
		<% end_if %>

		<div class="clearfix"></div>

		<% with Shop %>
			<% if $Title %>
				<div id="Shop_Name" class="field">
                      <label class="left"><h4>Name</h4></label>
                      <p>$Title</p>
                    </div>
			<% end_if %>

			<% if $ShopURL %>
			<div id="Shop_URL" class="field">
                      <label class="left"><h4>Website</h4></label>
                      <p>$ShopURL</p>
                    </div>
				
			<% end_if %>

			<% if $ShopEmail %>
			<div id="Shop_Email" class="field">
                      <label class="left"><h4>Email</h4></label>
                      <p>$ShopEmail</p>
                    </div>
				
			<% end_if %>

			<% if $Bio %>
			<div id="Shop_Bio" class="field">
                      <label class="left"><h4>Bio</h4></label>
                      <p>$Bio</p>
                    </div>
			<% else %>
				<div id="No-Bio" >
		            <h3>
		              <i class="fa fa-users" aria-hidden="true"></i>
		              <% if $Up.ifMyShop %>
		              	<p>Edit your bio in the settings to let others know more about you</p>
		              <% else %>
		              	<p>This user has not updated their bio yet</p>
		              <% end_if %>
		            </h3>
		        </div>
			<% end_if %>
		<% end_with %>
	</div>
</div>

<div class="upload modal fade" id="Delete_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <a id="Close-Modal" class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title" id="myModalLabel">Delete</h4>
            </div>
            <div class="modal-body text-center">
              <h4></h4>
              <div class="Actions">
                <button id="Btn-Delete" class="btn btn-gold">Yes</button>
              </div>
            </div>
            <div class="modal-footer">
              <button id="Btn-No-Delete" type="button" data-dismiss="modal" data-for="editGallery" data-remove-files>No</button>
            </div>
          </div>
        </div>
      </div>

	<div class="upload modal fade" id="Edit_Shop_Bio_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">Edit Bio</h4>
	      </div>
	      <div class="modal-body">
	          $EditShopBioForm
	      </div>
	      <div class="modal-footer">
	        <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
	      </div>
	    </div>
	  </div>
	</div>
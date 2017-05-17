
<% include Shop_Header %>
<div id="Shop" class="container">
		<div id="Profile_nav">
			<div class="container-fluid margin-nav">
				<span id="Profile_name"><% with Shop %>$Title<% end_with %></span>
				</button>
				<ul id="tabs_profile" class="nav nav-tabs" role="tablist">
				    <li role="presentation" class="active"><a href="#bio" aria-controls="bio" role="tab" data-toggle="tab">Bio</a></li>
				    <li role="presentation"><a href="#items" aria-controls="items" role="tab" data-toggle="tab">Items</a></li>
				    <li role="presentation"><a href="#galleries" aria-controls="galleries" role="tab" data-toggle="tab">Galleries</a></li>
				  </ul>
				<% if ifMyShop == 0 %>
					<div id="Connect_user">
						$ConnectUserForm
					</div>
				<% end_if %>
			</div>
		</div>
		<div id="Profile_main">
			<div id="main_content" class="col-lg-12">
				<div class="container-fluid">
				  	<div class="tab-content">
					    <div role="tabpanel" class="tab-pane active" id="bio">
						    <% include Shop_Bio %>
						</div>
						<div role="tabpanel" class="tab-pane" id="items">
							<div id="Profile_Galleries">
								<div id="Gallery_Header">
									<h3>Items</h3>
									<% if ifMyShop %>
										<div id="gallery_dropdown" class="dropdown">
									        <button id="Profile_Settings"class="btn" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
									          Options &nbsp<i class="fa fa-cog"></i>
									        </button>
									        <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1">
									          <li><a id="New_Item" href="#" data-toggle="modal" data-target="#New_Item_Modal">Add New Item &nbsp <i class="fa fa-plus"></i></a></li>
									          <li><a id="Add_Categories" href="#" data-toggle="modal" data-target="#Add_Categories_Modal">Add Category &nbsp<i class="fa fa-plus"></i></a></li>
									        </ul>
									      </div>
									<% end_if %>
									<div id="Item-Search" class="col-xs-12 no-padding">
							        	<form class="search-item-form">
							        		<input id="Searchbar" type="text" class="form-control" placeholder="Search" value="$SessionSearch">
					   						<span class="search-icon glyphicon glyphicon-search form-control-feedback" aria-hidden="true"></span>

					   						<div id="Btn-Category" class="col-sm-6 no-padding">
					   							<label class="left">Category</label>
								        		<button type="button" class="btn" data-toggle="dropdown">
								                	All &nbsp<i class="fa fa-caret-down" aria-hidden="true"></i>
								                </button>
								                <ul class="dropdown-menu" role="menu">
								                  <li><a href="#all">All</a></li>
								                  <li class="divider"></li>
								                  <li><a>Category</a></li>
								                  <li><a>Category</a></li>
								                  <li><a>Category</a></li>
								                  <li><a>Category</a></li>
								                </ul>
								        	</div>
								        	<div id="Btn-Sort" class="col-sm-6 no-padding">
								        		<label class="left">Sort</label>
								        		<button type="button" class="btn" data-toggle="dropdown">
								                	Relevance &nbsp<i class="fa fa-caret-down" aria-hidden="true"></i>
								                </button>
								                <ul class="dropdown-menu" role="menu">
								                  <li><a>Relevance</a></li>
								                  <li class="divider"></li>
								                  <li><a>Newly Added</a></li>
								                  <li><a>Price: Lowest to Highest</a></li>
								                  <li><a>Price: Highest to Lowest</a></li>
								                </ul>
								        	</div>
							        	</form>
						        	</div>
									<div class="clearfix"></div>
									<div class="or-box"><h2><span>SHOP</span></h2></div>
									<% if $Items %>
										<div class="grid-container">
											<div class="grid">
					    						<% include Shop_Items %>
					    					</div>
					    				</div>
									<% else %>
										<div id="No-Gallery">
								            <h3>
								              <i class="fa fa-shopping-cart" aria-hidden="true"></i>
								              <% if $ifMyShop %>
								              	<p>Add a new item to sell</p>
								              <% else %>
								              	<p>This shop has not added any items yet</p>
								              <% end_if %>
								            </h3>
								        </div>
								    <% end_if %>
								</div>
						    </div>
						</div>
					    <div role="tabpanel" class="tab-pane" id="galleries">
					    	<% include Shop_Galleries %>
					    </div>
				  	</div>
				</div>
			</div>
		</div>
		$Form
		$CommentsForm
</div>

<% if ifMyShop %>
	<div class="upload modal fade" id="New_Item_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">Add a new Item</h4>
	      </div>
	      <div class="modal-body">
	        <div id="ProfileUpload" class="drop_zone">
	          <div class="dz-default dz-message">
	            <span>
	              <i class="fa fa-upload" aria-hidden="true"></i>
	              <p>Click here or drag and drop to upload a photo.</p>
	            </span>
	          </div>
	          $AddItemForm
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
	      </div>
	    </div>
	  </div>
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

	<div class="upload modal fade" id="New_Gallery_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">Create a New Gallery</h4>
	      </div>
	      <div class="modal-body">
	        <div id="ProfileChoose" class="pick_zone">
	          <div class="dz-default dz-message">
	            <span>
	              <i class="fa fa-picture-o" aria-hidden="true"></i>
	              <p>Click here select a photo.</p>
	            </span>
	          </div>
	        </div>
	        <div class="or-box"><h2><span>OR</span></h2></div>
	        <div id="ProfileUpload" class="drop_zone">
	          <div class="dz-default dz-message">
	            <span>
	              <i class="fa fa-upload" aria-hidden="true"></i>
	              <p>Click here or drag and drop to upload a photo.</p>
	            </span>
	          </div>
	          $NewGalleryForm
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
	      </div>
	    </div>
	  </div>
	</div>
<% end_if %>
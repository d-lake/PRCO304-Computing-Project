
<% include Shop_Header %>
<div id="Shop" class="container" data-shopID="<% with Shop %>$ID<% end_with %>">
		<div id="Profile_nav">
			<div class="container-fluid margin-nav">
				<span id="Profile_name"><% with Shop %>$Title<% end_with %></span>
				</button>
				<ul id="tabs_profile" class="nav nav-tabs" role="tablist">
				    <li role="presentation" class="active"><a href="#bio" aria-controls="bio" role="tab" data-toggle="tab">Bio</a></li>
				    <li role="presentation"><a href="#items" aria-controls="items" role="tab" data-toggle="tab">Items</a></li>
				    <li role="presentation"><a href="#galleries" aria-controls="galleries" role="tab" data-toggle="tab">Galleries</a></li>
				  </ul>
				<%-- <% if ifMyShop == 0 %>
					<div id="Connect_user">
						$ConnectUserForm
					</div>
				<% end_if %> --%>
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
							<div id="Shop_Items">
								<div id="Gallery_Header">
									<h3>Items</h3>
									<% if ifMyShop %>
										<div id="gallery_dropdown" class="dropdown">
									        <button id="Profile_Settings"class="btn" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
									          Options &nbsp<i class="fa fa-cog"></i>
									        </button>
									        <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1">
									          <li><a id="New_Item" href="#" data-toggle="modal" data-target="#New_Item_Modal">Add New Item &nbsp <i class="fa fa-plus"></i></a></li>
									          <%-- <li><a id="Add_Categories" href="#" data-toggle="modal" data-target="#Add_Categories_Modal">Add Category &nbsp<i class="fa fa-plus"></i></a></li> --%>
									        </ul>
									      </div>
									<% end_if %>
									<div id="Item-Search" class="col-xs-12 no-padding">
							        	<div class="search-item-form">
							        		<input id="Item-Searchbar" type="text" class="form-control" placeholder="Search" value="">
					   						<span class="search-icon glyphicon glyphicon-search form-control-feedback" aria-hidden="true"></span>

					   						<%-- <div id="Btn-Category" class="col-sm-6 no-padding">
					   							<label class="left">Category</label>
								        		<button type="button" class="btn" data-toggle="dropdown">
								                	All &nbsp<i class="fa fa-caret-down" aria-hidden="true"></i>
								                </button>
								                <ul class="dropdown-menu" role="menu">
								                  <li><a href="#all">All</a></li>
								                  <% if Shop.Category %>
								                  	<% loop Shop.Category %>
								                  		<% if First %>
										                  	<li class="divider"></li>
										                  	<li><a>$Category</a></li>
										                <% else %>
									                  		<li><a>$Category</a></li>
									                  	<% end_if %>
								                  	<% end_loop %>
								                  <% end_if %>
								                </ul>
								        	</div> --%>
								        	<div id="Btn-Sort" class="col-xs-12 no-padding">
								        		<label class="left">Sort</label>
								        		<button type="button" class="btn" data-toggle="dropdown" data-sort="Relevance">
								                	Relevance &nbsp<i class="fa fa-caret-down" aria-hidden="true"></i>
								                </button>
								                <ul class="dropdown-menu" role="menu">
								                  <li><a>Relevance</a></li>
								                  <li class="divider"></li>
								                  <li><a>Price: Lowest to Highest</a></li>
								                  <li><a>Price: Highest to Lowest</a></li>
								                </ul>
								        	</div>
							        	</div>
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
					    	<div id="Shop_Galleries">
								<div id="Gallery_Header">
									<h3>Galleries</h3>
									<% if ifMyShop %>
										<button id="New_Gallery" href="#" class="btn" data-toggle="modal" data-target="#New_Gallery_Modal" >New Gallery &nbsp
										<i class="fa fa-plus"></i>
										</button>
									<% end_if %>

									<div class="clearfix"></div>

									<% if $Galleries %>
										<div class="grid-container">
											<div class="grid <% if $Galleries.MoreThanOnePage %>pagination-margin<% end_if %>">
					    						<% include Shop_Galleries %>
					    					</div>
					    				</div>
									<% else %>
										<div id="No-Gallery">
								            <h3>
								              <i class="fa fa-picture-o" aria-hidden="true"></i>
								              <% if $ifMyShop %>
								              	<p>Create a gallery to save and upload images into</p>
								              <% else %>
								              	<p>This shop has not created any galleries yet</p>
								              <% end_if %>
								            </h3>
								        </div>
								    <% end_if %>
								</div>
							</div>	
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
<div class="upload modal fade" id="Delete_Item_Modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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

<% if recentUploads %>
	<div class="upload modal fade" id="Shop_Edit_Uploads_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
			<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
		  <div class="modal-dialog" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h4 class="modal-title" id="myModalLabel">Edit Recent Uploads</h4>
		        <i class="fa fa-question-circle" aria-hidden="true"></i>
		      </div>
		      <div class="modal-body">
		        <% loop $recentUploads %>
			        <div class="upload-container" data-imageID="$Image.ID">
			        	<div class="col-sm-5 no-padding image-column">
				        	<div class="upload-image">
				        		<img class="img-responsive" src="$Image.Fill(222,222).Link" alt="">
				        		<div class="image-icon-holder">
				                <div class="removeImage image-icon">
			        			<a>
			                        <i class="fa fa-times"></i>
			                    </a>
			                </div>
		        		</div>
			        	</div>

			        	</div>
			        	<div class="col-sm-7 no-padding">
				        	<form class="edit-image-form">
				        		<div class="field">
						        	<label class="left">Privacy</label>
						        	<div class="radio-box">
						        		<label class="radio-inline"><input type="radio" checked="checked" name="optradio" value="Public">Public</label>
										<label class="radio-inline"><input type="radio" name="optradio"value="Private">Private</label>
									</div>
								</div>
				        		<div class="field">
					        		<label class="left">Title</label>
						        	<input type="text" name="title" class="text form-upload-title" maxlength="255" size="30" value="$Image.Title">
				        		</div>
				        		<div class="field">
					        		<label class="left">Tags</label>
						        	<textarea type="text" name="tags" class="text form-upload-tags" maxlength="255" placeholder="Seperate tags with a comma" rows="3"></textarea>
					        	</div>
				        	</form>
			        	</div>
			        </div>
			        <div class="clearfix"></div>
			        <% if not Last %>
	        			<div class="or-box"><h2><span>NEXT</span></h2></div>
			        <% end_if %>
				<% end_loop %>
				<div class="Actions">
					<button id="Btn-Save-Uploads" class="btn btn-gold">Save Images</button>
				</div>
		      </div>
		      <div class="modal-footer">
		        <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
		      </div>
		    </div>
		  </div>
		</div>
<% end_if %>
<% end_if %>



<% include Profile_Header %>
<div id="Profile" class="container" data-userID="<% with Member %>$ID<% end_with %>">
		<div id="Profile_nav">
			<div class="container-fluid margin-nav">
				<span id="Profile_name"><% with Member %>$UserName<% end_with %></span>
				<ul id="tabs_profile" class="nav nav-tabs" role="tablist">
				    <li role="presentation" class="active"><a href="#bio" aria-controls="bio" role="tab" data-toggle="tab">Bio</a></li>
				    <li role="presentation"><a href="#galleries" aria-controls="galleries" role="tab" data-toggle="tab">Galleries</a></li>
				    <li role="presentation"><a href="#shops" aria-controls="shops" role="tab" data-toggle="tab">Shops</a></li>
				    <li role="presentation"><a href="#connections" aria-controls="connections" role="tab" data-toggle="tab">Connections</a></li>
				  </ul>
				<% if ifMyProfile == 0 %>
					<div id="Connect_user">
						<% if $Connected %>
						<button id="Btn-Unfollow" class="btn btn-gold">Unfollow</button>
						<% else %>
						<button id="Btn-Follow" class="btn btn-gold">Follow</button>
						<% end_if %>
					</div>
				<% end_if %>
			</div>
		</div>
		<div id="Profile_main">
			<div id="main_content" class="col-lg-12">
				<div class="container-fluid">
				  <div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="bio">
					    <% include Profile_Bio %>
					</div>
				    <div role="tabpanel" class="tab-pane" id="galleries">
				    	<div id="Profile_Galleries">
							<div id="Gallery_Header">
								<h3>Galleries</h3>
								<% if ifMyProfile %>
									<button id="New_Gallery" href="#" class="btn" data-toggle="modal" data-target="#New_Gallery_Modal" >New Gallery &nbsp
									<i class="fa fa-plus"></i>
									</button>
								<% end_if %>

								<div class="clearfix"></div>

								<% if $Galleries %>
									<div class="grid-container">
										<div class="grid <% if $Galleries.MoreThanOnePage %>pagination-margin<% end_if %>">
				    						<% include Profile_Galleries %>
				    					</div>
				    				</div>
								<% else %>
									<div id="No-Gallery">
							            <h3>
							              <i class="fa fa-picture-o" aria-hidden="true"></i>
							              <% if $ifMyProfile %>
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
				    <div role="tabpanel" class="tab-pane" id="shops">
				    	<div id="Profile_Shops">
							<div id="Shop_Header">
								<h3>Shops</h3>
								<% if ifMyProfile %>
									<button id="New_Shop" href="#" class="btn" data-toggle="modal" data-target="#New_Shop_Modal" >New Shop &nbsp
									<i class="fa fa-plus"></i>
									</button>
								<% end_if %>

								<div class="clearfix"></div>

								<% if $Shops %>
									<div class="grid-container">
										<div class="grid">
				    						<% include Profile_Shops %>
				    					</div>
				    				</div>
								<% else %>
									<div id="No-Shop">
							            <h3>
							              <i class="fa fa-shopping-bag" aria-hidden="true"></i>
							              <% if $ifMyProfile %>
							              	<p>Open up a shop to dipsplay your buyable products</p>
							              <% else %>
							              	<p>This user has not opened up shop yet</p>
							              <% end_if %>
							            </h3>
							        </div>
							    <% end_if %>
							</div>
						</div>	
				    </div>
				    <div role="tabpanel" class="tab-pane" id="connections">
					    <div id="Profile_Connections">
							<div id="Connections_Header">
								<h3>Connections</h3>

								<div class="clearfix"></div>

				    			<% if $Connections %>
									<div class="grid-container">
										<div class="grid">
				    						<% include Profile_Connections %>
				    					</div>
				    				</div>
								<% else %>
									<div id="No-Connection">
							            <h3>
							              <i class="fa fa-globe" aria-hidden="true"></i>
							              <% if $ifMyProfile %>
							              	<p>Widen your network by connecting with others</p>
							              <% else %>
							              	<p>This user doesn't have any connections yet</p>
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

<% if recentUploads %>
	<div class="upload modal fade" id="Profile_Edit_Uploads_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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

<% if $ifMyProfile %>
	<div class="upload modal fade" id="New_Gallery_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">Create a New Gallery</h4>
	      </div>
	      <div class="modal-body">
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

	<div class="upload modal fade" id="New_Shop_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
		<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h4 class="modal-title" id="myModalLabel">Create a New Shop</h4>
	      </div>
	      <div class="modal-body">
	          $NewShopForm
	      </div>
	      <div class="modal-footer">
	        <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
	      </div>
	    </div>
	  </div>
	</div>
<% end_if %>
<% loop $Images %>
	<% if Image.Privacy == 0 %>
		<% if Image.OwnerID == CurrentMember.ID %>
		    <div class="grid-item" data-imageID="$Image.ID">
				<div class="img-container">
				    <div class="hovereffect">
				        <a href="$Image.URL" data-lightbox="gallery">
				        	<img class="img-responsive" src="$Image.ScaleWidth(248).Link" alt="">
				        </a>
			        	<div class="image-icon-holder">
			        		<% if $Up.ifMyGallery %>
								<div class="editImage image-icon"  data-toggle="modal" data-target="#Edit_Image_Modal">
				        			<a>
			                            <i class="fa fa-pencil"></i>
			                        </a>
				        		</div>
								<div class="removeImage image-icon">
				        			<a>
				                        <i class="fa fa-times"></i>
				                    </a>
				        		</div>
				        	<% end_if %>
			                <div class="addImage image-icon dropdown">
							  <a type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							    <i class="fa fa-anchor"></i>
							  </a>
							  <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1">
							  	<li><input type="text" placeholder="Add to New Gallery"></input></li>
								<li role="separator" class="divider" style="<% if $AllGalleries %><% else %>display: none<% end_if %>"></li>
							  	<% if $AllGalleries %>
							    	<% loop $AllGalleries %>
									    <li><a data-galleryID="$Gallery.ID" class="<% if $Related == true %>related-gallery<% else %>unrelated-gallery<% end_if %>">$Gallery.Title<% if $Related == true %> &nbsp<i class="fa fa-check"></i><% end_if %></a></li>
									<% end_loop %>
								<% end_if %>
							  </ul>
							</div>
							<% if Up.Gallery.ifFavouritesGallery == 1 && Up.Gallery.ifCurrentMembersGallery %>
							<% else %>
				        		<div class="saveImage image-icon">
				        			<a>
				        				<% if $isFavourited %>
				                        	<i class="fa fa-heart"></i>
				        				<% else %>
				                        	<i class="fa fa-heart-o"></i>
				        				<% end_if %>
				                    </a>
				        		</div>
							<% end_if %>
			        	</div>
			        </div>
				</div>
		    	<div class="img-owner-container">
		    		<a href="$UserURL">
		    			<img class="img-owner" src="<% if $ProfilePictureImage %>$ProfilePictureImage.Fill(40,40).Link<% else %>$themeDir/images/profile-placeholder.jpg<% end_if %>" data-toggle="tooltip" data-placement="bottom" title="$userName">
		    		</a>
		    	</div>
		    	<div class="img-info">
		    		<div class="img-title">
		    			$Image.Title
		    		</div>
		    	</div>
		    </div>
    	<% end_if %>
    <% else %>
    <div class="grid-item" data-imageID="$Image.ID">
				<div class="img-container">
				    <div class="hovereffect">
				        <a href="$Image.URL" data-lightbox="gallery">
				        	<img class="img-responsive" src="$Image.ScaleWidth(248).Link" alt="">
				        </a>
			        	<div class="image-icon-holder">
			        		<% if $Up.ifMyGallery %>
								<div class="editImage image-icon"  data-toggle="modal" data-target="#Edit_Image_Modal">
				        			<a>
			                            <i class="fa fa-pencil"></i>
			                        </a>
				        		</div>
								<div class="removeImage image-icon">
				        			<a>
				                        <i class="fa fa-times"></i>
				                    </a>
				        		</div>
				        	<% end_if %>
			                <div class="addImage image-icon dropdown">
							  <a type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
							    <i class="fa fa-anchor"></i>
							  </a>
							  <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1">
							  	<li><input type="text" placeholder="Add to New Gallery"></input></li>
								<li role="separator" class="divider" style="<% if $AllGalleries %><% else %>display: none<% end_if %>"></li>
							  	<% if $AllGalleries %>
							    	<% loop $AllGalleries %>
									    <li><a data-galleryID="$Gallery.ID" class="<% if $Related == true %>related-gallery<% else %>unrelated-gallery<% end_if %>">$Gallery.Title<% if $Related == true %> &nbsp<i class="fa fa-check"></i><% end_if %></a></li>
									<% end_loop %>
								<% end_if %>
							  </ul>
							</div>
							<% if Up.Gallery.ifFavouritesGallery == 1 && Up.Gallery.ifCurrentMembersGallery %>
							<% else %>
				        		<div class="saveImage image-icon">
				        			<a>
				        				<% if $isFavourited %>
				                        	<i class="fa fa-heart"></i>
				        				<% else %>
				                        	<i class="fa fa-heart-o"></i>
				        				<% end_if %>
				                    </a>
				        		</div>
							<% end_if %>
			        	</div>
			        </div>
				</div>
		    	<div class="img-owner-container">
		    		<a href="$UserURL">
		    			<img class="img-owner" src="<% if $ProfilePictureImage %>$ProfilePictureImage.Fill(40,40).Link<% else %>$themeDir/images/profile-placeholder.jpg<% end_if %>" data-toggle="tooltip" data-placement="bottom" title="$userName">
		    		</a>
		    	</div>
		    	<div class="img-info">
		    		<div class="img-title">
		    			$Image.Title
		    		</div>
		    	</div>
		    </div>
    <% end_if %>
<% end_loop %>
<% if $Images.MoreThanOnePage %>
	<% if $Images.NotLastPage %>
	    <div class="pagination">
	        <a href="$Images.NextLink"></a>
		</div>
	<% else %>
		<div class="pagination">
	        <a class="last-page"></a>
		</div>
	<% end_if %>
<% end_if %>
<% loop Items %>
	<div class="grid-item" data-itemID="$ID">
		<div class="img-container">
		    <div class="hovereffect">
		         <a href="" data-toggle="modal" data-target="#View_Item_Modal">
		        	<img class="img-responsive" src="<% if $firstImage %>$firstImage.Fill(248,248).Link<% else %>$themeDir/images/shop-placeholder.jpg<% end_if %>" alt="">
		        </a>
	        	<div class="image-icon-holder">
	        		<% if Up.ifMyShop %>
						<div class="editIcon image-icon"  data-toggle="modal" data-target="#Edit_Item_Modal">
		        			<a>
	                            <i class="fa fa-pencil"></i>
	                        </a>
		        		</div>
		        		<div class="removeItem image-icon">
		        			<a>
	                            <i class="fa fa-times"></i>
	                        </a>
		        		</div>
		        	<% end_if %>
	        	</div>
	        </div>
		</div>
    	<div class="img-info">
    		<div class="img-title">
    			$Title
    		</div>
    		<div class="img-title">
    			£$Price
    		</div>
    	</div>
	</div>
<% end_loop %>
<% if $Items.MoreThanOnePage %>
	<% if $Items.NotLastPage %>
	    <div class="pagination">
	        <a href="$Items.NextLink"></a>
		</div>
	<% else %>
		<div class="pagination">
	        <a class="last-page"></a>
		</div>
	<% end_if %>
<% end_if %>
<div class="upload modal fade" id="View_Item_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title" id="myModalLabel">View Item</h4>
          </div>
          <div class="modal-body">
              <div class="upload-container">
                <div class="col-xs-12 no-padding">
                    <div id="Item_Title" class="field">
                      <label class="left"><h4>Title</h4></label>
                      <p></p>
                    </div>
					<div class="or-box"><h2><span><% with Shop %>$Title<% end_with %></span></h2></div>
                    <div id="Item_Description" class="field">
                      <label class="left"><h4>Description</h4></label>
                      <p></p>
                    </div>
					<div class="or-box"><h2><span><% with Shop %>$Title<% end_with %></span></h2></div>
                    <div id="Item_Price" class="field">
                      <label class="left"><h4>Price</h4></label>
                      <p></p>
                    </div>
					<div class="or-box"><h2><span><% with Shop %>$Title<% end_with %></span></h2></div>
					<div id="Item_Images" class="field">
                      <label class="left"><h4>Images</h4></label>
                    </div>
                  <div id="Item_Carousel" class="carousel slide" data-ride="carousel" data-interval="false">

					  <!-- Wrapper for slides -->
					  <div class="carousel-inner">
					  </div>

					  <!-- Left and right controls -->
					  <a class="left carousel-control" href="#Item_Carousel" data-slide="prev">
					    <span class="glyphicon glyphicon-chevron-left"></span>
					    <span class="sr-only">Previous</span>
					  </a>
					  <a class="right carousel-control" href="#Item_Carousel" data-slide="next">
					    <span class="glyphicon glyphicon-chevron-right"></span>
					    <span class="sr-only">Next</span>
					  </a>
					</div>
                </div>
              </div>
              <div class="clearfix"></div>
              <div class="Actions">
              </div>
          </div>
          <div class="modal-footer">
            <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
          </div>
        </div>
      </div>
    </div>

    <div class="upload modal fade" id="Edit_Item_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title" id="myModalLabel">View Item</h4>
          </div>
          <div class="modal-body">
          <% with Shop %>
              <div class="upload-container">
                <div class="col-xs-12 no-padding">
                    <div id="Item_Title" class="field">
	                      <label class="left">Title</label>
	                      <input type="text" name="title" class="text form-upload-title" maxlength="255" size="30" value="">
                    </div>
                    <div id="Item_Description" class="field">
	                      <label class="left">Description</label>
	                      <input type="text" name="description" class="text form-upload-title" maxlength="255" size="30" value="">
                    </div>
                    <div id="Item_Price" class="field">
	                      <label class="left">Price</label>
	                      <input type="text" name="price" class="text form-upload-title" maxlength="255" size="30" value="">
                    </div>
                </div>
              </div>
              <div class="clearfix"></div>
				<div class="Actions">
					<button id="Btn-Save-Uploads" class="btn btn-gold">Save Item</button>
				</div>
			<% end_with %>
          </div>
          <div class="modal-footer">
            <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
          </div>
        </div>
      </div>
    </div>


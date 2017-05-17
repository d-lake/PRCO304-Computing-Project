<% with $Gallery %>
	<div id="Gallery_header" class="container-fluid">
		<h3>$Title</h3>
		<% if $Up.ifMyGallery %>
      <div id="gallery_dropdown" class="dropdown">
        <button id="Profile_Settings"class="btn" type="button" id="dropdownMenu1" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true">
          Options &nbsp<i class="fa fa-cog"></i>
        </button>
        <ul class="dropdown-menu dropdown-menu-right" aria-labelledby="dropdownMenu1">
          <li><a id="Edit_Bio" href="#" data-toggle="modal" data-target="#Edit_Gallery_Modal">Edit Gallery &nbsp <i class="fa fa-pencil"></i></a></li>
          <li><a id="Add_To_Gallery" href="#" data-toggle="modal" data-target="#Add_To_Gallery_Modal">Add to Gallery &nbsp<i class="fa fa-plus"></i></a></li>
          <li><a id="Delete_Gallery" href="/members/view/$Up.CurrentMember.ID">Delete Gallery &nbsp<i class="fa fa-trash"></i></a></li>
        </ul>
      </div>
		<% end_if %>
	</div>
<% end_with %> 

<div id="Gallery" class="container-fluid" data-galleryID="<% with $Gallery %>$ID<% end_with %>">
	<div class="grid-container">
		<div class="grid">
			<% include GalleryImages %>
		</div>
	</div>
</div>

<% if recentUploads %>
  <div class="upload modal fade" id="Gallery_Edit_Uploads_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
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
                        <label class="radio-inline"><input type="radio" checked="checked"name="optradio" value="Public">Public</label>
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

<div class="upload modal fade" id="Add_To_Gallery_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h4 class="modal-title" id="myModalLabel">Add to Gallery</h4>
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
          $AddToGalleryForm
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
      </div>
    </div>
  </div>
</div>

  <div class="upload modal fade" id="Edit_Image_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
      <a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title" id="myModalLabel">Edit Image</h4>
            <i class="fa fa-question-circle" aria-hidden="true"></i>
          </div>
          <div class="modal-body">
              <div class="upload-container">
                <div class="col-sm-5 no-padding image-column">
                  <div class="upload-image">
                    <img class="img-responsive" src="" alt="">
                    <div class="loadingImg">
                      <i class="fa fa-spinner fa-pulse"></i>
                    </div>
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
                    <div id="Edit_Privacy" class="field">
                      <label class="left">Privacy</label>
                      <div class="radio-box">
                        <label class="radio-inline"><input id="Public" type="radio" name="optradio" value="Public">Public</label>
                        <label class="radio-inline"><input id="Private" type="radio" name="optradio"value="Private">Private</label>
                      </div>
                    </div>
                    <div id="Edit_Title" class="field">
                      <label class="left">Title</label>
                      <input type="text" name="title" class="text form-upload-title" maxlength="255" size="30">
                    </div>
                    <div id="Edit_Tags" class="field">
                      <label class="left">Tags</label>
                      <textarea type="text" name="tags" class="text form-upload-tags" maxlength="255" placeholder="Seperate tags with a comma" rows="3"></textarea>
                    </div>
                  </form>
                </div>
              </div>
              <div class="clearfix"></div>
              <div class="Actions">
                <button id="Btn-Save-Uploads" class="btn btn-gold">Save Image</button>
              </div>
          </div>
          <div class="modal-footer">
            <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
          </div>
        </div>
      </div>
    </div>

    <div class="upload modal fade" id="Edit_Gallery_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
        <div class="modal-dialog" role="document">
          <div class="modal-content">
            <div class="modal-header">
              <h4 class="modal-title" id="myModalLabel">Edit Gallery</h4>
            </div>
            <div class="modal-body">
                $EditGalleryForm
            </div>
            <div class="modal-footer">
              <button type="button" data-dismiss="modal" data-for="editGallery" data-remove-files>Close</button>
            </div>
          </div>
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

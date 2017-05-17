<% with $Member %>
  <div id="Profile_header">
  	<div id="Profile_header_container">
        <% if MemberCoverPicture %>
          <% with MemberCoverPicture %>
          <%-- <img id="Profile_header_img" src="$URL" alt="$AltText" /> --%>
          <div id="Edit_Profile_Header" class="img-container">
            <div class="hovereffect">
                <a href="$Image.URL" data-lightbox="gallery">
                  <img id="Profile_header_img" class="img-responsive" src="$Image.URL" alt="">
                </a>
                <% if $Top.ifMyProfile %>
                  <div class="image-icon-holder">
                      <div class="image-icon">
                        <a href="#" data-toggle="modal" data-target="#Cover_Modal">
                            <i class="fa fa-pencil"></i>
                        </a>
                      </div>
                  </div>
                <% end_if %>
            </div>
        </div>
        <% end_with %>
      <% else %>
        <a href="#" data-toggle="modal" data-target="#Cover_Modal">
          <div id="Upload_Cover" class="text-center">
            <i class="fa fa-picture-o" aria-hidden="true"></i>
          </div>
        </a>
      <% end_if %>
  	</div>
  	<div class="container rel_container">
      <% if $MemberProfilePicture %>
        <% with $MemberProfilePicture %>
        <div id="Edit_Profile" class="img-container">
            <div class="hovereffect">
                <a href="$Image.URL" data-lightbox="gallery">
                  <img id="Profile_header_img" class="img-responsive" src="$Image.Fill(192,192).Link" alt="">
                </a>
                <% if $Top.ifMyProfile %>
                  <div class="image-icon-holder">
                      <div class="image-icon">
                        <a href="#" data-toggle="modal" data-target="#Profile_Modal">
                            <i class="fa fa-pencil"></i>
                        </a>
                      </div>
                  </div>
                <% end_if %>
            </div>
        </div>
        <% end_with %>
      <% else %>
    		<a href="#" data-toggle="modal" data-target="#Profile_Modal">
    			<div id="Upload_Profile" class="text-center">
    				<i class="fa fa-user" aria-hidden="true"></i>
    			</div>
    		</a>
      <% end_if %>
  	</div>
  </div>
<% end_with %>

<% if ifMyProfile %>
  <div class="upload modal fade" id="Cover_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  	<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="myModalLabel">Upload Cover Photo</h4>
        </div>
        <div class="modal-body">
          <div id="CoverChoose" class="pick_zone">
            <div class="dz-default dz-message">
              <span>
                <i class="fa fa-picture-o" aria-hidden="true"></i>
                <p>Click here select a photo.</p>
              </span>
            </div>
          </div>
          <div class="or-box"><h2><span>OR</span></h2></div>
          <div id="CoverUpload" class="drop_zone">
            <div class="dz-default dz-message">
              <span>
                <i class="fa fa-upload" aria-hidden="true"></i>
                <p>Click here or drag and drop to upload a photo.</p>
              </span>
            </div>
            $NewMemberCoverPictureForm
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" data-dismiss="modal" data-for="CoverUpload" data-remove-files>Close</button>
        </div>
      </div>
    </div>
  </div>

  <div class="upload modal fade" id="Profile_Modal" data-backdrop="static" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
  	<a class="modal-close" data-dismiss="modal" aria-label="Close"><i class="fa fa-times"></i></a>
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title" id="myModalLabel">Upload Profile Picture</h4>
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
            $NewMemberProfilePictureForm
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" data-dismiss="modal" data-for="ProfileUpload" data-remove-files>Close</button>
        </div>
      </div>
    </div>
  </div>
<% end_if %>
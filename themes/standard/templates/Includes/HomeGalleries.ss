<% loop Galleries %>
	<div class="grid-item">
		<div class="img-container">
	         <a href="$Gallery.Link">
	        	<img class="img-responsive" src="<% if $galleryImage %>$galleryImage.Fill(248,248).Link<% else %>$themeDir/images/profile-placeholder.jpg<% end_if %>" alt="">
	        </a>
        	<div class="image-icon-holder">
        		<span class="">
        		<span class="">
        		<span class="">
        	</div>
		</div>
    	<div class="img-info">
    		<div class="img-title">
    			$Gallery.Title
    		</div>
    	</div>
	</div>
<% end_loop %>
<% if $Galleries.MoreThanOnePage %>
	<% if $Galleries.NotLastPage %>
	    <div class="pagination">
	        <a href="$Galleries.NextLink"></a>
		</div>
	<% else %>
		<div class="pagination">
	        <a class="last-page"></a>
		</div>
	<% end_if %>
<% end_if %>
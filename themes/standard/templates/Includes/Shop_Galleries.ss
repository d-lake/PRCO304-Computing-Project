<% loop Galleries %>
	<div class="grid-item">
		<div class="img-container">
	         <a href="$Link" data-imageID="$ID">
	        	<img class="img-responsive" src="$firstImage.URL" alt="">
	        </a>
        	<div class="image-icon-holder">
        		<span class="">
        		<span class="">
        		<span class="">
        	</div>
		</div>
    	<div class="img-info">
    		<div class="img-title">
    			$Title
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
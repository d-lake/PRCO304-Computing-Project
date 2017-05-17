<% loop Shops %>
	<div class="grid-item">
		<div class="img-container">
	         <a href="$Link" data-imageID="$ID">
	        	<img class="img-responsive" src="<% if $firstImage %>$firstImage.Fill(248,248).Link<% else %>$themeDir/images/shop-placeholder.jpg<% end_if %>" alt="">
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
<% if $Shops.MoreThanOnePage %>
	<% if $Shops.NotLastPage %>
	    <div class="pagination">
	        <a href="$Shops.NextLink"></a>
		</div>
	<% else %>
		<div class="pagination">
	        <a class="last-page"></a>
		</div>
	<% end_if %>
<% end_if %>
<% loop Items %>
	<div class="grid-item">
		<div class="img-container">
	         <a href="">
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
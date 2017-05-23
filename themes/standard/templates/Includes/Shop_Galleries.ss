<% loop Galleries %>
	<div class="grid-item">
		<div class="img-container">
	         <a href="$Link" data-imageID="$ID">
	        	<img class="img-responsive" src="<% if $firstImage %>$firstImage.URL<% else %>$themeDir/images/gallery-placeholder.jpg<% end_if %>" alt="">
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
<div class="clearfix"></div>
<% if $Galleries.MoreThanOnePage %>
	<div class="pagination-holder">
	    <% if $Galleries.NotFirstPage %>
	    <ul id="previous" class="pagination">
	        <li><a href="$Galleries.PrevLink"><i class="fa fa-chevron-left"></i></a></li>
	    </ul>
	    <% end_if %>
	    <ul class="hidden-xs pagination">
	        <% loop $Galleries.Pages %>
	        <li <% if $CurrentBool %>class="active"<% end_if %>><a href="$Link">$PageNum</a></li>
	        <% end_loop %>
	    </ul>
	    <% if $Galleries.NotLastPage %>
	    <ul id="next" class="pagination">
	        <li><a href="$Galleries.NextLink"><i class="fa fa-chevron-right"></i></a></li>
	    </ul>
	    <% end_if %>
	  </div>
<% end_if %>
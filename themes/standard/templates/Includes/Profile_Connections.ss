<% loop Connections %>
	<div class="grid-item">
		<div class="img-container">
	         <a href="$Link" data-imageID="$memberImage.ID">
	        	<img class="img-responsive" src="<% if $memberImage %>$memberImage.Fill(248,248).Link<% else %>$themeDir/images/profile-placeholder.jpg<% end_if %>" alt="">
	        </a>
        	<div class="image-icon-holder">
        		<span class="">
        		<span class="">
        		<span class="">
        	</div>
		</div>
    	<div class="img-info">
    		<div class="img-title">
    			$connectedMember.UserName
    		</div>
    	</div>
	</div>
<% end_loop %>
<% if $Connections.MoreThanOnePage %>
	<% if $Connections.NotLastPage %>
	    <div class="pagination">
	        <a href="$Connections.NextLink"></a>
		</div>
	<% else %>
		<div class="pagination">
	        <a class="last-page"></a>
		</div>
	<% end_if %>
<% end_if %>
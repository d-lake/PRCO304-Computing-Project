<h2>$Title</h2>
 
$Content
 
<% if Members %>
<ul id="member-list">
    <% loop Members %>
    <li>
        <a href="$Link"></a>
        <h2><a href="$Link">$UserName</a></h2>
    </li>
    <% end_loop %>
</ul>
<% end_if %>
<h2>$Title</h2>
 
$Content
 
<% if Shop %>
<ul id="member-list">
    <% control Shop %>
    <li>
        <a href="$Link"></a>
        <h2><a href="$Link">$UserName</a></h2>
    </li>
    <% end_control %>
</ul>
<% end_if %>
<nav class="navbar navbar-standard navbar-fixed-top">
  	<div class="container-fluid">
  		<div class="header-table">
	  		<div class="left-cell">
	  			<a  href="/" class="fa-hover"><i class="fa fa-home fa-header-icon fa-fw" aria-hidden="true"></i></a>
				<span class="fa-title">Home</span>
	    		<%-- <img alt="Logo" src=""> --%>
	  		</div>
	  		<div class="left-cell filter-button">
	  			<button type="button" class="btn" data-toggle="dropdown">
                	<span id="search_concept">Filter by</span> <span class="caret"></span>
                </button>
                <ul class="dropdown-menu" role="menu">
                  <li><a href="#all">All</a></li>
                  <li class="divider"></li>
                  <li><a href="#images">Images</a></li>
                  <li><a href="#galleries">Galleries</a></li>
                  <li><a href="#people">People</a></li>
                  <li><a href="#shops">Shops</a></li>
                </ul>
	  		</div>
	  		<div class="filler-cell search-input">
		  		<div class="navbar-form" role="search">
					<div class="form-group has-feedback">
					   	<input id="Searchbar" type="text" class="form-control" placeholder="Search" value="$SessionSearch">
					   	<span class="search-icon glyphicon glyphicon-search form-control-feedback" aria-hidden="true"></span>
					   	<div id="Searchlist" class="dropdown-menu">
						    <li class="dropdown-item"><a href="#">Search Item</a></li>
						    <li class="dropdown-item"><a href="#">Search Item</a></li>
						    <li class="dropdown-item"><a href="#">Search Item</a></li>
						    <li class="dropdown-item"><a href="#">Search Item</a></li>
						    <li class="dropdown-item"><a href="#">Search Item</a></li>
						    <li class="dropdown-item"><a href="#">Search Item</a></li>
						    <li class="dropdown-item"><a href="#">Search Item</a></li>
						    <li class="dropdown-item"><a href="#">Search Item</a></li>
						    <li class="dropdown-item"><a href="#">Search Item</a></li>
						    <li class="dropdown-item"><a href="#">Search Item</a></li>
						 </div>
					</div>
					<%-- <button type="submit" class="btn btn-default">Submit</button> --%>
				</div>
	  		</div>
	  		<div class="right-cell">
	  			<a  href="/members/view/$CurrentMember.ID" class="fa-hover"><i class="fa fa-user-circle-o fa-header-icon fa-fw" aria-hidden="true"></i></a>
				<span class="fa-title">Profile</span>
	  			<%-- <span class="notification">1</span> --%>
	  		</div>
	  		<div class="right-cell">
	  			<a  href="/Security/logout" class="fa-hover"><i class="fa fa-sign-out fa-header-icon fa-fw" aria-hidden="true"></i></a>
				<span class="fa-title">Log Out</span>
	  		</div>
  		</div>
  	</div>
</nav>

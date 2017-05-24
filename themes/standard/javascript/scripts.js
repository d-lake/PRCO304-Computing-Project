$(function() {
    lightbox.option({
      'showImageNumberLabel': false
  });

    var homeGrid = $('#Home .grid').masonry({
      itemSelector: '.grid-item',
      columnWidth: 250,
      gutter: 30,
      fitWidth: true
  });

    homeGrid.imagesLoaded().progress( function() {
      homeGrid.masonry('layout');
  }).css("display", "inherit");

    var galleryGrid = $('#Gallery .grid').masonry({
      itemSelector: '.grid-item',
      columnWidth: 250,
      gutter: 30,
      fitWidth: true
  });

    galleryGrid.imagesLoaded().progress( function() {
      galleryGrid.masonry('layout');
  }).css("display", "inherit");

    var ShopItemGrid = $('#Shop_Items .grid').masonry({
      itemSelector: '.grid-item',
      columnWidth: 250,
      gutter: 30,
      fitWidth: true
  }); 

    var ShopGalleryGrid = $('#Shop_Galleries .grid').masonry({
      itemSelector: '.grid-item',
      columnWidth: 250,
      gutter: 30,
      fitWidth: true
  }); 

    var profileGalleryGrid = $('#Profile  #Profile_Galleries .grid').masonry({
      itemSelector: '.grid-item',
      columnWidth: 250,
      gutter: 30,
      fitWidth: true
  }); 

    var profileShopGrid = $('#Profile  #Profile_Shops .grid').masonry({
      itemSelector: '.grid-item',
      columnWidth: 250,
      gutter: 30,
      fitWidth: true
  }); 

    var profileConnectionGrid = $('#Profile  #Profile_Connections .grid').masonry({
      itemSelector: '.grid-item',
      columnWidth: 250,
      gutter: 30,
      fitWidth: true
  }); 

    $('a[data-toggle=tab]').each(function () {
      var $this = $(this);
      $this.on('shown.bs.tab', function () {
        ShopItemGrid.imagesLoaded().progress( function() {
          ShopItemGrid.masonry('layout');
      }).css("display", "inherit");
    });
  });

    $('a[data-toggle=tab]').each(function () {
      var $this = $(this);
      $this.on('shown.bs.tab', function () {
        profileGalleryGrid.imagesLoaded().progress( function() {
          profileGalleryGrid.masonry('layout');
      }).css("display", "inherit"); 
    });
  });

    $('a[data-toggle=tab]').each(function () {
      var $this = $(this);
      $this.on('shown.bs.tab', function () {
        profileShopGrid.imagesLoaded().progress( function() {
          profileShopGrid.masonry('layout');
      }).css("display", "inherit"); 
    });
  });

    $('a[data-toggle=tab]').each(function () {
      var $this = $(this);
      $this.on('shown.bs.tab', function () {
        profileConnectionGrid.imagesLoaded().progress( function() {
          profileConnectionGrid.masonry('layout');
      }).css("display", "inherit"); 
    });
  });

    $('a[data-toggle=tab]').each(function () {
      var $this = $(this);
      $this.on('shown.bs.tab', function () {
        ShopGalleryGrid.imagesLoaded().progress( function() {
          ShopGalleryGrid.masonry('layout');
      }).css("display", "inherit"); 
    });
  });

    $(".fa-hover").mouseenter(function(){
    	var title = $(this).next('.fa-title');
    	title.animate({
    		opacity: 1
    	}, 400);
    	$(this).animate({
    		opacity: 0.2
    	}, 400);
    }).mouseleave(function(){
        var title = $(this).next('.fa-title');
        title.animate({
          opacity: 0
      }, 400);
        $(this).animate({
          opacity: 1
      }, 400);
    });

    $(window).scroll(function() {   
     if($(window).scrollTop() + $(window).height() == $(document).height()) {
        var url = $('#Home .pagination a').last().attr('href');
        if(!$('#Home .pagination a').last().hasClass('last-page') && url != null) {
            $("#Loading").css('visibility', 'visible');
            $.ajax(url)
            .done(function (response) {
                var $content = $(response);
                homeGrid.append($content).masonry('appended', $content);
                homeGrid.imagesLoaded().progress( function() {
                homeGrid.masonry('layout');
              }).css("display", "inherit");
                $("#Loading").css('visibility', 'hidden');
            })
            .fail(function (xhr) {
                alert('Error: ' + xhr.responseText);
            });
        } else {
            $("#Loading").html('<h3>No More Images to Load</h3>');
            $("#Loading").css('visibility', 'visible');
        }
    }
});

    $(window).scroll(function() {   
     if($(window).scrollTop() + $(window).height() == $(document).height()) {
        var url = $('#Gallery .pagination a').last().attr('href');
        if(!$('#Gallery .pagination a').last().hasClass('last-page') && url != null) {
            $.ajax(url)
            .done(function (response) {
                var $content = $(response);
                $("#loading").hide();
                galleryGrid.append($content).masonry('appended', $content);
                galleryGrid.imagesLoaded().progress( function() {
                  galleryGrid.masonry('layout');
              }).css("display", "inherit");
            })
            .fail(function (xhr) {
                alert('Error: ' + xhr.responseText);
            });
        }
    }
});

    $(window).scroll(function() {   
     if($(window).scrollTop() + $(window).height() == $(document).height()) {
        var url = $('#Shop .pagination a').last().attr('href');
        if(!$('#Shop.pagination a').last().hasClass('last-page') && url != null) {
            $.ajax(url)
            .done(function (response) {
                var $content = $(response);
                $("#loading").hide();
                ShopItemGrid.append($content).masonry('appended', $content);
                ShopItemGrid.imagesLoaded().progress( function() {
                  ShopItemGrid.masonry('layout');
              }).css("display", "inherit");
            })
            .fail(function (xhr) {
                alert('Error: ' + xhr.responseText);
            });
        }
    }
});

    $('#Profile').on('click', '#Profile_Galleries .pagination a', function (e) {
      e.preventDefault();
        var url = "";
        url = $(this).attr('href')+"&objects=galleries";
        $.ajax(url)
        .done(function (response) {
            var $content = $(response);
            console.log($content);
            profileGalleryGrid.html("");
            $(window).scrollTop(0);
            profileGalleryGrid.append($content).masonry('appended', $content);
            profileGalleryGrid.imagesLoaded().progress( function() {
            profileGalleryGrid.masonry('layout');
          }).css("display", "inherit");
        })
        .fail(function (xhr) {
            alert('Error: ' + xhr.responseText);
        });
    });

    $('#Profile').on('click', '#Profile_Connections .pagination a', function (e) {
      e.preventDefault();
        var url = "";
        url = $(this).attr('href')+"&objects=galleries";
        $.ajax(url)
        .done(function (response) {
            var $content = $(response);
            console.log($content);
            profileGalleryGrid.html("");
            $(window).scrollTop(0);
            profileGalleryGrid.append($content).masonry('appended', $content);
            profileGalleryGrid.imagesLoaded().progress( function() {
            profileGalleryGrid.masonry('layout');
          }).css("display", "inherit");
        })
        .fail(function (xhr) {
            alert('Error: ' + xhr.responseText);
        });
    });

    $('#Profile').on('click', '#Profile_Shops .pagination a', function (e) {
      e.preventDefault();
        var url = "";
        url = $(this).attr('href')+"&objects=galleries";
        $.ajax(url)
        .done(function (response) {
            var $content = $(response);
            console.log($content);
            profileGalleryGrid.html("");
            $(window).scrollTop(0);
            profileGalleryGrid.append($content).masonry('appended', $content);
            profileGalleryGrid.imagesLoaded().progress( function() {
            profileGalleryGrid.masonry('layout');
          }).css("display", "inherit");
        })
        .fail(function (xhr) {
            alert('Error: ' + xhr.responseText);
        });
    });

    $('#Gallery_header').on('click', '#Delete_Gallery', function (e) {
      e.preventDefault();
        deleteModal("Are you sure you want to delete this gallery?");
            var self = $(this);
        $('#Delete_Modal').on('click', '#Btn-Delete', function() {
            var galleryID = $('#Gallery').attr("data-galleryID");
            var url = "removeGallery/deleteGallery?galleryID="+galleryID;
            $('#Delete_Modal').modal('hide');
            $.ajax(url)
            .done(function (response) {
              window.location.replace(self.attr('href'));
            });
        });
    });

    $('#Home').on('click', '.image-icon.addImage .dropdown-menu li a', function () {
        var imageID = $(this).closest(".grid-item").attr('data-imageID');
        var galleryID = $(this).attr("data-galleryID");

        var url = "addImage/addToExistingGallery?imageID="+imageID+"&galleryID="+galleryID;

        var self = $(this);
        self.removeClass('unrelated-gallery');
        self.addClass('related-gallery');
        self.append(' &nbsp<i class="fa fa-spinner fa-pulse"></i>');

        $.getJSON(url, function(data) {
            self.find("i").removeClass('fa-spinner fa-pulse');
            self.find("i").addClass('fa-check');
        });
    });

    $("#Home").on('keyup', '.image-icon.addImage .dropdown-menu li input', function () {
        if(event.keyCode == 13){
            if($(this).val()) {
                var imageID = $(this).closest(".grid-item").attr('data-imageID');

                var galleryName = $(this).val();
                $(this).prop('disabled',true);

                var url = "addImage/addToNewGallery?imageID="+imageID+"&galleryName="+galleryName;

                var self = $(this);
                $("#Home .image-icon ul").append('<li><a class="text-center"><i class="fa fa-spinner fa-pulse"></i></a></li>');

                $.getJSON(url, function(data) {
                    $("#Home .image-icon ul li.divider").show();
                    $("#Home .image-icon ul").each(function() {
                        $(this).find("li").last().html('<a data-galleryid="'+data["galleryID"]+'">'+data["galleryName"]+'</a>');
                    });
                    self.val("");
                    self.prop('disabled',false);
                    self.closest("ul").find("li a").last().addClass('related-gallery').append(' &nbsp<i class="fa fa-check"></i>');
                });
            }
        }
    }).on('focusout', '.image-icon .dropdown-menu li input', function () {
        $(this).val("");
    }).on('click', '.dropdown-menu', function(e) {
        e.stopPropagation();
    });

    $('#Gallery').on('click', '.image-icon.addImage .dropdown-menu li a', function () {
        var imageID = $(this).closest(".grid-item").attr('data-imageID');
        var galleryID = $(this).attr("data-galleryID");

        var url = "galleryAddImage/addToExistingGallery?imageID="+imageID+"&galleryID="+galleryID;

        var self = $(this);
        self.removeClass('unrelated-gallery');
        self.addClass('related-gallery');
        self.append(' &nbsp<i class="fa fa-spinner fa-pulse"></i>');

        $.getJSON(url, function(data) {
            self.find("i").removeClass('fa-spinner fa-pulse');
            self.find("i").addClass('fa-check');
        });
    });

    $("#Gallery").on('keyup', '.image-icon.addImage .dropdown-menu li input', function () {
        if(event.keyCode == 13){
            if($(this).val()) {
                var imageID = $(this).closest(".grid-item").attr('data-imageID');

                var galleryName = $(this).val();
                $(this).prop('disabled',true);

                var url = "galleryAddImage/addToNewGallery?imageID="+imageID+"&galleryName="+galleryName;

                var self = $(this);
                $("#Gallery .image-icon ul").append('<li><a class="text-center"><i class="fa fa-spinner fa-pulse"></i></a></li>');

                $.getJSON(url, function(data) {
                    $("#Gallery .image-icon ul li.divider").show();
                    $("#Gallery .image-icon ul").each(function() {
                        $(this).find("li").last().html('<a data-galleryid="'+data["galleryID"]+'">'+data["galleryName"]+'</a>');
                    });
                    self.val("");
                    self.prop('disabled',false);
                    self.closest("ul").find("li a").last().addClass('related-gallery').append(' &nbsp<i class="fa fa-check"></i>');
                });
            }
        }
    }).on('focusout', '.image-icon .dropdown-menu li input', function () {
        $(this).val("");
    }).on('click', '.dropdown-menu', function(e) {
        e.stopPropagation();
    });

    $('#Home').on('click', '.image-icon.saveImage a', function () {
        var imageID = $(this).closest(".grid-item").attr('data-imageID');
        if($(this).find("i").hasClass('fa-heart-o')) {
            var url = "likeImage/addToFavouritesGallery?imageID="+imageID;
            var self = $(this);
            self.find("i").removeClass('fa-heart-o').addClass('fa-heart');

            $.getJSON(url, function(data) {
            });
        } else if($(this).find("i").hasClass('fa-heart')) {
            var url = "likeImage/removeFromFavouritesGallery?imageID="+imageID;

            var self = $(this);
            self.find("i").removeClass('fa-heart').addClass('fa-heart-o');

            $.getJSON(url, function(data) {
            });
        } else if($(this).find("i").hasClass('fa-times')) {
            var url = "likeImage/removeFromGallery?imageID="+imageID;

            var self = $(this);
            self.find("i").removeClass('fa-times').addClass('fa-spinner fa-pulse');

            $.getJSON(url, function(data) {
            });
        }
    });

    $('#Gallery').on('click', '.image-icon.saveImage a', function () {
        var imageID = $(this).closest(".grid-item").attr('data-imageID');
        if($(this).find("i").hasClass('fa-heart-o')) {
            var url = "galleryLikeImage/addToFavouritesGallery?imageID="+imageID;

            var self = $(this);
            self.find("i").removeClass('fa-heart-o').addClass('fa-heart');

            $.getJSON(url, function(data) {
            });
        } else if($(this).find("i").hasClass('fa-heart')) {
            var url = "galleryLikeImage/removeFromFavouritesGallery?imageID="+imageID;

            var self = $(this);
            self.find("i").removeClass('fa-heart').addClass('fa-heart-o');

            $.getJSON(url, function(data) {
            });
        }
    });

    $('#Gallery').on('click', '.image-icon.removeImage a', function () {
        var imageID = $(this).closest(".grid-item").attr('data-imageID');
        var galleryID = $(this).closest("#Gallery").attr('data-galleryID');
        var self = $(this);
        if($(this).find("i").hasClass('fa-times')) {
            deleteModal("Are you sure you want to delete this image?");
            $('#Delete_Modal').off().on('click', '#Btn-Delete', function() {
              var url = "galleryRemoveImage/removeFromGallery?imageID="+imageID+"&galleryID="+galleryID;
              self.find("i").removeClass('fa-times').addClass('fa-spinner fa-pulse');

              $('#Delete_Modal').modal('hide');
              $.getJSON(url, function(data) {
                  galleryGrid.masonry('remove', self.closest(".grid-item")).masonry('layout');
              });
            });
            $('body').off().on('click', '#Delete_Modal #Btn-No-Delete, #Delete_Modal #Close-Modal, .modal-backdrop', function() {
              $('#Delete_Modal').modal('hide');
            });
        }
    });

    $('#Profile').on('click', '#Btn-Follow', function() {
      var userID = $(this).closest("#Profile").attr('data-userID');
      var url = "memberFollow/connectUser?userID="+userID;

      var self = $(this);
      $.getJSON(url, function(data) {
        self.closest("#Connect_user").html('<button id="Btn-Unfollow" class="btn btn-gold">Unfollow</button>');
      });
    });

    $('#Profile').on('click', '#Btn-Unfollow', function() {
      var userID = $(this).closest("#Profile").attr('data-userID');
      var url = "memberFollow/disconnectUser?userID="+userID;
      
      var self = $(this);
      $.getJSON(url, function(data) {
        self.closest("#Connect_user").html('<button id="Btn-Follow" class="btn btn-gold">Follow</button>');
      });
    });

    
    $("body").tooltip({ selector: '[data-toggle=tooltip]' });

    $('#Profile_Edit_Uploads_Modal, #Gallery_Edit_Uploads_Modal, #Shop_Edit_Uploads_Modal').modal('show');

    // $('.header-table').on('focusin', '#Searchbar', function() {
    //   $(this).dropdown();
    // });
    // $('.header-table').on('focusout', '#Searchbar', function() {
    //   // $(this).parent().removeClass('open');
    // });


    $('#Profile_Edit_Uploads_Modal').on('click', '#Btn-Save-Uploads', function() {
      var imageArray = [];
      $('#Profile_Edit_Uploads_Modal .modal-body .upload-container').each(function(i, obj) {
          var imageDetails = {};
          imageDetails.id = $(this).closest('.upload-container').attr('data-imageID');
          imageDetails.privacy =  $('input[name=optradio]:checked', this).val();
          imageDetails.title = $('input[name=title]', this).val();
          imageDetails.tags = $('textarea[name=tags]', this).val();
          imageArray.push(imageDetails);
      });
        $.ajax({
          url: "createGalleryEditImages/editImages",
          type: 'POST',
          contentType: 'application/json',
          dataType: 'json',
          data: JSON.stringify(imageArray),  
          success:function(data) {
             location.reload();
          }
        });
    });

    $('#Gallery_Edit_Uploads_Modal').on('click', '#Btn-Save-Uploads', function() {
      var imageArray = [];
      $('#Gallery_Edit_Uploads_Modal .modal-body .upload-container').each(function(i, obj) {
          var imageDetails = {};
          imageDetails.id = $(this).closest('.upload-container').attr('data-imageID');
          imageDetails.privacy =  $('input[name=optradio]:checked', this).val();
          imageDetails.title = $('input[name=title]', this).val();
          imageDetails.tags = $('textarea[name=tags]', this).val();
          imageArray.push(imageDetails);
      });
        $.ajax({
          url: "addGalleryEditImages/editImages",
          type: 'POST',
          contentType: 'application/json',
          dataType: 'json',
          data: JSON.stringify(imageArray),  
          success:function(data) {
             location.reload();
          }
        });
    });
    $('#Shop_Edit_Uploads_Modal').on('click', '#Btn-Save-Uploads', function() {
      var imageArray = [];
      $('#Shop_Edit_Uploads_Modal .modal-body .upload-container').each(function(i, obj) {
          var imageDetails = {};
          imageDetails.id = $(this).closest('.upload-container').attr('data-imageID');
          imageDetails.privacy =  $('input[name=optradio]:checked', this).val();
          imageDetails.title = $('input[name=title]', this).val();
          imageDetails.tags = $('textarea[name=tags]', this).val();
          imageArray.push(imageDetails);
      });
        $.ajax({
          url: "createShopGallery/editImages",
          type: 'POST',
          contentType: 'application/json',
          dataType: 'json',
          data: JSON.stringify(imageArray),  
          success:function(data) {
             location.reload();
          }
        });
    });

    $('#Gallery').on('click', '.image-icon.editImage a', function () {
        var imageID = $(this).closest(".grid-item").attr('data-imageID');

          var self = $(this);

          $.ajax({
            url: "editImage/editSingleImage",
            type: 'GET',
            data: {imageID: imageID},
            dataType: 'json',
            success:function(data) {

              $('#Edit_Image_Modal img').attr('src', data["url"]);
              $('#Edit_Image_Modal #Edit_Title input').attr('value', data["title"]);
              $('#Edit_Image_Modal #Edit_Tags textarea').html(data["tags"]);
              if(data["privacy"] == 1) {
                $('#Edit_Image_Modal #Edit_Privacy #Public').prop('checked', 'checked');
              } else if(data["privacy"] == 0){
                $('#Edit_Image_Modal #Edit_Privacy #Private').prop('checked', 'checked');
              }
              $('#Edit_Image_Modal img').on('load', function(){
                $('#Edit_Image_Modal .loadingImg').hide();
                $('#Edit_Image_Modal .upload-image img').show();
              });
              $('#Edit_Image_Modal').find('.upload-container').attr('data-imageID', imageID);
            }
          });
    });

    $('#Shop').off().on('click', '.image-icon.editIcon a', function () {
        var itemID = $(this).closest(".grid-item").attr('data-itemID');
          $.ajax({
            url: "editItem/viewEditSingleItem",
            type: 'GET',
            data: {itemID: itemID},
            dataType: 'json',
            success:function(data) {
               $('#Item_Title input').attr('value', data["title"]);
               $('#Item_Description input').attr('value', data["description"]);
               $('#Item_Price input').attr('value', data["price"]);
               $('#Edit_Item_Modal').find('.upload-container').attr('data-imageID', itemID);
            }
          });
    });

    $('#Edit_Item_Modal').on('click', '#Btn-Save-Uploads', function() {
        var itemArray = [];
        $('#Edit_Item_Modal .modal-body .upload-container').each(function(i, obj) {
            var itemDetails = {};
            itemDetails.id = $(this).closest('.upload-container').attr('data-imageID');
            itemDetails.title =  $('input[name=title]', this).val();
            itemDetails.description = $('input[name=description]', this).val();
            itemDetails.price = $('input[name=price]', this).val();
            itemArray.push(itemDetails);
        });
        $.ajax({
          url: "editItem/editSingleItem",
          type: 'POST',
          contentType: 'application/json',
          dataType: 'json',
          data: JSON.stringify(itemArray),
          success:function(data) {
             location.reload();
          }
        });
    });

    $('#Shop').on('click', '.image-icon.removeItem a', function () {
        var itemID = $(this).closest(".grid-item").attr('data-itemID');
        var self = $(this);
        if($(this).find("i").hasClass('fa-times')) {
            deleteItemModal("Are you sure you want to delete this item?");
            $('#Delete_Item_Modal').off().on('click', '#Btn-Delete', function() {
              var url = "shopRemoveItem/removeItem?itemID="+itemID;
              self.find("i").removeClass('fa-times').addClass('fa-spinner fa-pulse');

              $('#Delete_Item_Modal').modal('hide');
              $.getJSON(url, function(data) {
                  ShopItemGrid.masonry('remove', self.closest(".grid-item")).masonry('layout');
              });
            });
            $('body').off().on('click', '#Delete_Item_Modal #Btn-No-Delete, #Delete_Item_Modal #Close-Modal, .modal-backdrop', function() {
              $('#Delete_Item_Modal').modal('hide');
            });
        }
    });

    $('#Edit_Image_Modal').on('click', '#Btn-Save-Uploads', function() {
      var imageArray = [];
      $('#Edit_Image_Modal .modal-body .upload-container').each(function(i, obj) {
          var imageDetails = {};
          imageDetails.id = $(this).closest('.upload-container').attr('data-imageID');
          imageDetails.privacy =  $('input[name=optradio]:checked', this).val();
          imageDetails.title = $('input[name=title]', this).val();
          imageDetails.tags = $('textarea[name=tags]', this).val();
          imageArray.push(imageDetails);
      });
        $.ajax({
          url: "addGalleryEditImages/editImages",
          type: 'POST',
          contentType: 'application/json',
          dataType: 'json',
          data: JSON.stringify(imageArray),  
          success:function(data) {
             location.reload();
          }
        });
    });

    $('#Edit_Image_Modal').on('hidden.bs.modal', function () {
      $('#Edit_Image_Modal').find('img').attr('src', "");
      $('#Edit_Image_Modal').find('.upload-container').attr('data-imageID', "");
      $('#Edit_Image_Modal .loadingImg').show();
      $('#Edit_Image_Modal .upload-image img').hide();
    });

    $("#Searchbar").on('keyup', function (e) {
        e.stopPropagation();
        if (e.keyCode == 13) {
            var search = $("#Searchbar").val();
            var filter = $("#Btn-Filter .btn").attr('data-filter');

            $pageType = $('body').attr("class");
            $url = "";

            switch($pageType) {
                case "Page":
                    $url = "searchPage";
                    break;
                case "MemberPage":
                    $url = "searchMemberPage";
                    break;
                case "GalleryPage":
                    $url = "searchGalleryPage";
                    break;
                case "ShopPage":
                    $url = "searchShopPage";
                    break;
            }

            $.ajax({
              url: $url+"/search?filter="+filter,
              type: 'GET',
              data: {search: search},
              success:function(data) {
                if($('body').attr("class") != "Page") {
                  window.location.replace("/");
                }
                $('#Home .grid').html("");
                var $content = $(data);
                homeGrid.append($content).masonry('appended', $content);
                homeGrid.imagesLoaded().progress( function() {
                  homeGrid.masonry('layout');
                }).css("display", "inherit");
              }
            });
        }
    });

    function deleteModal(text) {
      $('#Delete_Modal').modal('show');
      $('#Delete_Modal .modal-body h4').html(text);
    }

    function deleteItemModal(text) {
      $('#Delete_Item_Modal').modal('show');
      $('#Delete_Item_Modal .modal-body h4').html(text);
    }

    $('#Delete_Modal, #View_Item_Modal, #Delete_Item_Modal').modal({
      backdrop: 'static',
      show: false
    }); 

    $("#Btn-Category .dropdown-menu li a").click(function(){
      $("#Btn-Category .btn").html($(this).text()+'&nbsp<i class="fa fa-caret-down" aria-hidden="true"></i>');
    });

    $("#Btn-Sort .dropdown-menu li ").click(function(){
      $("#Btn-Sort .btn").html($(this).text()+'&nbsp<i class="fa fa-caret-down" aria-hidden="true"></i>');
      $("#Btn-Sort .btn").attr("data-sort", $(this).text());
    });

    $("#Btn-Filter .dropdown-menu li ").click(function(){
      $("#Btn-Filter .btn").html($(this).text()+'&nbsp<i class="fa fa-caret-down" aria-hidden="true"></i>');
      $("#Btn-Filter .btn").attr("data-filter", $(this).text());
    });

    $('#Shop').on('click', '.img-container .hovereffect>a', function () {
        var itemID = $(this).closest(".grid-item").attr('data-itemID');

          $.ajax({
            url: "viewItem/viewSingleItem",
            type: 'GET',
            data: {itemID: itemID},
            dataType: 'json',
            success:function(data) {
               $('#Item_Title p').html(data["title"]);
               $('#Item_Description p').html(data["description"]);
               $('#Item_Price p').html("£"+data["price"]);
              for (i = 0; i < data["imageURLS"].length; i++) { 
                  if(i == 0) {
                    $('#View_Item_Modal #Item_Carousel .carousel-inner').append('<div class="item active"><img src="'+data["imageURLS"][i]+'"></div>');
                  } else {
                    $('#View_Item_Modal #Item_Carousel .carousel-inner').append('<div class="item"><img src="'+data["imageURLS"][i]+'"></div>');
                  }
              }
            }
          });
    });

    $('#Shop').on('click', '#Delete_Shop', function (e) {
      e.preventDefault();
        deleteModal("Are you sure you want to delete this shop?");
            var self = $(this);
        $('#Delete_Modal').on('click', '#Btn-Delete', function() {
            var shopID = $('#Shop').attr("data-shopID");
            var url = "removeShop/deleteShop?shopID="+shopID;
            $('#Delete_Modal').modal('hide');
            $.ajax(url)
            .done(function (response) {
              window.location.replace(self.attr('href'));
            });
        });
    });

    $('#View_Item_Modal').on('hidden.bs.modal', function () {
      $('#Item_Title p').html("");
      $('#Item_Description p').html("");
      $('#Item_Price p').html("");
      $('#View_Item_Modal #Item_Carousel .carousel-inner').html("");
    });

    $("#Item-Searchbar").on('keyup', function (e) {
        e.stopPropagation();
        if (e.keyCode == 13) {
            var search = $("#Item-Searchbar").val();
            if( search == "") {
              search = "null"
            }
            var sort = $('#Btn-Sort .btn').attr('data-sort');
            var shopID = $('#Shop').attr("data-shopID");
            $.ajax({
              url: "itemSearch/searchItem?shopID="+shopID+"&sort="+sort,
              type: 'GET',
              data: {search: search},
              success:function(data) {
                $('#Shop_Items .grid').html("");
                var $content = $(data);
                ShopItemGrid.append($content).masonry('appended', $content);
                ShopItemGrid.imagesLoaded().progress( function() {
                  ShopItemGrid.masonry('layout');
                }).css("display", "inherit");
              }
            });
        }
    });
});
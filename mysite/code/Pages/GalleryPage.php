<?php 
 
class GalleryPage extends Page {

	private static $has_many = array(
		'Gallery' => 'Gallery'
    );
}
 
class GalleryPage_Controller extends Page_Controller {

	static $allowed_actions = array (
		'view',
		'AddToGalleryForm',
		'addToExistingGallery',
		'addToNewGallery',
		'addToFavouritesGallery',
		'removeFromFavouritesGallery',
		'removeFromGallery',
		'editImages',
		'editSingleImage',
		'EditGalleryForm',
		'search',
		'deleteGallery'
	);

	public function getGallery() {
		$Params = $this->getURLParams();

		if(is_numeric($Params['ID']) && $gallery = DataObject::get_by_id('Gallery', (int)$Params['ID'])) {       
            return $gallery;
        }
	}

	public function ifMyGallery() {
        $Params = $this->getURLParams();

        if(is_numeric($Params['ID']) && $gallery = DataObject::get_by_id('Gallery', (int)$Params['ID'])) { 
            $currentMember = Member::currentUser();
            if($gallery->MemberID == $currentMember->ID) {
                return true;
            } else {
                return false;
            }
        }
    }

	public function view(SS_HTTPRequest $request) {

        if($redirect = $this->redirectToLogin()) {
			return $redirect;
		}

		if($thisGallery = $this->getGallery()) {
            $images = $thisGallery->Image();

			$currentMember = Member::currentUser();
		   
		    $memberGalleries = $currentMember->Gallery();

		    $galleries = $memberGalleries->exclude("Title", array("Favourites", "Profile Pictures", "Cover Pictures"));

			$imagesArray = new ArrayList();

			foreach ($images as $image) {
				$id = $image->OwnerID;
				$member = Member::get()->byId($id);

	            $userName = $member->UserName;
            	$memberID = $member->ID;    

				$userURL = "members/view/".$memberID;

				$profilePictureImage = false;

				if($profilePicture = MemberProfilePicture::get()->byId($member->MemberProfilePictureID)) {
					$profilePictureImage = Image::get()->byId($profilePicture->ImageID);
				}

				$allGalleries = new ArrayList();

				foreach ($galleries as $gallery) {	
					$count = 0;
					foreach($image->Gallery() as $relatedGallery) {
						if($relatedGallery->ID == $gallery->ID) {
							$allGalleries->push(new ArrayData(array('Gallery' => $gallery, 'Related' => true)));
							$count++;
						}
					}
					if ($count == 0) {
						$allGalleries->push(new ArrayData(array('Gallery' => $gallery, 'Related' => false)));
					}
				}

				$isFavourited = null;
				if($favouritedGallery = DataObject::get_one("Gallery", "MemberID = '".$currentMember->ID."' AND Title = 'Favourites'")) {
					foreach($favouritedGallery->Image() as $loopedImage) {
						if($loopedImage->ID == $image->ID) {
							$isFavourited = true;
						}
					}
				}

				$imagesArray->push(new ArrayData(array('Image' => $image, 'ProfilePictureImage' => $profilePictureImage, 'UserURL' => $userURL, 'AllGalleries' => $allGalleries, 'isFavourited' => $isFavouritel, 'userName' => $userName)));
			}

			$paginatedImages = PaginatedList::create(
	            $imagesArray,
	            $request
	        )->setPageLength(50)
	         ->setPaginationGetVar('images');

	        $recentUploadsArray = new ArrayList();
            if($sessionarray = Session::get("ImageUploads")) {
                foreach($sessionarray as $imageID) {
                    $recentUploadsArray->push(new ArrayData(array('Image' => Image::get()->byId($imageID))));
                }
            }

			$data = array (
				'Gallery' => $thisGallery,
	            'Images' => $paginatedImages,
                'recentUploads' => $recentUploadsArray
	        );

	        if($request->isAjax()) {
	        	return $this->Customise($data)->renderWith('GalleryImages');
	        };

	        return $data;
        } else {
            return $this->httpError(404, 'Sorry this gallery could not be found');
        }
	}

	public function AddToGalleryForm() {
        $gallery = $this->getGallery();
        $fields = new FieldList(
            $field = new UploadField('Image', 'Upload Image'),
            new HiddenField('GalleryID', null, $gallery->ID)
        );

        $field->setCanAttachExisting(false); // Block access to SilverStripe assets library
        $field->setCanPreviewFolder(false); // Don't show target filesystem folder on upload field
        $field->relationAutoSetting = false; // Prevents the form thinking the GalleryPage is the underlying object
        $field->setFolderName('Uploads/Images');

        $actions = new FieldList(new FormAction('addToGallery', 'Add to Gallery'));
        return new Form($this, 'AddToGalleryForm', $fields, $actions, null);
    }

    public function addToGallery($data, $form) {
    	$gallery = DataObject::get_by_id('Gallery', $data["GalleryID"]);
    	Session::set('ImageUploads', array());
    	foreach ($data["Image"]["Files"] as $uploadedImage) {
    		$image = DataObject::get_by_id('Image', $uploadedImage);
    		$gallery->Image()->add($image);
    		Session::add_to_array('ImageUploads', $uploadedImage);
    	}

        return $this->redirectBack();
    }

    public function EditGalleryForm() {
        $gallery = $this->getGallery();
        $fields = new FieldList(
            $field = new TextField('Title', 'Gallery Title', $gallery->Title, 255),
            new HiddenField('GalleryID', null, $gallery->ID)
        );

        $actions = new FieldList(new FormAction('editGallery', 'Save Gallery'));
        return new Form($this, 'EditGalleryForm', $fields, $actions, null);
    }

    public function editGallery($data, $form) {
    	$gallery = DataObject::get_by_id('Gallery', $data["GalleryID"]);

        $gallery->Title = $data["Title"];
        $gallery->write();

        return $this->redirectBack();
    }

    public function deleteGallery(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
	    	$gallery = DataObject::get_by_id('Gallery', $request->getVar('galleryID'));
	    	foreach($gallery->Image() as $image) {
	    		$gallery->Image()->remove($image);
	    	}

	    	$gallery->delete();

	    	return true;
        } else {
            return null;
        }
    }

    public function addToExistingGallery(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $gallery = DataObject::get_by_id('Gallery', $request->getVar('galleryID'));
	    	$image = DataObject::get_by_id('Image', $request->getVar('imageID'));
	    	$gallery->Image()->add($image);

	    	return true;
        } else {
            return null;
        }
    }

    public function addToNewGallery(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $galleryName = $request->getVar('galleryName');
	    	$image = DataObject::get_by_id('Image', $request->getVar('imageID'));

	    	$currentMemberID = Member::currentUserID();

	        $gallery = new Gallery();
	        $gallery->MemberID = $currentMemberID;
	        $gallery->Title = $galleryName;
	        $gallery->write();

	    	$gallery->Image()->add($image);

	    	return json_encode(array('galleryID' => $gallery->ID, 'galleryName'=> $galleryName));

        } else {
            return null;
        }
    }

    public function addToFavouritesGallery(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
        	$memberID = Member::currentUserID();

        	$image = DataObject::get_by_id('Image', $request->getVar('imageID'));
        	$gallery = DataObject::get_one("Gallery", "MemberID = '".$memberID."' AND Title = 'Favourites'");
		    $gallery->Image()->add($image);
	    	return true;
        } else {
            return null;
        }
    }

    public function removeFromFavouritesGallery(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
        	$memberID = Member::currentUserID();

        	$image = DataObject::get_by_id('Image', $request->getVar('imageID'));
        	$gallery = DataObject::get_one("Gallery", "MemberID = '".$memberID."' AND Title = 'Favourites'");
		    $gallery->Image()->remove($image);
	    	return true;
        } else {
            return null;
        }
    }

    public function removeFromGallery(SS_HTTPRequest $request) {
        if (Director::is_ajax()){

        	$gallery = DataObject::get_by_id('Gallery', $request->getVar('galleryID'));
	    	$image = DataObject::get_by_id('Image', $request->getVar('imageID'));
        	$gallery->Image()->remove($image);

	    	return true;
        } else {
            return null;
        }
    }

    public function editImages(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $requestBody = json_decode($request->getBody(), true);
            foreach($requestBody as $imageRequest) {
                $image = Image::get()->byId($imageRequest["id"]);

                if($imageRequest["privacy"] == "Private") {
                    $image->Privacy = 0;
                } else {
                    $image->Privacy = 1;
                }
                if($imageTitle = $imageRequest["title"]) {
                    $image->Title = ucfirst($imageTitle);
                }
                if($imageTags = $imageRequest["tags"]) {
                    foreach ($this->splitTags($imageTags) as $tag) {
                        if($existingTag = DataObject::get_one("Tag", "Tag = '".$tag."'")) {
                            $image->Tag()->add($existingTag);
                        } else {
                            $newTag = new Tag();
                            $newTag->Tag = $tag;
                            $newTag->write();
                            $image->Tag()->add($newTag);
                        }
                    }
                }
                $image->write();
            }
            Session::clear('ImageUploads');
            return true;
        } else {
            return null;
        }
    }

    public function editSingleImage(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $image = DataObject::get_by_id('Image', $request->getVar('imageID'));
            $tagArray = array();
            foreach($image->Tag() as $tag) {
            	array_push($tagArray, $tag->Tag);
            }
            return json_encode(array("title" => $image->Title, "url" => $image->URL, "privacy" => $image->Privacy, "tags" => implode(", ", $tagArray)));
        } else {
            return null;
        }
    }

    public function search(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            if($request->getVar('search')) {
                $searchArray = explode(" ", $request->getVar('search'));
                $explodedSearchArray = array_map('trim', $searchArray);
                Session::clear('Search');
                Session::save();
                Session::set('Search', $explodedSearchArray);
                Session::save();
            } else {
                Session::clear('Search');
                Session::save();
                Session::set('Search', NULL);
                Session::save();
            }
        } else {
            return null;
        }
    }
}
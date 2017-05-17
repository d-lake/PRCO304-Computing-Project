<?php
class Page extends SiteTree {

	private static $db = array(
	);

	private static $has_one = array(
	);

}
class Page_Controller extends ContentController {

	private static $allowed_actions = array (
		'RetrieveAndAddUsersForm',
		'CommentForm',
		'addToExistingGallery',
		'addToNewGallery',
		'addToFavouritesGallery',
		'removeFromFavouritesGallery',
		'search'
	);

	public function init() {
		parent::init();
	}

	public function index(SS_HTTPRequest $request) {
		if($redirect = $this->redirectToLogin()) {
			return $redirect;
		}

		if($sessionSearch = Session::get('Search')) {
			$images = new ArrayList();
        	foreach($sessionSearch as $searchItem) {
        		$imageSet = Image::get()->filter(array('Title:PartialMatch' => $searchItem));

	        	foreach ($imageSet as $image) {
	        		$images->push($image);
	        	}
        	}

			foreach($sessionSearch as $searchItem) {
	        	$tagPartials = Tag::get()->filter(array('Tag:PartialMatch' => $searchItem));

	        	foreach ($tagPartials as $manyTag) {
	        		foreach ($manyTag->Image() as $tag) {
	        			$singleImage = Image::get()->byId($tag->ID);
						$images->push($singleImage);
	        		}
	        	}
	        }
	        $images->removeDuplicates();
	        $sessionSearchVal = implode(" ", $sessionSearch);
		} else {
	        $sessionSearchVal = "";
			$images = Image::get()->sort('Title', DESC);
		}
		
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

			$imagesArray->push(new ArrayData(array('Image' => $image, 'ProfilePictureImage' => $profilePictureImage, 'UserURL' => $userURL, 'AllGalleries' => $allGalleries, 'isFavourited' => $isFavourited, 'userName' => $userName)));
		}

		$paginatedImages = PaginatedList::create(
            $imagesArray,
            $request
        )->setPageLength(50)
         ->setPaginationGetVar('images');

		$data = array (
            'Images' => $paginatedImages,
            'SessionSearch' => $sessionSearchVal
        );

        if($request->isAjax()) {
        	return $this->Customise($data)->renderWith('HomeImages');
        };

        return $data;
	}
	public function redirectToLogin() {
		if (!Member::currentUserID()) {
			return $this->redirect('/login');
		}
	}

	public function RetrieveAndAddUsersForm() {
        $fields = new FieldList(
        );

        $actions = new FieldList(new FormAction('retrieveAndAddUsers', 'Run Code'));
        return new Form($this, 'RetrieveAndAddUsersForm', $fields, $actions, null);
    }

    public function retrieveAndAddUsers($data, $form) {
    	$curl = curl_init();
		// Set some options - we are passing in a useragent too here
		curl_setopt_array($curl, array(
		    CURLOPT_RETURNTRANSFER => 1,
		    // CURLOPT_URL => 'https://randomuser.me/api/'
		    CURLOPT_URL => 'https://euw1.api.riotgames.com/lol/static-data/v3/champions?champData=all&api_key=RGAPI-2bfd21e5-c70f-4062-95e5-e0217513e966'
		));
		$jsonData = json_decode(curl_exec($curl));
    	curl_close($curl);

    	// foreach ($jsonData->results as $data) {

    	// 	$member = new Member();
    	// 	$member->FirstName = $data->name->first;
    	// 	$member->Surname = $data->name->last;
    	// 	$member->Email = $data->email;
    	// 	$member->UserName = $data->login->username;
    	// 	// $password = $data->login->password;
    	// 	$member->changePassword("password");
    	// 	$member->write();

	    // 	if(!$userGroup = DataObject::get_one('Group', "Code = 'registered-users'")){
	    //         $userGroup = new Group();
	    //         $userGroup->Code = "registered-users";
	    //         $userGroup->Title = "Users";
	    //         $userGroup->Write();
	    //         $userGroup->Members()->add($member);
	    //     }
	    //     $userGroup->Members()->add($member);
    	// }

    	foreach ($jsonData->data as $champion => $data) {
    		var_dump($champion."</br>");
    		var_dump($data."</br>");
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

        	if($gallery = DataObject::get_one("Gallery", "MemberID = '".$memberID."' AND Title = 'Favourites'")) {
		    	$gallery->Image()->add($image);
	        } else {
	            $newGallery = new Gallery();
	            $newGallery->MemberID = $member->ID;
	            $newGallery->Title = "Favourites";
	            $newGallery->write();
		    	$newGallery->Image()->add($image);
	        }

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

    public function search(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
        	if($request->getVar('search')) {
                $searchArray = explode(" ", $request->getVar('search'));
                $explodedSearchArray = array_map('trim', $searchArray);
                Session::clear('Search');
                Session::save();
                Session::set('Search', $explodedSearchArray);
                Session::save();

                $images = new ArrayList();

	        	foreach($explodedSearchArray as $searchItem) {
	        		$imageSet = Image::get()->filter(array('Title:PartialMatch' => $searchItem));

		        	foreach ($imageSet as $image) {
		        		$images->push($image);
		        	}
	        	}

				foreach($explodedSearchArray as $searchItem) {
		        	$tagPartials = Tag::get()->filter(array('Tag:PartialMatch' => $searchItem));

		        	foreach ($tagPartials as $manyTag) {
		        		foreach ($manyTag->Image() as $tag) {
		        			$singleImage = Image::get()->byId($tag->ID);
							$images->push($singleImage);
		        		}
		        	}
		        }
		        $images->removeDuplicates();
            } else {
            	Session::clear('Search');
                Session::save();
                $images = Image::get()->sort('Title', DESC);
            }


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

				$imagesArray->push(new ArrayData(array('Image' => $image, 'ProfilePictureImage' => $profilePictureImage, 'UserURL' => $userURL, 'AllGalleries' => $allGalleries, 'isFavourited' => $isFavourited, 'userName' => $userName)));
			}

			$paginatedImages = PaginatedList::create(
	            $imagesArray,
	            $request
	        )->setPageLength(50)
	         ->setPaginationGetVar('images');

			$data = array (
	            'Images' => $paginatedImages
	        );

        	return $this->Customise($data)->renderWith('HomeImages');
        } else {
            return null;
        }
    }

    public function splitTags($stringSet) {
        $tagArray = explode(",", $stringSet);
        return array_map('trim', $tagArray);
    }

}

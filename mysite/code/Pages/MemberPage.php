<?php 
 
class MemberPage extends Page {

	private static $has_many = array(
        'Members' => 'Member'
    );
}
 
class MemberPage_Controller extends Page_Controller {

	static $allowed_actions = array (
		'view',
        'NewGalleryForm',
        'NewShopForm',
        'NewMemberProfilePictureForm',
        'NewMemberCoverPictureForm',
        'connectUser',
        'disconnectUser',
        'ChangePassword',
        'EditBioForm',
        'editImages',
        'search'
	);

	public function getMember() {
		$Params = $this->getURLParams();

		if(is_numeric($Params['ID']) && $member = DataObject::get_by_id('Member', (int)$Params['ID'])) {
            return $member;
        }
	}

    public function ifMyProfile() {
        $Params = $this->getURLParams();

        if(is_numeric($Params['ID']) && $member = DataObject::get_by_id('Member', (int)$Params['ID'])) { 
            $currentMember = Member::currentUser();
            if($currentMember == $member) {
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
        if($member = $this->getMember()) {
            $paginatedGalleries = false;
            if($galleries = $member->Gallery()) {
                $paginatedGalleries = PaginatedList::create(
                    $galleries,
                    $request
                )->setPageLength(20)
                 ->setPaginationGetVar('galleries');
            }
            
            $paginatedShops = false;
            if($shops = $member->Shop()) {
                $paginatedShops = PaginatedList::create(
                    $shops,
                    $request
                )->setPageLength(20)
                 ->setPaginationGetVar('shops');
            }

            $paginatedConnections = false;
            if($connections = $member->Connection()) {
                $paginatedConnections = PaginatedList::create(
                    $connections,
                    $request
                )->setPageLength(20)
                 ->setPaginationGetVar('connections');
            }

            $currentMember = Member::currentUser();
            $connected = false;
            foreach ($currentMember->Connection() as $connection) {
                if($connection->MemberConnectionID == $member->ID) {
                    $connected = true;
                }
            }

            $recentUploadsArray = new ArrayList();
            if($sessionarray = Session::get("ImageUploads")) {
                foreach($sessionarray as $imageID) {
                    $recentUploadsArray->push(new ArrayData(array('Image' => Image::get()->byId($imageID))));
                }
            }

            $data = array (
                'Connected' => $connected,
                'Galleries' => $paginatedGalleries,
                'Shops' => $paginatedShops,
                'Member' => $member,
                'Connections' => $paginatedConnections,
                'recentUploads' => $recentUploadsArray
            );

            if($request->isAjax()) {
                if($shops = $request->getVar('shops') || $request->getVar('objects') == "shops") {
                    $data = array (
                        'Shops' => $paginatedShops,
                        'Member' => $member
                    );
                    return $this->Customise($data)->renderWith('Profile_Shops');
                } else if($galleries = $request->getVar('galleries') || $request->getVar('objects') == "galleries") {
                    $data = array (
                        'Galleries' => $paginatedGalleries,
                        'Member' => $member
                    );
                    return $this->Customise($data)->renderWith('Profile_Galleries');
                } else if($connections = $request->getVar('connections') || $request->getVar('objects') == "connections") {
                    $data = array (
                        'Connections' => $paginatedConnections,
                        'Member' => $member
                    );
                    return $this->Customise($data)->renderWith('Profile_Connections');
                }
            };

            return $data;
        } else {
            return $this->httpError(404, 'Sorry that shop could not be found');
        }
	}

    public function NewGalleryForm() {
        $fields = new FieldList(
            new TextField('Title', 'Gallery Title', null, 255),
            $field = new UploadField('Image', 'Upload Image')
        );

        $field->setCanAttachExisting(false); // Block access to SilverStripe assets library
        $field->setCanPreviewFolder(false); // Don't show target filesystem folder on upload field
        $field->relationAutoSetting = false; // Prevents the form thinking the GalleryPage is the underlying object
        $field->setConfig('fileEditFields', 'getCustomFields');

        $field->setFolderName('Uploads/Images');
        
        $actions = new FieldList(new FormAction('newGallery', 'Save Gallery'));
        return new Form($this, 'NewGalleryForm', $fields, $actions, null);
    }

    public function newGallery($data, $form) {
        $currentMemberID = Member::currentUserID();

        $gallery = new Gallery();
        $gallery->MemberID = $currentMemberID;
        $form->saveInto($gallery);
        $gallery->write();
        
        Session::set('ImageUploads', array());

        foreach($data["Image"]["Files"] as $imageID) {
            Session::add_to_array('ImageUploads', $imageID);
        }
        Session::save();
        
        return $this->redirectBack();
    }

    public function NewShopForm() {
        $fields = new FieldList(
            new TextField('Title', 'Shop Name', null, 255),
            new TextField('ShopURL', 'Shop URL'),
            new EmailField('ShopEmail', 'Shop Email')
        );

        $actions = new FieldList(new FormAction('newShop', 'Save Shop'));
        return new Form($this, 'NewShopForm', $fields, $actions, null);
    }

    public function newShop($data, $form) {
        $currentMemberID = Member::currentUserID();

        $shop = new Shop();
        $shop->MemberID = $currentMemberID;
        $form->saveInto($shop);
        $shop->write();

        return $this->redirectBack();
    }

    public function NewMemberProfilePictureForm() {
        $fields = new FieldList(
            $field = new UploadField('Image', 'Upload Image')
        );

        $field->setCanAttachExisting(false); // Block access to SilverStripe assets library
        $field->setCanPreviewFolder(false); // Don't show target filesystem folder on upload field
        $field->relationAutoSetting = false; // Prevents the form thinking the GalleryPage is the underlying object
        $field->setFolderName('Uploads/Images');

        $actions = new FieldList(new FormAction('newMemberProfilePicture', 'Save Profile Picture'));
        return new Form($this, 'NewMemberProfilePictureForm', $fields, $actions, null);
    }

    public function newMemberProfilePicture($data, $form) {
        $member = Member::currentUser();

        $image = new MemberProfilePicture();
        $form->saveInto($image);
        $id = $image->write();
        $member->MemberProfilePictureID = $id;
        $member->write();

        Session::set('ImageUploads', array());

        foreach($data["Image"]["Files"] as $imageID) {
            Session::add_to_array('ImageUploads', $imageID);
        }
        Session::save();

        if($gallery = DataObject::get_one("Gallery", "MemberID = '".$member->ID."' AND Title = 'Profile Pictures'")) {
            $gallery->Image()->add($image->Image());
        } else {
            $newGallery = new Gallery();
            $newGallery->MemberID = $member->ID;
            $newGallery->Title = "Profile Pictures";
            $newGallery->write();
            $newGallery->Image()->add($image->Image());
        }

        return $this->redirectBack();
    }

    public function NewMemberCoverPictureForm() {
        $fields = new FieldList(
            $field = new UploadField('Image', 'Upload Image')
        );

        $field->setCanAttachExisting(false); // Block access to SilverStripe assets library
        $field->setCanPreviewFolder(false); // Don't show target filesystem folder on upload field
        $field->relationAutoSetting = false; // Prevents the form thinking the GalleryPage is the underlying object
        $field->setFolderName('Uploads/Images');

        $actions = new FieldList(new FormAction('newMemberCoverPicture', 'Save Cover Picture'));
        return new Form($this, 'NewMemberCoverPictureForm', $fields, $actions, null);
    }

    public function newMemberCoverPicture($data, $form) {
        $member = Member::currentUser();

        $image = new MemberCoverPicture();
        $form->saveInto($image);
        $id = $image->write();
        $member->MemberCoverPictureID = $id;
        $member->write();

        Session::set('ImageUploads', array());

        foreach($data["Image"]["Files"] as $imageID) {
            Session::add_to_array('ImageUploads', $imageID);
        }
        Session::save();

        if($gallery = DataObject::get_one("Gallery", "MemberID = '".$member->ID."' AND Title = 'Cover Pictures'")) {
            $gallery->Image()->add($image->Image());
        } else {
            $newGallery = new Gallery();
            $newGallery->MemberID = $member->ID;
            $newGallery->Title = "Cover Pictures";
            $newGallery->write();
            $newGallery->Image()->add($image->Image());
        }

        return $this->redirectBack();
    }

    public function EditBioForm() {
        $member = Member::currentUser();

        $fields = new FieldList(
            $field = new TextField('FirstName', 'First Name', $member->FirstName, 255),
            $field = new TextField('Surname', 'Last Name', $member->Surname, 255),
            $field = new TextAreaField('Bio', 'Add Bio', $member->Bio)
        );

        $actions = new FieldList(new FormAction('editBio', 'Save Bio'));
        return new Form($this, 'EditBioForm', $fields, $actions, null);
    }

    public function editBio($data, $form) {
        $member = Member::currentUser();

        $member->FirstName = $data["FirstName"];
        $member->Surname = $data["Surname"];
        $member->Bio = $data["Bio"];
        $member->write();

        return $this->redirectBack();
    }

    public function connectUser(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $member = DataObject::get_by_id('Member', $request->getVar('userID'));

            $currentMember = Member::currentUser();

            $connection = new Connection();
            $connection->MemberConnectionID = $member->ID;
            $connection->MemberID = $currentMember->ID;
            $connection->write();
            return true;
        } else {
            return null;
        }

    }

    public function disconnectUser(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $currentMember = Member::currentUser();
            $connections = DataObject::get('Connection', 'MemberID = '.$currentMember->ID.' AND MemberConnectionID = '.$request->getVar('userID').'');
            foreach ($connections as $deleteConnection) {
                $deleteConnection->delete();
            }
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

    public function ChangePassword() {
        return new ChangePasswordForm($this, 'ChangePassword');
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
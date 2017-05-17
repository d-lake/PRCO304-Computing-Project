<?php 
 
class ShopPage extends Page {

	private static $has_many = array(
		'Shop' => 'Shop'
    );
}
 
class ShopPage_Controller extends Page_Controller {

	static $allowed_actions = array (
		'view',
        'NewShopProfilePictureForm',
        'NewShopCoverPictureForm',
        'AddItemForm',
        'EditShopBioForm',
        'search'
	);

	public function getShop() {
		$Params = $this->getURLParams();

		if(is_numeric($Params['ID']) && $shop = DataObject::get_by_id('Shop', (int)$Params['ID'])) {       
            return $shop;
        }
	}

	public function ifMyShop() {
        $Params = $this->getURLParams();

        if(is_numeric($Params['ID']) && $shop = DataObject::get_by_id('Shop', (int)$Params['ID'])) { 
            $currentMember = Member::currentUser();
            if($shop->MemberID == $currentMember->ID) {
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
        if($shop = $this->getShop()) {
            $items = $shop->Item();

			$paginatedItems = PaginatedList::create(
	            $items,
	            $request
	        )->setPageLength(20)
	         ->setPaginationGetVar('s');

			$data = array (
	            'Items' => $paginatedItems,
                'Shop' => $shop
	        );

	        if($request->isAjax()) {
	        	return $this->Customise($data)->renderWith('Shop_Items');
	        };

	        return $data;
        } else {
            return $this->httpError(404, 'Sorry that shop could not be found');
        }
	}

	public function NewShopProfilePictureForm() {
        $shop = $this->getShop();

        $fields = new FieldList(
            $field = new UploadField('Image', 'Upload Image'),
            new HiddenField('ShopID', null, $shop->ID)
        );

        $field->setCanAttachExisting(false); // Block access to SilverStripe assets library
        $field->setCanPreviewFolder(false); // Don't show target filesystem folder on upload field
        $field->relationAutoSetting = false; // Prevents the form thinking the GalleryPage is the underlying object
        $field->setFolderName('Uploads/Images');

        $actions = new FieldList(new FormAction('newShopProfilePicture', 'Save Profile Picture'));
        return new Form($this, 'NewShopProfilePictureForm', $fields, $actions, null);
    }

    public function newShopProfilePicture($data, $form) {
    	$shop = DataObject::get_by_id('Shop', $data["ShopID"]);

        $image = new ShopProfilePicture();
        $form->saveInto($image);
        $id = $image->write();
        $shop->ShopProfilePictureID = $id;
        $shop->write();

        return $this->redirectBack();
    }

    public function NewShopCoverPictureForm() {
        $shop = $this->getShop();

        $fields = new FieldList(
            $field = new UploadField('Image', 'Upload Image'),
            new HiddenField('ShopID', null, $shop->ID)
        );

        $field->setCanAttachExisting(false); // Block access to SilverStripe assets library
        $field->setCanPreviewFolder(false); // Don't show target filesystem folder on upload field
        $field->relationAutoSetting = false; // Prevents the form thinking the GalleryPage is the underlying object
        $field->setFolderName('Uploads/Images');

        $actions = new FieldList(new FormAction('newShopCoverPicture', 'Save Cover Picture'));
        return new Form($this, 'NewShopCoverPictureForm', $fields, $actions, null);
    }

    public function newShopCoverPicture($data, $form) {
    	$shop = DataObject::get_by_id('Shop', $data["ShopID"]);

        $image = new ShopCoverPicture();
        $form->saveInto($image);
        $id = $image->write();
        $shop->ShopCoverPictureID = $id;
        $shop->write();

        return $this->redirectBack();    
    }

    public function AddItemForm() {
        $shop = $this->getShop();

        $fields = new FieldList(
            new TextField('Title', 'Item Title', null, 255),
            new TextAreaField('Description', 'Item Description'),
            new CurrencyField('Price', 'Item Price', null, 255),
            $field = new UploadField('Image', 'Upload Image'),
            new HiddenField('ShopID', null, $shop->ID)
        );

        $field->setCanAttachExisting(false); // Block access to SilverStripe assets library
        $field->setCanPreviewFolder(false); // Don't show target filesystem folder on upload field
        $field->relationAutoSetting = false; // Prevents the form thinking the GalleryPage is the underlying object
        $field->setFolderName('Uploads/Images');

        $actions = new FieldList(new FormAction('addItem', 'Add Item'));
        return new Form($this, 'AddItemForm', $fields, $actions, null);
    }

    public function addItem($data, $form) {
    	$shop = DataObject::get_by_id('Shop', $data["ShopID"]);

        $item = new Item();
        $item->ShopID = $shop->ID;
        $form->saveInto($item);
        $item->write();

        return $this->redirectBack();    
    }

    public function EditShopBioForm() {
        $shop = $this->getShop();

        $fields = new FieldList(
            $field = new TextField('Title', 'Shop Title', $shop->Title, 255),
            $field = new TextField('ShopURL', 'Shop URL', $shop->ShopURL),
            $field = new EmailField('ShopEmail', 'Shop Email', $shop->ShopEmail),
            $field = new TextAreaField('Bio', 'Add Bio', $shop->Bio),
            new HiddenField('ShopID', null, $shop->ID)
        );

        $actions = new FieldList(new FormAction('editShopBio', 'Save Bio'));
        return new Form($this, 'EditShopBioForm', $fields, $actions, null);
    }

    public function editShopBio($data, $form) {
        $shop = DataObject::get_by_id('Shop', $data["ShopID"]);

        $shop->Title = $data["Title"];
        $shop->ShopURL = $data["ShopURL"];
        $shop->ShopEmail = $data["ShopEmail"];
        $shop->Bio = $data["Bio"];
        $shop->write();

        return $this->redirectBack();
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
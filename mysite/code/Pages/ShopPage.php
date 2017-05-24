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
        'search',
        'viewSingleItem',
        'viewEditSingleItem',
        'editSingleItem',
        'removeItem',
        'deleteShop',
        'NewGalleryForm',
        'editImages',
        'addCategory',
        'searchItem'
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

            $paginatedGalleries = false;
            if($galleries = $shop->Gallery()) {
                $paginatedGalleries = PaginatedList::create(
                    $galleries,
                    $request
                )->setPageLength(20)
                 ->setPaginationGetVar('items');
            }
            
            $paginatedItems = false;
            if($items = $shop->Item()) {
                $paginatedItems = PaginatedList::create(
                    $items,
                    $request
                )->setPageLength(20)
                 ->setPaginationGetVar('shops');
            }

            $recentUploadsArray = new ArrayList();
            if($sessionarray = Session::get("ImageUploads")) {
                foreach($sessionarray as $imageID) {
                    $recentUploadsArray->push(new ArrayData(array('Image' => Image::get()->byId($imageID))));
                }
            }

            $data = array (
                'Galleries' => $paginatedGalleries,
                'Items' => $paginatedItems,
                'Shop' => $shop,
                'recentUploads' => $recentUploadsArray
            );

            if($request->isAjax()) {
                if($items = $request->getVar('items') || $request->getVar('objects') == "items") {
                    $data = array (
                        'Items' => $paginatedItems,
                        'Shop' => $shop
                    );
                    return $this->Customise($data)->renderWith('Shop_Items');
                } else if($galleries = $request->getVar('galleries') || $request->getVar('objects') == "galleries") {
                    $data = array (
                        'Galleries' => $paginatedGalleries,
                        'Shop' => $shop
                    );
                    return $this->Customise($data)->renderWith('Shop_Galleries');
                }
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

        Session::set('ImageUploads', array());

        foreach($data["Image"]["Files"] as $imageID) {
            Session::add_to_array('ImageUploads', $imageID);
        }
        Session::save();

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

        foreach($data["Image"]["Files"] as $imageID) {
            Session::add_to_array('ImageUploads', $imageID);
        }
        Session::save();

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

    public function viewSingleItem(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $item = DataObject::get_by_id('Item', $request->getVar('itemID'));
            $imageArray = array();
            foreach($item->Image() as $image) {
                array_push($imageArray, $image->URL);
            }
            return json_encode(array("title" => $item->Title, "description" => $item->Description, "price" => $item->Price, "imageURLS" => $imageArray));
        } else {
            return null;
        }
    }

    public function viewEditSingleItem(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $item = DataObject::get_by_id('Item', $request->getVar('itemID'));
            $imageArray = array();
            foreach($item->Image() as $image) {
                array_push($imageArray, $image->URL);
            }
            return json_encode(array("title" => $item->Title, "description" => $item->Description, "price" => $item->Price));
        } else {
            return null;
        }
    }

    public function editSingleItem(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $requestBody = json_decode($request->getBody(), true);
            foreach($requestBody as $itemRequest) {
                $item = Item::get()->byId($itemRequest["id"]);

                if($itemTitle = $itemRequest["title"]) {
                    $item->Title = ucfirst($itemTitle);
                }
                if($itemDesc = $itemRequest["description"]) {
                    $item->Description = ucfirst($itemDesc);
                }
                if($itemPrice = $itemRequest["price"]) {

                    if (strpos($itemPrice, '.') !== false) {
                        $item->Price = $itemPrice;
                    } else {
                        $item->Price = $itemPrice.".00";
                    }
                    
                }
                $item->write();
            }
            return true;
        } else {
            return null;
        }
    }


    public function removeItem(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $item = DataObject::get_by_id('Item', $request->getVar('itemID'));
            $item->delete();

            return true;
        } else {
            return null;
        }
    }

    public function deleteShop(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $shop = DataObject::get_by_id('Shop', $request->getVar('shopID'));
            foreach($shop->Item() as $item) {
                $item->delete();
            }

            $shop->delete();

            return true;
        } else {
            return null;
        }
    }

    public function NewGalleryForm() {
        $shop = $this->getShop();
        $fields = new FieldList(
            new TextField('Title', 'Gallery Title', null, 255),
            $field = new UploadField('Image', 'Upload Image'),
            new HiddenField('ShopID', null, $shop->ID)
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
        $shop = DataObject::get_by_id('Shop', $data["ShopID"]);

        $gallery = new Gallery();
        $gallery->ShopID = $shop->ID;
        $form->saveInto($gallery);
        $gallery->write();
        
        Session::set('ImageUploads', array());

        foreach($data["Image"]["Files"] as $imageID) {
            Session::add_to_array('ImageUploads', $imageID);
        }
        Session::save();
        
        return $this->redirectBack();
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

    public function addCategory(SS_HTTPRequest $request) {
        if (Director::is_ajax()){
            $shop = DataObject::get_by_id('Shop', $request->getVar('shopID')); 
            $category = $request->getVar('category');   
            if($categories = DataObject::get_one('Category', "Category = '".$category."' AND ShopID = '".$shop->ID."'")) {
                return null;
            } else {
                $newCat = new Category();
                $newCat->Category = $category;
                $newCat->write();
                $shop->Category()->add($newCat);
            }
            return json_encode($category);
        } else {
            return null;
        }
    }

    public function searchItem(SS_HTTPRequest $request) {
        $shop =  DataObject::get_one('Shop', "ID = '".$request->getVar('shopID')."'"); 
        if (Director::is_ajax()){
            $items = $shop->Item();
            $sort = $request->getVar('sort');
            $search = $request->getVar('search');
            if($search == "null") {
                Session::clear('Search');
                Session::save();
                $itemSet = $shop->Item();

                $items = new ArrayList();

                foreach ($itemSet as $item) {
                    $items->push($item);
                }
               
            } else {
                $searchArray = explode(" ", $search);
                $explodedSearchArray = array_map('trim', $searchArray);
                Session::clear('Search');
                Session::save();
                Session::set('Search', $explodedSearchArray);
                Session::save();

                $items = new ArrayList();

                foreach($explodedSearchArray as $searchItem) {
                    $itemSet = Item::get()->filter(array('Title:PartialMatch' => $searchItem));

                    foreach ($itemSet as $item) {
                        if($item->ShopID == $shop->ID) {
                            $items->push($item);
                        }
                    }
                }
                $items->removeDuplicates(); 
            }   

            switch ($sort) {
                case "Relevance":

                    break;
                case "Price: Lowest to Highest":
                    $mappedArray = $items->map('ID', 'Price');
                    asort($mappedArray);
                    $items = new ArrayList();
                    foreach ($mappedArray as $key => $itemPrice) {
                        $pricedItem = DataObject::get_one('Item', "ID = '".$key."'");
                        $items->push($pricedItem);
                    }
                    break;
                case "Price: Highest to Lowest":
                    $mappedArray = $items->map('ID', 'Price');
                    arsort($mappedArray);
                    $items = new ArrayList();
                    foreach ($mappedArray as $key => $itemPrice) {
                        $pricedItem = DataObject::get_one('Item', "ID = '".$key."'");
                        $items->push($pricedItem);
                    }
                    break;
            }       

            $paginatedItems = PaginatedList::create(
                $items,
                $request
            )->setPageLength(20)
             ->setPaginationGetVar('shops');

            $data = array (
                'Items' => $paginatedItems,
                'Shop' => $shop
            );
            return $this->Customise($data)->renderWith('Shop_Items');
        } else {
            return null;
        }
    }


}
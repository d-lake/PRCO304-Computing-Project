<?php
class Gallery extends DataObject {    
    private static $db = array(
        'Title' => 'Varchar(255)'
    );

    private static $many_many = array(
        'Image' => 'Image'
    );

    private static $has_one = array(
        'Member' => 'Member',
        'Shop' => 'Shop',
        'GalleryPage' => 'GalleryPage'
    );

    private static $defaults = array (
        'GalleryPageID' => 6,
        'Title' => 'Gallery'
    );

    public function Link() {
        if($galleryPage = $this->GalleryPage()) {
            $action = 'view/' . $this->ID;
            return $galleryPage->Link($action);    
        }
    }

    public function firstImage() {
        return $this->Image()->First();
    }

    public function ifFavouritesGallery() {
        if($this->Title == "Favourites") {
            return true;
        } else {
            return false;
        }
    }
}
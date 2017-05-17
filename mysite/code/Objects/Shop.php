<?php
class Shop extends DataObject {    
    private static $db = array(
        'Title' => 'Varchar(255)',
        'ShopEmail' => 'Varchar(255)',
        'ShopURL' => 'Varchar(255)',
        'Bio' => 'Text'
    );

    private static $has_one = array(
        'Member' => 'Member',
        'ShopPage' => 'ShopPage',
        'ShopProfilePicture' => 'ShopProfilePicture',
        'ShopCoverPicture' => 'ShopCoverPicture'
    );

    private static $has_many = array(
        'Item' => 'Item'
    );

    private static $defaults = array (
        'ShopPageID' => 9
    );

    public function Link() {
        if($shopPage = $this->ShopPage()) {
            $action = 'view/' . $this->ID;
            return $shopPage->Link($action);    
        }
    }

    public function firstImage() {
        return $this->ShopProfilePicture()->Image();
    }
}
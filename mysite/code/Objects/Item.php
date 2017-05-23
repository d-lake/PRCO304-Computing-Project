<?php
class Item extends DataObject {    
    private static $db = array(
        'Title' => 'Varchar(255)',
        'Description' => 'Varchar(255)',
        'Price' => 'Varchar(255)'
    );

    private static $many_many = array(
        'Image' => 'Image',
        'Category' => 'Category'
    );

    private static $has_one = array (
        'Shop' => 'Shop'
    );

    public function firstImage() {
        return $this->Image()->First();
    }
}
<?php
class Category extends DataObject {    
    private static $db = array(
        'Category' => 'Varchar(255)'
    );

    private static $belongs_many_many = array(
        'Item' => 'Item'
    );

    private static $has_one = array(
        'Shop' => 'Shop',
    );
}
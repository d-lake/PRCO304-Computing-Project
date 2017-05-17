<?php
class ShopCoverPicture extends DataObject {  
    private static $has_one = array (
        'Image' => 'Image'
    );

    private static $belongs_to = array(
        'Shop' => 'Shop'
    );
}
<?php
class MemberCoverPicture extends DataObject {  
    private static $has_one = array (
        'Image' => 'Image'
    );

    private static $belongs_to = array(
    	'Member' => 'Member'
    );
}
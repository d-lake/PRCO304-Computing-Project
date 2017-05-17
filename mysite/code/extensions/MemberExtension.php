<?php

class MemberExtension extends DataExtension {

    private static $db = array(
        'UserName' => 'Varchar',
        'Bio' => 'Text'
    );

    private static $has_one = array (
        'MemberPage' => 'MemberPage',
        'MemberProfilePicture' => 'MemberProfilePicture',
        'MemberCoverPicture' => 'MemberCoverPicture'
    );

    private static $has_many = array (
        'Gallery' => 'Gallery',
        'Shop' => 'Shop',
        'Connection' => 'Connection'
    );

    private static $defaults = array (
        'MemberPageID' => 8
    );

    public function Link() {
        if($memberPage = $this->owner->MemberPage()) {
            $action = 'view/' . $this->owner->ID;
            return $memberPage->Link($action);    
        }
    }
}
<?php
class Connection extends DataObject {    
    private static $db = array(
        'MemberConnectionID' => 'Int',
        'Status' => 'Varchar(255)'
    );

    private static $has_one = array (
        'Member' => 'Member'
    );

    public function connectedMember() {
        $connectedMember = DataObject::get_by_id('Member', $this->MemberConnectionID);
        return $connectedMember;
    }

    public function memberImage() {
        $connectedMember = DataObject::get_by_id('Member', $this->MemberConnectionID);
        return $connectedMember->MemberProfilePicture()->Image();
    }

    public function Link() {
        $connectedMember = DataObject::get_by_id('Member', $this->MemberConnectionID);

        if($memberPage = $connectedMember->owner->MemberPage()) {
            $action = 'view/' . $connectedMember->owner->ID;
            return $memberPage->Link($action);    
        }
    }
}
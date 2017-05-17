<?php
class ImageExtension extends DataExtension {

	private static $db = array(
		'Description' => 'Text',
        'Privacy' => 'Boolean(1)'
	);

    private static $belongs_many_many = array(
        'Gallery' => 'Gallery',
    	'Item' => 'Item'
    );

    private static $many_many = array(
        'Tag' => 'Tag'
    );

    private static $has_many = array(
    	'MemberProfilePicture' =>'MemberProfilePicture',
    	'MemberCoverPicture' => 'MemberCoverPicture',
    	'ShopProfilePicture' =>'ShopProfilePicture',
    	'ShopCoverPicture' => 'ShopCoverPicture'
    ); 

    function getCustomFields() {
        $fields = new FieldList();
        $fields->push(new TextField('Title', 'Title'));
        $fields->push(new TextareaField('Description', 'Description'));
        return $fields;
    }
}
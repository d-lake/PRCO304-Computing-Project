<?php
class Tag extends DataObject {    
    private static $db = array(
        'Tag' => 'Varchar(255)'
    );
    private static $belongs_many_many = array(
        'Image' => 'Image'
    );
}
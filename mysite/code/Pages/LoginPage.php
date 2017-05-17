<?php
class LoginPage extends Page {

	private static $db = array(
	);

	private static $has_one = array(
	);

}
class LoginPage_Controller extends Page_Controller {

	private static $allowed_actions = array(
        'RegisterForm'
    );

	public function init() {
		parent::init();
	}

    public function index(SS_HTTPRequest $request) {
        return $this;
    }

	public function RegisterForm() {
        $fields = new FieldList(
            new EmailField('Email', 'Email <span class="required_field">*</span>'),
            new TextField('UserName', 'User Name <span class="required_field">*</span>'),
            new ConfirmedPasswordField('Password', 'Password <span class="required_field">*</span>')
        );

        $actions = new FieldList(
            new FormAction('doRegister', 'Register')
        );

        $validator = new RequiredFields('UserName', 'Email', 'Password');

        return new Form($this, 'RegisterForm', $fields, $actions, $validator);
    }

   public function doRegister($data, $form) {
    	if($member = DataObject::get_one("Member", "`Email` = '". Convert::raw2sql($data['Email']) . "'")) {
            $form->AddErrorMessage('Email', "Sorry, that email address already exists. Please choose another.", 'bad');
            Session::set("FormInfo.Form_RegistrationForm.data", $data);     
            return $this->redirectBack();           
        } else if($member = DataObject::get_one("Member", "`UserName` = '". Convert::raw2sql($data['UserName']) . "'")) {
            $form->AddErrorMessage('UserName', "Sorry, that user name has already been taken. Please choose another.", 'bad');
            Session::set("FormInfo.Form_RegistrationForm.data", $data);     
            return $this->redirectBack();           
        } else {
            $Member = new Member();
            $form->saveInto($Member);          
            $Member->write();

            if(!$userGroup = DataObject::get_one('Group', "Code = 'registered-users'")){
                $userGroup = new Group();
                $userGroup->Code = "registered-users";
                $userGroup->Title = "Users";
                $userGroup->Write();
                $userGroup->Members()->add($Member);
            }

            $userGroup->Members()->add($Member);

            $galleryNames = array("Favourites", "Profile Pictures", "Cover Pictures");

            foreach ($galleryNames as $name) {
                $gallery = new Gallery();
                $gallery->MemberID = $Member->ID;
                $gallery->Title = $name;
                $gallery->write();
            }

            $Member->login();

            return $this->redirect('/');
        }
   }
}

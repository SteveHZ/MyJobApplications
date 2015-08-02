package MyJobApplications::Form::HomeForm;
 
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => ( default =>'JobApplication' );
has_field 'jobtitle' => ( minlength => 1, maxlength => 40, required => 1 );
has_field 'company' => ( minlength => 1, maxlength => 40, required => 1 );
has_field 'applied' => ( type => 'Date', label_column => 'last_name', required => 1 );
has_field 'website' => ( minlength => 1, maxlength => 256, required => 1 );
has_field 'notes' => ( maxlength => 256 );
has_field 'Add' => ( type => 'Submit', value => 'Add' );
 
__PACKAGE__->meta->make_immutable;
1;
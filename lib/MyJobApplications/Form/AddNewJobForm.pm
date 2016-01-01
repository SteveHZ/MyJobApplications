package MyJobApplications::Form::AddNewJobForm;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use namespace::autoclean;

has '+item_class' => ( default =>'JobApplication' );
has_field 'jobtitle' => ( label => 'Job Title', minlength => 1, maxlength => 40, required => 1 );
has_field 'company' => ( minlength => 1, maxlength => 40);
has_field 'applied' => ( type => 'Date', required => 1 );
has_field 'website' => ( minlength => 1, maxlength => 256, required => 1 );
has_field 'notes' => ( maxlength => 256 );
has_field 'Add' => ( type => 'Submit', value => 'Add' );

sub validate_applied {
	my ($self, $field) = @_;
	
	unless ($field->value =~ date_regex ()) {
		$field->add_error ("Date should be in YYYY-MM-DD format !!!");
	}
}

sub validate_jobtitle {
	my ($self, $field) = @_;

	unless ($field->value =~ string_regex ()) {
		$field->add_error ("Please provide a job title !!!");
	}
}

sub date_regex {
	qr /
	\d{4}-\d{2}-\d{2}
	/x;
}

sub string_regex {
	qr /\w/;
}

__PACKAGE__->meta->make_immutable;
1;
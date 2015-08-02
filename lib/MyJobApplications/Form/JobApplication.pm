package MyJobApplications::Form::JobApplication;

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

sub validate_jobtitle {
	my $self = shift;

	unless ($self->value =~ /\w/) {
		$self->add_error ("Please provide a job title !!!");
	}
}

sub validate_applied {
	my $self = shift;
	
	unless ($self->value =~ /\d{4}-\d{2}-\d{2}/) {
		$self->add_error ("Date should be in YYYY-MM-DD format !!!");
	}
}

__PACKAGE__->meta->make_immutable;
1;
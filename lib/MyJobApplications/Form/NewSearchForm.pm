package MyJobApplications::Form::NewSearchForm;

use HTML::FormHandler::Moose;
extends 'HTML::FormHandler';
use namespace::autoclean;

has_field 'ToSearch' => ( type => 'Select', widget => 'RadioGroup', name => 'ToSearch', label => '', default => 'jobtitle',);
has_field 'SearchOption' => ( type => 'Select', label => '',);
has_field 'SearchFor' => ( type => 'Text', required => 1,
#	apply => [ {transform => sub { return uc($_[0]) }} ]
);
has_field 'OrderBy' => ( type => 'Select', );
has_field 'Order' => ( type => 'Select', );

has_field 'Submit' => ( type => 'Submit', value => 'Submit' );

sub validate_SearchFor {
	my ($self, $field) = @_;
	
	if ($self->field ('ToSearch')->value eq 'applied') {
		unless ($field->value =~ /\d{4}-\d{2}-\d{2}/) {
			$field->add_error ("Please use YYYY-MM-DD format for dates");
		}
	}
}

sub options_ToSearch {
	return (
		'jobtitle' => 'Job Title',
		'company' => 'Company',
		'applied' => 'Applied',
		'notes' => 'Notes',
	);
}

sub options_SearchOption {
	return (
		'<' => 'Less than',
		'=' => 'Equal to',
		'>' => 'Greater than',
		'LIKE' => 'Similar to',
	);
}

sub options_OrderBy {
	return (
		'jobtitle' => 'Job Title',
		'company' => 'Company',
		'applied' => 'Applied',
	);
}

sub options_Order {
	return (
		'asc' => 'Ascending',
		'desc' => 'Descending',
	);
}

__PACKAGE__->meta->make_immutable;
1;
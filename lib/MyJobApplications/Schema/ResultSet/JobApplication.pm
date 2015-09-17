package MyJobApplications::Schema::ResultSet::JobApplication;

use strict;
use warnings;
use base 'DBIx::Class::ResultSet';

=head2 search_for
=cut

sub search_for {
	my ($self, $field, $cmp, $data) = @_;
   
	if (lc ($cmp) eq "like") {
		return $self->search ({
			$field => { $cmp => "%$data%" }
		});
	} else {
		return $self->search ({
			$field => { $cmp => uc ($data) }
		});
	}
}

=head2 order_by
=cut

sub order_by {
	my ($self, $orderby, $order) = @_;
	
	return $self->search (
	{},{
		order_by => { -$order => $orderby },
	});
}

1;
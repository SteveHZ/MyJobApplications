package MyJobApplications::Controller::MyJobApplications;
use Moose;
use namespace::autoclean;
use DateTime;

use MyJobApplications::Form::AddNewJobForm;
use MyJobApplications::Form::NewSearchForm;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

MyJobApplications::Controller::MyJobApplications - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.
v1.0 10-14/06/15

=head1 METHODS

=cut

=head2 index
=cut

sub index :Path Args(0) {
    my ( $self, $c ) = @_;
	$c->response->redirect ($c->uri_for ( $self->action_for ('home')));
}

=head2 base
=cut

sub base :Chained('/') PathPart('myjobapplications') CaptureArgs(0) {
	my ($self, $c) = @_;

	$c->stash ( resultset => $c->model ('DB::JobApplication'));
	$c->load_status_msgs;
}

=head2 object
=cut

sub object :Chained('base') :PathPart('') :CaptureArgs(1) {
	my ($self, $c, $id) = @_;
	
	$c->stash ( object => $c->stash->{resultset}->find ($id),
				id => $id,
	);
	
	die "Object $id not found !" if ! $c->stash->{object};
}

=head2 home
=cut

sub home :Chained('base') PathPart('home') Args(0) {
	my ($self, $c) = @_;

	$c->stash ( template => 'Home.tt2');
}

=head2 showAll
=cut

sub showAll :Chained('base') PathPart('showAll') Args(2) {
	my ($self, $c, $orderby, $order) = @_;

	$c->stash ( template => 'ShowAll.tt2',
				data =>	[ $c->stash->{resultset}
							->order_by ($orderby, $order)
				],
	);
}

=head2 search
=cut

sub search :Chained('base') PathPart('search') Args(0) {
	my ($self, $c) = @_;

	$c->stash ( template => 'search_form.tt2',
				form => MyJobApplications::Form::NewSearchForm->new,
				object => $c->stash->{resultset},
	);
	return $self->do_searchform ($c);
}

sub do_searchform {
    my ($self, $c) = @_;
 
    my $form = $c->stash->{form};
	
	$form->process(	item => $c->stash->{object},
					params => $c->req->params,
					action => $c->uri_for ($self->action_for ('new_do_search')),
	);
    return unless $form->validated;

}

sub new_do_search :Chained('base') PathPart('new_do_search') Args(0) {
	my ($self, $c) = @_;
	
	my $toSearch = $c->request->params->{ToSearch};
	my $searchOption = $c->request->params->{SearchOption};
	my $searchFor = $c->request->params->{SearchFor};
	my $orderBy = $c->request->params->{OrderBy};
	my $order = $c->request->params->{Order};

	$c->stash (	template => 'SearchResults.tt2',
				data => [ $c->stash->{resultset}
								->search_for ($toSearch, $searchOption, $searchFor)
								->order_by ($orderBy, $order)
				],
	);
}	

=head2 delete
called from ShowAll.tt2
=cut

sub delete :Chained('object') PathPart('delete') Args(0) {
	my ($self, $c) = @_;

	my $id = $c->stash->{id};
	$c->stash->{object}->delete;
	
	$c->response->redirect( $c->uri_for (
							$self->action_for ('showAll'), [qw /applied desc/],
							{ mid => $c->set_status_msg ("Deleted Job ID $id") }
	));
}

=head2 newJob
Use HTML::FormHandler to add a new job application
=cut
 
sub newJob :Chained('base') PathPart('newJob') Args(0) {
    my ($self, $c ) = @_;
 
	$c->stash ( template => 'form.tt2',
				form => MyJobApplications::Form::AddNewJobForm->new,
				object => $c->stash->{resultset}->new_result({}),
	);

	return $self->form ($c, "New job added !!!");
}

=head2 edit
Edit an existing entry with HTML::FormHandler
=cut
 
sub edit :Chained('object') PathPart('edit') Args(0) {
    my ($self, $c) = @_;
 
	$c->stash (	template => 'edit_form.tt2',
				form => MyJobApplications::Form::AddNewJobForm->new,
	);

    return $self->form ($c, "Job edited !!!");
} 

=head2 form
Process the HTML::FormHandler form
=cut
 
sub form {
    my ($self, $c, $msg ) = @_;
 
    my $form = $c->stash->{form};
	
	$form->process(	item => $c->stash->{object},
					params => $c->req->params,
	);
    return unless $form->validated;

    $c->response->redirect ($c->uri_for (
							$self->action_for ('showAll'), [qw /applied desc/],
							{ mid => $c->set_status_msg ($msg) }
	));
}

=head1
sub search :Chained('base') PathPart('search') Args(0) {
	my ($self, $c) = @_;

	$c->stash ( template => 'SearchForm.tt2');
}

=head2 do_search
called from SearchForm.tt2
#=cut

sub do_search :Chained('base') PathPart('do_search') Args(0) {
	my ($self, $c) = @_;
	
	my $toSearch = $c->request->params->{ToSearch};
	my $searchOption = $c->request->params->{SearchOption};
	my $searchFor = $c->request->params->{SearchFor};
	my $orderBy = $c->request->params->{OrderBy};
	my $order = $c->request->params->{Order};

	$c->stash (	template => 'SearchResults.tt2',
				data => [ $c->stash->{resultset}
								->search_for ($toSearch, $searchOption, $searchFor)
								->order_by ($orderBy, $order)
				],
	);
}	
=cut
=encoding utf8

=head1 AUTHOR

A clever guy

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;

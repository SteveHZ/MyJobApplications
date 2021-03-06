use utf8;
package MyJobApplications::Schema::Result::JobApplication;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

MyJobApplications::Schema::Result::JobApplication

=cut

use strict;
use warnings;

use Moose;
use MooseX::NonMoose;
use MooseX::MarkAsMethods autoclean => 1;
extends 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<jobapplications>

=cut

__PACKAGE__->table("jobapplications");

=head1 ACCESSORS

=head2 jobno

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 jobtitle

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 company

  data_type: 'varchar'
  is_nullable: 1
  size: 64

=head2 applied

  data_type: 'date'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 website

  data_type: 'text'
  is_nullable: 1

=head2 notes

  data_type: 'varchar'
  is_nullable: 1
  size: 256

=cut

__PACKAGE__->add_columns(
  "jobno",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "jobtitle",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "company",
  { data_type => "varchar", is_nullable => 1, size => 64 },
  "applied",
  { data_type => "date", datetime_undef_if_invalid => 1, is_nullable => 1 },
  "website",
  { data_type => "text", is_nullable => 1 },
  "notes",
  { data_type => "varchar", is_nullable => 1, size => 256 },
);

=head1 PRIMARY KEY

=over 4

=item * L</jobno>

=back

=cut

__PACKAGE__->set_primary_key("jobno");


# Created by DBIx::Class::Schema::Loader v0.07042 @ 2015-11-26 19:44:01
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:70lT5y0WSQNsj533KKKG5w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
__PACKAGE__->meta->make_immutable;
1;

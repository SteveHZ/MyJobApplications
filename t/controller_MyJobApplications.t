use strict;
use warnings;
use Test::More;


use Catalyst::Test 'MyJobApplications';
use MyJobApplications::Controller::MyJobApplications;

ok( request('/myjobapplications')->is_success, 'Request should succeed' );
done_testing();

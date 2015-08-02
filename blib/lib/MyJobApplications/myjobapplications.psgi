use strict;
use warnings;

use MyJobApplications;

my $app = MyJobApplications->apply_default_middlewares(MyJobApplications->psgi_app);
$app;


#!perl

use 5.010;
use strict;
use warnings;
use Test::More 0.98;

use Data::Clean::FromJSON::Pregen qw(clean_from_json_in_place clone_and_clean_from_json);
use Scalar::Util qw(blessed);

unless (defined &Data::Clean::FromJSON::Pregen::clean_from_json_in_place) {
    plan skip_all => 'clean_from_json_in_place() not yet generated';
}

my $data;
my $cdata;

$cdata = clean_from_json_in_place({
    int => 1,
    str => "abc",
    array => [1,2],
    hash => {a=>1},
    undef => undef,
    bool => bless('JSON::PP::Boolean', \1),
});
is_deeply($cdata, {
    int => 1,
    str => "abc",
    array => [1,2],
    hash => {a=>1},
    undef => undef,
    bool => 1,
}, "cleaning up");

{
    my $ref = [];
    $data  = {a=>$ref, b=>$ref};
    $cdata = clone_and_clean_from_json($data);
    #use Data::Dump; dd $data; dd $cdata;
    is_deeply($cdata, {a=>[], b=>[]}, "circular")
        or diag explain $cdata;
}

done_testing;

package Data::Clean::FromJSON::Pregen;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

use Exporter qw(import);
our @EXPORT_OK = qw(
                       clean_from_json_in_place
                       clone_and_clean_from_json
               );

sub _clone {
    if (eval { require Data::Clone; 1 }) {
        Data::Clone::clone(@_);
    } else {
        require Clone::PP;
        Clone::PP::clone(@_);
    }
}

# CODE: require Data::Clean::FromJSON; my $cleanser = Data::Clean::FromJSON->new(); my $src = $cleanser->{_cd}{src}; $src =~ s/\A\s*sub\s*\{//s; $src =~ s/\}(\s*;)?\s*\z//; $src; "# generated with Data::Clean version $Data::Clean::VERSION, Data::Clean::FromJSON version $Data::Clean::FromJSON::VERSION\nsub clean_from_json_in_place { $src }\n";

sub clone_and_clean_from_json {
    my $data = _clone(shift);
    clean_from_json_in_place($data);
}

1;
# ABSTRACT: Clean data from JSON decoder

=head1 SYNOPSIS

 use Data::Clean::FromJSON::Pregen qw(clean_from_json_in_place clone_and_clean_from_json);

 clean_from_json_in_place($data);
 $cleaned = clone_and_clean_from_json($data);


=head1 DESCRIPTION

This has the same functionality as L<Data::Clean::FromJSON> except that the code
to perform the cleaning is pre-generated, so we no longer need L<Data::Clean> or
L<Data::Clean::FromJSON> during runtime.


=head1 FUNCTIONS

None of the functions are exported by default.

=head2 clean_from_json_in_place($data)

=head2 clone_and_clean_from_json($data) => $cleaned


=head1 SEE ALSO

L<Data::Clean::FromJSON>

L<Data::Clean::ForJSON::Pregen> and L<Data::Clean::ForJSON>

=cut
